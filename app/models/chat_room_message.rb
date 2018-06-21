# frozen_string_literal: true

class ChatRoomMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :message, presence: true, length: { minimum: 1, maximum: 500 }
  validate :user_must_be_in_the_chatroom, on: :create

  private

    def user_must_be_in_the_chatroom
      if ChatRoom.first.users.exists?(user.id) == false
        errors.add(:user, "is not a member of the chat room.")
      end
    end
end
