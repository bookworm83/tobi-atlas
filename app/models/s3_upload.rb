class S3Upload < ApplicationRecord
  belongs_to :attachable, polymorphic: true
end