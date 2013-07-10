class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.integer :job_id, null: false
      t.string :url
      t.text :description, null: false
      t.string :image_url
      t.string :image_alt

      t.timestamps
    end
  end
end
