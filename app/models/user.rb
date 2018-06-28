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

  has_many :matches, class_name: "Match", foreign_key: "user_a_id", dependent: :destroy

  def job_position
  end

  def technology_summary
  end

  MOCK_DATA = {
    job_position: {
      :match_senior => {
        'Senior Software Developer'
      }

      :match_junior => {
        'Junior Ruby on Rails Developer'
      }

      :match_database => {
        'Database Developer'
      }
    },
    technology_summary: {
      :match_senior => {
        languages: %w[C++, C#, Java, Delphi, Visual Basic],
        methodologies: %w[Rapid Application Design (RAD), Spiral Approach],
        software: %w[TIBCO,  Apache, Business Objects],
        systems: %w[Unix, Windows, VAX/VMS, NeXTStep],
        databases: %w[Access, Sybase]
      }
      :match_junior => {
        languages: %w[Ruby, SQL],
        methodologies: %w[Prototyping Approach],
        framework: %w[Rails, Bootstrap],
      }

      :match_database => {
        languages: %w[C++, C#, Java, NodeJS, Visual Basic],
        methodologies: %w[Agile, Waterfall Approach],
        software: %w[Oracle WebLogic Server, Apache],
        systems: %w[Unix, Windows, Net Framework, NeXTStep],
        databases: %w[Oracle, MongoDB, SQL Server]
      }
    }
  }
end
