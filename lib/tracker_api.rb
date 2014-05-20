require 'tracker_api/version'

# dependencies
require 'virtus'
require 'faraday'
require 'faraday_middleware'

# stdlib
require 'addressable/uri'
require 'forwardable'
require 'logger'

module TrackerApi
  autoload :Error, 'tracker_api/error'
  autoload :Client, 'tracker_api/client'
  autoload :Logger, 'tracker_api/logger'

  module Errors
    class UnexpectedData < StandardError; end
  end

  module Endpoints
    autoload :Story, 'tracker_api/endpoints/story'
  end

  module Resources
    autoload :Label, 'tracker_api/resources/label'
    autoload :Story, 'tracker_api/resources/story'
  end
end
