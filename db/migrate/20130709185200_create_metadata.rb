class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.integer :job_id
      t.string :url
      t.string :source_name
      t.text :description

      t.timestamps
    end
  end
end
