class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  def new
    @user = User.new
  end

  def create
    if params[:user][:password] == params[:user][:password_confirmation]
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to @user
      else
        render :new
      end
    end
  end

  def show
    @user = User.find_by(id: session[:user_id])
    if @user.sap_requests.empty?
      redirect_to new_user_sap_requests_path(@user)
    end
    @pantries = @user.sap_requests
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
