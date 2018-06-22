# frozen_string_literal: true

class ChatRoomUser < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user
end
