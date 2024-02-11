require 'uri'
require 'net/http'
class HomeController < ApplicationController
  before_action :authenticate_user!

  def new
    @users = User.where(role: 'user').map {|u| [u.email, u.id]}
    @message = Message.all.map {|u| [u.name, u.id]}
    @campaign = Campaign.all.map {|u| [u.name, u.id]}
    @template = Template.all.map {|u| [u.name, u.id]}
    @event = MainEvent.new
  end

  def create
    uri = URI('http://localhost:3000/events/create_event')
    http = Net::HTTP.new(uri.host, uri.port)
    
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    req.body = {
      event: {
        email: User.find(params[:main_event][:user_id]).email,
        user_id: params[:main_event][:user_id],
        data_field: {},
        campaign_id: params[:main_event][:campaign_id],
        template_id: params[:main_event][:template_id],
        message_id: params[:main_event][:campaign_id],
        event_name: params[:commit],
        created_by: current_user.id
      }
    }.to_json
    response = http.request(req)
    body = JSON.parse(response.body)
    if response.code == "200"
      redirect_to root_path, notice: "#{body["event"]}"
    else
      redirect_to root_path, alert: 'Unable to create event'
    end
  end
end
