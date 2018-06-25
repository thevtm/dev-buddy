# frozen_string_literal: true

class ChatController < ApplicationController
  def inbox
    @chat_rooms = current_user.chat_rooms
  end

  def room
    @chat_room = ChatRoom.find(params[:id])

    # Handle unauthorized user
    render nothing: true, status: :unauthorized unless @chat_room.users.exists?(current_user.id)

    @other_user = @chat_room.users.where.not(id: current_user.id).first
    @other_user_last_message_datetime = DateTime.now
    @message = ChatRoomMessage.new
  end

  def send_message
    @chat_room = ChatRoom.find(params[:id])

    @message = ChatRoomMessage.new(message_params)
    @message.chat_room = @chat_room
    @message.user = current_user

    @message.save!
  end

  def other_messages
    chat_room = ChatRoom.find(params[:id])

    # Handle unauthorized user
    render nothing: true, status: :unauthorized unless chat_room.users.exists?(current_user.id)

    last_message_datetime = DateTime.iso8601(params[:last_message_datetime])

    new_messages = chat_room
      .new_messages(last_message_datetime)
      .where.not(user_id: current_user.id)

    new_last_message_datetime = new_messages.last ? new_messages.last.created_at.iso8601 : last_message_datetime.iso8601

    render json: {
      new_messages: new_messages,
      last_message_datetime: new_last_message_datetime,
    }
  end

  private

    def message_params
      params.require(:chat_room_message).permit(:message)
    end
end
