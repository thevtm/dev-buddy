# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :user_a, class_name: "User"
  belongs_to :user_b, class_name: "User"

  validates :user_a, presence: true, class_name: "User"
  validates :user_b, presence: true, class_name: "User"
  validates :match, presence: true
  validates :users_must_be_different


  private

  def users_must_be_different
    if user_a == user_b
      errors.add(:user_b, "cannot be the same as user_a")
    end
  end

end
