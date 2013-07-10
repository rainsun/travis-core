module Travis
  module Api
    module V1
      module Pusher
        autoload :Build,      'travis/api/v1/pusher/build'
        autoload :Job,        'travis/api/v1/pusher/job'
        autoload :Annotation, 'travis/api/v1/pusher/annotation'
        autoload :Worker,     'travis/api/v1/pusher/worker'
      end
    end
  end
end
