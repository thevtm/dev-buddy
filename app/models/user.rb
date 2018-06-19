# frozen_string_literal: true

class User < ApplicationRecord

  validates :name, presence: true 
  validates :location, presence: true
  validates :profile_picture, presence: true
end
