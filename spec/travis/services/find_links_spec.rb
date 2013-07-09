require "spec_helper"

describe Travis::Services::FindLinks do
  include Support::ActiveRecord

  let(:job) { Factory(:test) }
  let!(:link) { Factory(:link, job: job) }
  let(:service) { described_class.new(params) }

  attr_reader :params

  describe "run" do
    it "finds links by a given list of ids" do
      @params = { ids: [link.id] }
      service.run.should eq([link])
    end

    it "finds links by job_id" do
      @params = { job_id: job.id }
      service.run.should eq([link])
    end
  end
end
