class PagesController < ApplicationController
  def home
  end

  def users
  end

  def admin
    @users = User.all.sort
  end

  def terminate
    @user = User.find(params[:id])
    if @user.employment_status
      @user.update(employment_status: false)
      redirect_to pages_admin_path
    end
  end
  def activate
    @user = User.find(params[:id])
    if !@user.employment_status
      @user.update(employment_status: true)
      redirect_to pages_admin_path
    end
  end
end
