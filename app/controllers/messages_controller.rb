class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to @message, alert: "SMS Text sent."
    else
      redirect_to new_message_path, alert: "Error sending SMS text."
    end

  end

  private
    def message_params
    params.require(:message).permit(:user, :number, :text)
    end

    def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
    end

end
