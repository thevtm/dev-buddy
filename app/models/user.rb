# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :location, presence: true
  validates :profile_picture, presence: true
end
