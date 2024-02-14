class EmailsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @email = Email.new(email_params)
    if @email.save
      EventMailer.with(user: @email).welcome_email.deliver_later
    end
  end

  private

  def email_params
    params.require(:email).permit(:campaign_id, :recipient_email, :recipient_user_id, data_field: {}, mata_data: {})
  end
end
