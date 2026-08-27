require "aws-sdk-s3"

class S3Uploader
  def initialize(file:, attachable:)
    @file = file
    @attachable = attachable
  end

  def call
    key = "uploads/#{SecureRandom.uuid}/#{@file.original_filename}"

    # uploading a file
    S3ClientBuilder.build.put_object(
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
      file_size: @file.size,
      original_filename: @file.original_filename
    )

  end

  private def bucket
    ENV.fetch("MINIO_BUCKET", "tobi-atlas-development")
  end
end

