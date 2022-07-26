# frozen_string_literal: true

# Controller and associated actions for users
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was sucessfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    @user.update(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was sucessfully updated.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed' }
      format.json { head :no_content } # HTTP status code 200 with empty body
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :user_type, { project_ids: [] })
  end
end
