module Travis
  module Api
    module V2
      module Pusher
        class Metadata
          autoload :Created, "travis/api/v2/pusher/metadata/created"
          autoload :Updated, "travis/api/v2/pusher/metadata/updated"

          include Formats

          def initialize(metadata, options = {})
            @metadata = metadata
          end

          def data
            {
              "metadata" => Http::Metadata.new([@metadata]).data["metadata"].first,
            }
          end
        end
      end
    end
  end
end
