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
      match_senior:         "Senior Software Developer",
      match_junior:         "Junior Ruby on Rails Developer",
      match_database:         "Database Developer",

    },
    technology_summary: {
      match_senior: {
        languages: %w(C++ C# Java Visual_Basic),
        methodologies: %w(Rapid_Application_Design Spiral_Approach),
        software: %w(TIBCO  Apache Business_Objects),
        systems: %w(Unix Windows VAX/VMS NeXTStep),
        databases: %w(Access Sybase)
      },
      match_junior: {
        languages: %w(Ruby SQL),
        methodologies: %w(Prototyping Approach),
        framework: %w(Rails Bootstrap)
      },

      match_database: {
        languages: %w(C++ C# Java NodeJS Visual_Basic),
        methodologies: %w(Agile Waterfall_Approach),
        software: %w(Oracle WebLogic_Server Apache),
        systems: %w(Unix Windows Net Framework NeXTStep),
        databases: %w(Oracle MongoDB SQL Server)
      }
    },

    education: {
      match_senior:         [{ diploma: "MS in Information Systems", school: "Carnegie-Mellon University" }],

      match_junior:         [{ diploma: "MS in International Business", school: "Boconni University" }],

      match_database:         [{ diploma: "BS in Information Technology", school: "Mannheim  University" }],
    },

    experience: {
      match_senior:         [{ position: "Director of Software Development", company: "IBM", time_spend: "2014 to 2016" }],


      match_junior:         [{ position: "Junior Software Developer", company: "Le Wagon", time_spend: "2018 to Present" }],

      match_database:         [{ position: "Database Developer", company: "Oracle", time_spend: "2016 to Present" }],
    },
  }
end
