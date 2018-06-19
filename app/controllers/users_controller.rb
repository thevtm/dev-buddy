# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
  end

  def new
    @user = User.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end
end
