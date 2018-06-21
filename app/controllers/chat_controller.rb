# frozen_string_literal: true

class ChatController < ApplicationController
  def inbox
    @chat_rooms = current_user.chat_rooms
  end
end
