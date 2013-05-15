#encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or profile_path
    else
      flash.now[:error] = 'Nesprávna kombinácia mena/hesla.'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
