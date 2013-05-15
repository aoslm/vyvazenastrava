#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :signed_in_user, except: [:home,:help,:about,:news, :create, :new]

  private

  def signed_in_user
    redirect_to signin_url, notice: "Prosím prihláste sa." unless signed_in?
  end

end
