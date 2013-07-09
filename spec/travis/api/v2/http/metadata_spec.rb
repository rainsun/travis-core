require "spec_helper"

describe Travis::Api::V2::Http::Metadata do
  include Travis::Testing::Stubs, Support::Formats

  let(:data) { described_class.new([metadata]).data }

  it "metadata" do
    data["metadata"].first.should eq({
      "id" => metadata.id,
      "job_id" => test.id,
      "description" => metadata.description,
      "url" => metadata.url,
    })
  end
end
