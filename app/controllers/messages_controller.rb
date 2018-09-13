class MessagesController < ApplicationController

  def create
    render plain: params[:message].inspect
  end

  def new

  end

  private
    def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
    end

end
