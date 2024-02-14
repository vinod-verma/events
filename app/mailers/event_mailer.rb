class EventMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.recipient_email, subject: 'Event Created')
  end
end
