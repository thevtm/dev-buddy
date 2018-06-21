# frozen_string_literal: true

class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users

  has_many :messages, class_name: "ChatRoomMessage", foreign_key: "chat_room_id", dependent: :destroy
end
