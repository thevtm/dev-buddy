# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    redirect_to :matches if user_signed_in?
  end
end
