require 'active_storage/service/s3_service'

module ActiveStorage
  class Service::PrefixS3Service < Service::S3Service
    private

    def object_for(key)
      if ENV['AWS_BUCKET_PREFIX'].present?
        bucket.object File.join(ENV['AWS_BUCKET_PREFIX'], key)
      else
        super
      end
    end
  end
end
