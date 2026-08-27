require "aws-sdk-s3"

class S3ClientBuilder
  def self.build
      Aws::S3::Client.new(
        endpoint: ENV.fetch("MINIO_ENDPOINT", "http://localhost:9000"),
        access_key_id: ENV.fetch("MINIO_ROOT_USER", "minioadmin"),
        secret_access_key: ENV.fetch("MINIO_ROOT_PASSWORD", "minioadmin"),
        region: "us-east-1",
        force_path_style: true
      )
  end
end