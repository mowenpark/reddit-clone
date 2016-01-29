class UsersController < ApplicationController

  def new
    render :new
  end

  def show
    render :show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @user = User.find_by(session_token: session[:session_token])
    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
