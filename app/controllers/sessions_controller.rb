class SessionsController < ApplicationController

  def new
    redirect_to 'http://example.smartcitizen.me' if current_user
  end

  def create
    user = User.where("email = ? OR username = ?", params[:username_or_email], params[:username_or_email]).first
    if user && user.authenticate_with_legacy_support(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:user_return_to] || 'http://example.smartcitizen.me'), notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
