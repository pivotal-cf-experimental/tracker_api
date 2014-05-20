require_relative 'minitest_helper'
require 'faraday'

describe TrackerApi do
  it 'has a version' do
    ::TrackerApi::VERSION.wont_be_nil
  end
end

describe TrackerApi::Client do
  it 'can be configured' do
    client = TrackerApi::Client.new(url: 'http://test.com',
                                    api_version: '/foo-bar/1',
                                    token: '12345',
                                    logger: LOGGER)

    client.url.must_equal 'http://test.com'
    client.api_version.must_equal '/foo-bar/1'
    client.token.must_equal '12345'
    client.logger.must_equal LOGGER
  end

  describe '.story' do
    let(:pt_user) { PT_USER_1 }
    let(:client) { TrackerApi::Client.new token: pt_user[:token] }
    let(:response_json) {
      <<JSON
{
   "created_at": "2014-05-13T12:00:00Z",
   "current_state": "rejected",
   "description": "ray shielded, that is.",
   "estimate": 3,
   "id": 558,
   "kind": "story",
   "labels":
   [
       {
           "kind": "label",
           "id": 2008,
           "project_id": 99,
           "name": "plans",
           "created_at": "2014-05-13T12:00:00Z",
           "updated_at": "2014-05-13T12:00:00Z"
       }
   ],
   "name": "All exhaust ports should be shielded",
   "owned_by_id": 104,
   "owner_ids":
   [
       104
   ],
   "project_id": 99,
   "requested_by_id": 102,
   "story_type": "feature",
   "updated_at": "2014-05-13T12:00:00Z",
   "url": "http://localhost/story/show/558"
}
JSON
    }

    before do
      stub_request(:get, 'https://www.pivotaltracker.com/services/v5/stories/558').to_return(
        body:response_json,
      )
    end

    it 'gets a story' do
      story = client.story(558)

      story.must_be_instance_of TrackerApi::Resources::Story
      story.id.must_equal 558
      story.project_id.must_equal 99

      story.labels.must_be_instance_of Array
      story.labels.length.must_equal 1
      story.labels.first.must_be_instance_of TrackerApi::Resources::Label
      story.labels.first.id.must_equal 2008
    end
  end
end
