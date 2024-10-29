class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render json: { message: 'User created successfully', user: @user }, status: :created
    else 
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:user][:email])
    if @user
      session[:user_id] = @user.id
      render json: { message: 'Login successful', user: @user }, status: :ok
    else
      render json: {error: 'Invalid Email'}, status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    render json: { message: 'Logout successful' }, status: :ok
  end


end

private

def user_params
  params.require(:user).permit(:email)
end