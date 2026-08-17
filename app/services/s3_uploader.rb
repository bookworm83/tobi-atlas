require "aws-sdk-s3"
class S3Uploader
  def initialize(file:, attachable:)
    @file = file
    @attachable = attachable
  end

  def call
    key = "uploads/#{SecureRandom.uuid}/#{@file.original_filename}"

    # uploading a file
    s3_client.put_object(
      bucket: bucket,
      key: key,
      body: @file.read,
      content_type: @file.content_type
    )

    # writing all info from the upload into the row
    S3Upload.create!(
      attachable: @attachable,
      s3_key: key,
      s3_bucket: bucket,
      content_type: @file.content_type,
      file_size: @file.size
    )

  end

  private
  def s3_client
    Aws::S3::Client.new(
      endpoint: ENV.fetch("MINIO_ENDPOINT", "http://localhost:9000"),
      access_key_id: ENV.fetch("MINIO_ROOT_USER", "minioadmin"),
      secret_access_key: ENV.fetch("MINIO_ROOT_PASSWORD", "minioadmin"),
      region: "us-east-1",
      force_path_style: true
    )
  end

  private
  def bucket
    ENV.fetch("MINIO_BUCKET", "tobi-atlas-development")
  end
end

