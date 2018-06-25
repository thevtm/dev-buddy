# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users

  validates :name, presence: true
  validates :location, presence: true
  validates :profile_picture, presence: true

  mount_uploader :profile_picture, PhotoUploader
end
