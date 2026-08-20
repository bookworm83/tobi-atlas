class AddOriginalFilenameToS3Uploads < ActiveRecord::Migration[8.1]
  def change
    add_column :s3_uploads, :original_filename, :string
  end
end
