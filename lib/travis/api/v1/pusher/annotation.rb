module Travis
  module Api
    module V1
      module Pusher
        class Annotation
          autoload :Created, "travis/api/v1/pusher/annotation/created"
          autoload :Updated, "travis/api/v1/pusher/annotation/updated"

          include Formats

          def initialize(annotation, options = {})
            @annotation = annotation
          end

          def data
            {
              "annotation" => V2::Http::Annotations.new([@annotation]).data["annotations"].first,
            }
          end
        end
      end
    end
  end
end
