class AddMetadataProvidersToMetadata < ActiveRecord::Migration
  def change
    add_column(:metadata, :metadata_provider_id, :integer, null: false)
  end
end
