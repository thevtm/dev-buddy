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
    reversed_match = Match.where(user_a: user_b, user_b: user_a, match: true).first
    if reversed_match
      return match
    end
  end

  private

    def users_must_be_different
      if user_a == user_b
        errors.add(:other_user, "cannot be the same as user")
      end
    end
end
