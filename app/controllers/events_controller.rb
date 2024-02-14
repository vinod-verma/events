require 'uri'
require 'net/http'
class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create_event
    case event_params[:event_name]
    when 'Event A'
      @event = EventA.new(event_params)
    when 'Event B'
      @event = EventB.new(event_params)
    else
      return render json: { event: "Event type is not valid"}, status: :unprocessable_entity
    end
    if @event.save
      if @event.type == 'EventB'
        uri = URI('http://localhost:3000/emails/create')
        http = Net::HTTP.new(uri.host, uri.port)
        
        req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
        req.body = {
          email: {
            campaign_id: @event.campaign_id,
            recipient_email: @event.email,
            recipient_user_id: @event.user_id,
            data_field: {},
            mata_data: {}
          }
        }.to_json
        response = http.request(req)
      end
      render json: { event: "#{@event.event_name} created successfully"}, status: :ok
    end
  end

  private

  def event_params
    params.require(:event).permit(:email, :user_id, :campaign_id, :message_id, :event_name, :template_id, :created_by,  data_field: {})
  end
end
