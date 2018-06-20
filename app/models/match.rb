# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_a_id"
  belongs_to :other_user, class_name: "User", foreign_key: "user_b_id"

  validates :user_a_id, presence: true
  validates :user_b_id, presence: true
  validates :match, inclusion: { in: [true, false], message: "%{value} must be true or false." }

  validate :users_must_be_different

  private

    def users_must_be_different
      if user == :other_user
        errors.add(:other_user, "cannot be the same as user")
      end
    end
end
