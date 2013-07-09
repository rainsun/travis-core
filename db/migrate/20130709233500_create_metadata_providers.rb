class CreateMetadataProviders < ActiveRecord::Migration
  def change
    create_table :metadata_providers do |t|
      t.string :name
      t.string :api_username
      t.string :api_key

      t.timestamps
    end
  end
end
