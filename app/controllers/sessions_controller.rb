class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && uset.authenticate(params[:session][:password])
    else
      render 'new'
    end
  end

  def destroy

  end
end
