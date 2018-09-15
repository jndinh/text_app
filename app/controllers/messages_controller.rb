class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @messages = Message.all
    puts Rails.application.secrets

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
      # Send SMS text
      boot_twilio
      sms = @client.messages.create(
        body: @message.text,
        from: Rails.application.secrets.twilio_number,
        to: @message.number,
      )
      redirect_to @message, alert: "SMS Text sent."
    else
      render 'new'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to messages_path
  end

  def reply
    message_body = params["Body"]
    from_number = params["From"]
    @recent_msg = Message.where(number: from_number).last
    user = @recent_msg.user

    @message = Message.new(user: user, number: from_number, text: message_body)
    if @message.save
      boot_twilio
      sms = @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: from_number,
        body: "Hello from the other side! Your number is #{from_number}."
      )
    end
    head 200, "content_type" => 'text/html'
  end

  private
    def message_params
      params.require(:message).permit(:user, :number, :text)
    end

    def boot_twilio
      account_sid = Rails.application.secrets.twilio_sid
      auth_token = Rails.application.secrets.twilio_token
      @client = Twilio::REST::Client.new(account_sid, auth_token)
    end

end
