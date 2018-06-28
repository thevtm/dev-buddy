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

  def role
    @role ||= MOCK_DATA[:job_position].keys.sample
  end

  def job_position
    MOCK_DATA[:job_position][role]
  end

  def technology_summary
    MOCK_DATA[:technology_summary][role]
  end

  def education
    MOCK_DATA[:education][role]
  end

  def experience
    MOCK_DATA[:experience][role]
  end

  MOCK_DATA = {
    job_position: {
      :match_senior => {
        'Senior Software Developer',
      }

      :match_junior => {
        'Junior Ruby on Rails Developer',
      }

      :match_database => {
        'Database Developer',
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
    },

    education: {
      :match_senior => {
        ['MS in Information Systems - Carnegie-Mellon University', 'BS in Computer Science - Carnegie-Mellon University']
      }

      :match_junior => {
        ['MS in International Business - Boconni University', 'Le Wagon Bootcamp']
      }

      :match_database => {
        ['BS in Information Technology (Database Emphasis) - Mannheim  University']
      }
    },

    experience: {
      :match_senior => {
        ['Director of Software Development, 2014 to Present', 'Senior Software Developer, 2010 to 2014']
      }

      :match_junior => {
        ['Junior Software Developer, 2018 to Present', 'Le Wagon Bootcamp']
      }

      :match_database => {
        ['Database Developer, 2016 to Present', 'Junior Database Developer, 2014 to 2016']
      }
    },
  }
end
