module Travis
  module Api
    module V2
      module Http
        class Metadata
          include Formats

          def initialize(metadata, options = {})
            @metadata = metadata
          end

          def data
            {
              "metadata" => @metadata.map { |metadata| build_metadata(metadata) },
            }
          end

          private

          def build_metadata(metadata)
            {
              "id" => metadata.id,
              "job_id" => metadata.job_id,
              "description" => metadata.description,
              "url" => metadata.url,
              "image" => build_image(metadata),
            }
          end

          def build_image(metadata)
            { "url" => metadata.image_url, "alt" => metadata.image_alt } if metadata.image_url
          end
        end
      end
    end
  end
end
