require "spec_helper"

describe MetadataProvider do
  include Support::ActiveRecord

  let(:provider) { Factory(:metadata_provider) }

  describe ".authenticate_provider" do
    context "given a valid username and key" do
      it "authenticates the provider" do
        MetadataProvider.authenticate_provider(provider.api_username, provider.api_key).should eq(provider)
      end
    end

    context "given an invalid username" do
      it "does not authenticate the provider" do
        MetadataProvider.authenticate_provider("someone-else", provider.api_key).should be_nil
      end
    end

    context "given an invalid key" do
      it "does not authenticate the provider" do
        MetadataProvider.authenticate_provider(provider.api_username, "some-other-key").should be_nil
      end
    end

    context "with an encrypted key" do
      it "authenticates the provider" do
        provider.update_column(:api_key, "encrypted-key")

        Travis::Model::EncryptedColumn.any_instance.stubs(encrypt?: true, key: "abcd", load: "...")
        Travis::Model::EncryptedColumn.any_instance.expects(:load).with("encrypted-key").returns("a-key")

        MetadataProvider.authenticate_provider(provider.api_username, "a-key").should eq(provider)
      end
    end
  end

  describe "#metadata_for_job" do
    let(:job) { Factory(:test) }

    context "given a metadata already exists for the job" do
      it "returns the metadata" do
        metadata = Factory(:metadata, metadata_provider: provider)
        provider.metadata_for_job(metadata.job_id).should eq(metadata)
      end
    end

    context "given no metadata exists yet for the job" do
      it "returns a new metadata object" do
        provider.metadata_for_job(job.id).new_record?.should be_true
      end
    end
  end
end
