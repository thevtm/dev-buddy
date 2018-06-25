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
    @message = ChatRoomMessage.new
  end

  def send_message
    @chat_room = ChatRoom.find(params[:id])

    @message = ChatRoomMessage.new(message_params)
    @message.chat_room = @chat_room
    @message.user = current_user

    @message.save!
  end

  private

    def message_params
      params.require(:chat_room_message).permit(:message)
    end
end
