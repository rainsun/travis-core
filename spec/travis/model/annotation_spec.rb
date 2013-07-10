require "spec_helper"

describe Annotation do
  include Support::ActiveRecord

  let(:annotation) { Factory.build(:annotation) }

  describe "create" do
    it "notifies observers" do
      Travis::Event.expects(:dispatch).with("annotation:created", annotation)
      annotation.save
    end
  end

  describe "update" do
    it "notifies observers" do
      annotation.save
      annotation.description = "Foobarbaz"
      Travis::Event.expects(:dispatch).with("annotation:updated", annotation)
      annotation.save
    end
  end
end
