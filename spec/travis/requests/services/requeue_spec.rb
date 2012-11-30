require 'spec_helper'

describe Travis::Requests::Services::Requeue do
  include Support::ActiveRecord

  let(:user) { User.first || Factory(:user) }

  before :each do
    Travis.config.roles = {}
  end

  describe 'given a job_id' do
    let(:service) { described_class.new(user, job_id: job.id, token: 'token') }
    let(:job)     { Factory(:test, state: :finished) }

    before :each do
      service.stubs(:service).with(:find_job, id: job.id).returns(stub(run: job))
    end

    it 'requeues the job' do
      user.permissions.create!(repository_id: job.repository_id, pull: true)
      job.expects(:requeue)
      service.run
    end

    it 'has message: all cool' do
      user.permissions.create!(repository_id: job.repository_id, pull: true)
      service.run
      service.messages.should == [{ notice: 'The job was successfully requeued.' }]
    end

    it 'has message: missing permissions and can not be enqueued' do
      job.stubs(:requeueable?).returns(false)
      service.run
      service.messages.should == [
        { error: 'You do not seem to have sufficient permissions.' },
        { error: 'This job currently can not be requeued.' }
      ]
    end
  end

  describe 'given a build_id' do
    let(:service) { described_class.new(user, build_id: build.id, token: 'token') }
    let(:build)   { Factory(:build, state: :finished) }

    before :each do
      service.stubs(:service).with(:find_build, id: build.id).returns(stub(run: build))
    end

    it 'requeues the build (given no roles configuration and the user has permissions)' do
      user.permissions.create!(repository_id: build.repository_id, pull: true)
      build.expects(:requeue)
      service.run
    end

    it 'requeues the build (given roles configuration and the user has permissions)' do
      Travis.config.roles.requeue_request = 'push'
      user.permissions.create!(repository_id: build.repository_id, push: true)
      build.expects(:requeue)
      service.run
    end

    it 'does not requeue the build (given no roles configuration and the user does not have permissions)' do
      build.expects(:requeue).never
      service.run
    end

    it 'does not requeue the build (given roles configuration and the user does not have permissions)' do
      Travis.config.roles.requeue_request = 'push'
      build.expects(:requeue).never
      service.run
    end

    describe 'Instrument' do
      let(:publisher) { Travis::Notification::Publisher::Memory.new }
      let(:event)     { publisher.events.last }

      before :each do
        Travis::Notification.publishers.replace([publisher])
      end

      it 'publishes a event' do
        service.run
        event.should publish_instrumentation_event(
          event: 'travis.requests.services.requeue.run:completed',
          message: "Travis::Requests::Services::Requeue#run:completed build_id=#{build.id} not accepted",
          data: {
            type: :build,
            id: build.id,
            accept?: false
          }
        )
      end
    end
  end
end
