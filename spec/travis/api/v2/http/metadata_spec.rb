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
      "image" => nil,
    })
  end

  describe "metadata.image" do
    it "with an image" do
      metadata.stubs(image_url: "https://example.com/image.png", image_alt: "Some image")
      data["metadata"].first["image"].should eq({
        "url" => metadata.image_url,
        "alt" => metadata.image_alt,
      })
    end

    it "without an image" do
      data["metadata"].first["image"].should be_nil
    end
  end
end
