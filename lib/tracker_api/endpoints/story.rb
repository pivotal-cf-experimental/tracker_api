module TrackerApi
  module Endpoints
    class Story
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(id)
        data = client.get("/stories/#{id}").body

        Resources::Story.new({ client: client }.merge(data))
      end
    end
  end
end
