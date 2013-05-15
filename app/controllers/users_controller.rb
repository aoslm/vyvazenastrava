# encoding: utf-8
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @user = current_user
    if current_user.username == 'admin'
      @users = User.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      render 'profile'
    end
  end

  # GET /users/1
  # GET /users/1.json
  def profile
    @user = current_user

    respond_to do |format|
      format.html # profile.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.rank = 1

    if @user.save
      sign_in @user
      flash[:success] = "Vitaj! Registrácia prebehla úspešne."
      render 'profile'
    else
      render "new"
    end

  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    correct_user
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = 'Detaily boli úspešne zmenené. Prihlás sa s novým heslom.'
      sign_out
      render 'static_pages/home'
    else
      render 'edit'
    end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    correct_user
    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Neautorizovaný prístup k cudziemu účtu!" unless current_user?(@user)
  end
end
