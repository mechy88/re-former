class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user = User.new(user_params)

    if User.exists?(username: @user.username)
      User.find_by(username: @user.username).update(user_params)
      redirect_to new_user_path
    elsif @user.save
      redirect_to new_user_path
    else
      @errors = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.expect(user: [ :username, :email, :password ])
  end
end
