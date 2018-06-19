# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :location, :profile_picture)
  end

end
