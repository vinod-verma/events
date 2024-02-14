require "test_helper"

class VCRTest < Minitest::Test
  def setup
    @campaign = Campaign.create(name: "test campaign")
    @template = Template.create(name: "test template")
    @message = Message.create(name: "test message")
    @admin_user = User.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'admin')
    @user = User.create(email: 'test_user@example.com', password: 'password', password_confirmation: 'password')
  end

  def test_create_event_a
    VCR.use_cassette("get_post") do
      uri = URI('http://localhost:3000/events/create_event')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      # response = Net::HTTP.get_response(URI('https://jsonplaceholder.typicode.com/posts/1'))
      req.body = {
        event: {
          email: @user.email,
          user_id: @user.id,
          data_field: {},
          campaign_id: @campaign.id,
          template_id: @template.id,
          message_id: @message.id,
          event_name: "Event A",
          created_by: @admin_user.id
        }
      }.to_json
      response = http.request(req)
      body = JSON.parse(response.body)
      assert_equal(200,response.code.to_i)
    end
  end

  def test_create_event_b
    VCR.use_cassette("get_post") do
      uri = URI('http://localhost:3000/events/create_event')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      req.body = {
        event: {
          email: @user.email,
          user_id: @user.id,
          data_field: {},
          campaign_id: @campaign.id,
          template_id: @template.id,
          message_id: @message.id,
          event_name: "Event B",
          created_by: @admin_user.id
        }
      }.to_json
      response = http.request(req)
      body = JSON.parse(response.body)
      assert_equal(200,response.code.to_i)
    end
  end

  def test_invalid_event_type
    VCR.use_cassette("get_post") do
      uri = URI('http://localhost:3000/events/create_event')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      req.body = {
        event: {
          email: @user.email,
          user_id: @user.id,
          data_field: {},
          campaign_id: @campaign.id,
          template_id: @template.id,
          message_id: @message.id,
          event_name: "invalid event type",
          created_by: @admin_user.id
        }
      }.to_json
      response = http.request(req)
      body = JSON.parse(response.body)
      assert_equal(422,response.code.to_i)
    end
  end

  def test_invalid_event_type
    VCR.use_cassette("get_post") do
      uri = URI('http://localhost:3000/events/create_event')
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      req.body = {
        event: {
          email: nil,
          user_id: nil,
          data_field: {},
          campaign_id: @campaign.id,
          template_id: @template.id,
          message_id: @message.id,
          event_name: nil,
          created_by: @admin_user.id
        }
      }.to_json
      response = http.request(req)
      body = JSON.parse(response.body)
      assert_equal(422,response.code.to_i)
    end
  end
end
