class EmailsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    email = Email.create(email_params)
    # if email.save
    #   render json: { email: 'Send successfully'}, status: :ok
    # end
  end

  private

  def email_params
    params.require(:email).permit(:campaign_id, :recipient_email, :recipient_user_id, data_field: {}, mata_data: {})
  end
end
