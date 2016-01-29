class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = find_by_credentials(params[:email], params[:password])
    login!(@user)
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
  end

end
