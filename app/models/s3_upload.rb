require "aws-sdk-s3"

class S3Upload < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  def presigned_url(expires_in: 300)
    presigner = Aws::S3::Presigner.new(client: S3ClientBuilder.build)
    presigner.presigned_url(:get_object, bucket: s3_bucket, key: s3_key, expires_in: expires_in)
  end


end