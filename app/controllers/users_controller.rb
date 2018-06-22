# frozen_string_literal: true

class UsersController < ApplicationController
  def my_profile
    @user = current_user
    render "show"
  end

  def show
    @user = User.find(params[:id])
  end

  def setting
    @user = current_user
  end
end
