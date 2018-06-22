# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :user_a, class_name: "User", foreign_key: "user_a_id"
  belongs_to :user_b, class_name: "User", foreign_key: "user_b_id"

  validates :user_a_id, presence: true
  validates :user_b_id, presence: true
  validates :match, inclusion: { in: [true, false], message: "%{value} must be true or false." }

  validate :users_must_be_different

  def self.swipe_right(user_a, user_b)
    match = Match.new(user_a: user_a, user_b: user_b, match: true)
    match.save!

    its_a_match = Match.where(user_a: user_b, user_b: user_a, match: true).first

    if its_a_match
      ch = ChatRoom.create!()

      ChatRoomUser.create!(chat_room: ch, user: user_a)
      ChatRoomUser.create!(chat_room: ch, user: user_b)

      return match
    end
  end

  private

  def users_must_be_different
    if user_a == user_b
      errors.add(:user_b, "cannot be the same as user")
    end
  end
end
