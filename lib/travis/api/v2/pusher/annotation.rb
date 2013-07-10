module Travis
  module Api
    module V2
      module Pusher
        class Annotation
          autoload :Created, "travis/api/v2/pusher/annotation/created"
          autoload :Updated, "travis/api/v2/pusher/annotation/updated"

          include Formats

          def initialize(annotation, options = {})
            @annotation = annotation
          end

          def data
            {
              "annotation" => Http::Annotations.new([@annotation]).data["annotations"].first,
            }
          end
        end
      end
    end
  end
end
