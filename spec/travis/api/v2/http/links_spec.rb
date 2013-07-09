require "spec_helper"

describe Travis::Api::V2::Http::Links do
  include Travis::Testing::Stubs, Support::Formats

  let(:data) { Travis::Api::V2::Http::Links.new([link]).data }

  it "links" do
    data["links"].first.should eq({
      "id" => link.id,
      "job_id" => test.id,
      "source_name" => link.source_name,
      "description" => link.description,
      "url" => link.url,
    })
  end
end
