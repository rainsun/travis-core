require "spec_helper"

describe Metadata do
  include Support::ActiveRecord

  let(:metadata) { Factory.build(:metadata) }

  describe "create" do
    it "notifies observers" do
      Travis::Event.expects(:dispatch).with("metadata:created", metadata)
      metadata.save
    end
  end

  describe "update" do
    it "notifies observers" do
      metadata.save
      metadata.source_name = "Travis-CI"
      Travis::Event.expects(:dispatch).with("metadata:updated", metadata)
      metadata.save
    end
  end
end
