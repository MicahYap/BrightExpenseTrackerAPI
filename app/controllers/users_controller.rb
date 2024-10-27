class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_expenses_path
    else 
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user
      session[:user_id] = @user.id
      redirect_to user_expenses_path
    else
      render json: {error: 'Invalid Email'}, status: :unprocessable_entity
    end
  end

  def logout
    session[:user.id] = nil
    redirect_to root_path
  end


end

private

def user_params
  params.require(:user).permit(:email)
end