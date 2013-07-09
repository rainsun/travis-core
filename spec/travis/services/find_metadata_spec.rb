require "spec_helper"

describe Travis::Services::FindMetadata do
  include Support::ActiveRecord

  let(:job) { Factory(:test) }
  let!(:metadata) { Factory(:metadata, job: job) }
  let(:service) { described_class.new(params) }

  attr_reader :params

  describe "run" do
    it "finds metadata by a given list of ids" do
      @params = { ids: [metadata.id] }
      service.run.should eq([metadata])
    end

    it "finds metadata by job_id" do
      @params = { job_id: job.id }
      service.run.should eq([metadata])
    end
  end
end
