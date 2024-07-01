class ChatRoomsController < ApplicationController
  def index

  end
  def publish
    @message = params[:message]
    @message = @message.gsub("\n", '<br>')
    # Turbo::StreamsChannel.broadcast_append_to "chaaaat", target: "LogContainer",partial: "chat_rooms/message", locals: { message: @message }
    Turbo::StreamsChannel.broadcast_append_to "chaaaat", target: "LogContainer",content: render_to_string(inline: "<span class='chat-row'>#{@message}</span>")
    head :ok
  end
end
