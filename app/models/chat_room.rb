# frozen_string_literal: true

class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users

  has_many :messages, class_name: "ChatRoomMessage", foreign_key: "chat_room_id", dependent: :destroy

  def self.create_private_chat_room(user_a, user_b)
    chat_room = ChatRoom.create!()

    ChatRoomUser.create!(chat_room: chat_room, user: user_a)
    ChatRoomUser.create!(chat_room: chat_room, user: user_b)
  end

  def last_message
    messages.order(created_at: :desc).first
  end

  def new_messages(datetime)
    messages
      .where("created_at > to_timestamp(?)", datetime.to_time.to_i + 1)
      .order(created_at: :asc)
  end
end
