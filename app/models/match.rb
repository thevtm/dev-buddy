# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :user_a, class_name: "User", foreign_key: "user_a_id"
  belongs_to :user_b, class_name: "User", foreign_key: "user_b_id"

  validates :user_a_id, presence: true
  validates :user_b_id, presence: true
  validates :match, inclusion: { in: [true, false], message: "%{value} must be true or false." }

  validate :users_must_be_different

  def self.swipe_left(user_a, user_b)
    Match.create!(user_a: user_a, user_b: user_b, match: false)
  end

  def self.swipe_right(user_a, user_b)
    match = Match.create!(user_a: user_a, user_b: user_b, match: true)

    if match.its_a_match?
      ChatRoom.create_private_chat_room(user_a, user_b)
    end

    match
  end

  def its_a_match?
    return false unless match
    other_match = Match.where(user_a: user_b, user_b: user_a).first
    return false if other_match.nil?
    other_match.match
  end

  private

    def users_must_be_different
      if user_a == user_b
        errors.add(:user_b, "cannot be the same as user")
      end
    end
end
