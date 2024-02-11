require "test_helper"

class VCRTest < Minitest::Test
  def test_fetch_post
    VCR.use_cassette("get_post") do
      uri = URI('http://localhost:3000/events/create_event')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      # response = Net::HTTP.get_response(URI('https://jsonplaceholder.typicode.com/posts/1'))
      req.body = {
        event: {
          email: "test@email.com",
          user_id: 2,
          data_field: {},
          campaign_id: 1,
          template_id: 1,
          message_id: 1,
          event_name: "Event B",
          created_by: 1
        }
      }.to_json
      response = http.request(req)
      body = JSON.parse(response.body)
      assert_equal(200,response.code.to_i)
    end
  end
end