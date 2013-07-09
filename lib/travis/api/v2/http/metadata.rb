module Travis
  module Api
    module V2
      module Http
        class Metadata
          include Formats

          def initialize(metadata)
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
            }
          end
        end
      end
    end
  end
end
