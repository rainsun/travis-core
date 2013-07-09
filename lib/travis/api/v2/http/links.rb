module Travis
  module Api
    module V2
      module Http
        class Links
          include Formats

          def initialize(links)
            @links = links
          end

          def data
            {
              "links" => @links.map { |link| build_link(link) },
            }
          end

          private

          def build_link(link)
            {
              "id" => link.id,
              "job_id" => link.job_id,
              "source_name" => link.source_name,
              "description" => link.description,
              "url" => link.url,
            }
          end
        end
      end
    end
  end
end
