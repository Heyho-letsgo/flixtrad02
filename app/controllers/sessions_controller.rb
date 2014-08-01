class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back #{user.username}!"
      redirect_to user
    else
      #user(params[:email]).nil?
      flash.now[:alert] = "Invalid email/password combination!"
      render :new
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_url, notice: "You're now signed out!"
    end
  end

end
