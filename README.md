# README

This is a demo application to enable activestorage in a rails 5 api-only application, and enable/disable
object key prefix, ie, having folders in the same bucket rather than uploading all the assets to the root bucket.

Steps:
  - Enable activestorage as mentioned in the doc, check first and second commit
  - Add a library `lib/active_storage/service/prefix_s3_service.rb` with the following code:
    
    ```ruby
    # lib/active_storage/service/prefix_s3_service.rb

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

    ```

  - Eager load the libraries from `config/application.rb`

    ```ruby
    # config/application.rb
    config.eager_load_paths << Rails.root.join("lib")

    ```
    
  - Use this service in `config/storage.yml`

    ```yaml
    amazon:
      service: PrefixS3
      access_key_id: <%= ENV['AWS_API_KEY'] %>
      secret_access_key: <%= ENV['AWS_SECRET'] %>
      region: <%= ENV['AWS_REGION'] %>
      bucket: <%= ENV['AWS_BUCKET'] %>

    ```

  - That's It! If any `AWS_BUCKET_PREFIX` key present in `.env`, shall use that, else shall upload the assets in root folder
  