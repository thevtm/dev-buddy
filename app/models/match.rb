# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :user_a_id
  belongs_to :user_b_id
end
