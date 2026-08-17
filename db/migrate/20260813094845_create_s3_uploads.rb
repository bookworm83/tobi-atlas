class CreateS3Uploads < ActiveRecord::Migration[8.1]
  def change
    create_table :s3_uploads do |t|
      t.string :s3_key, null: false
      t.string :s3_bucket, null: false
      t.references :attachable, polymorphic: true, null: false
      t.string :content_type, null: false
      t.integer :file_size, null: false
      t.timestamps
    end
  end
end
