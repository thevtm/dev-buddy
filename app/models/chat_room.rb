# frozen_string_literal: true

class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users

  has_many :messages, class_name: "ChatRoomMessage", foreign_key: "chat_room_id", dependent: :destroy

  def last_message
    messages.order(created_at: :desc).first
  end

  def new_messages(datetime)
    messages
      .where("created_at > to_timestamp(?)", datetime.to_time.to_i + 1)
      .order(created_at: :asc)
  end
end
