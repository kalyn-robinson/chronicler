class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy, :restore]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :restore]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = show_deleted(User, params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to Chronicler!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile successfully updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User successfully deleted'
    redirect_to users_url
  end

  def restore
    @user = User.with_deleted.find(params[:id])
    name_taken = find_user_by_name(@user.name.downcase)

    unless name_taken
      @user.restore
      flash[:success] = 'User successfully restored'
    else
      @user.name = User.new_token
      @user.save
      @user.restore
      flash[:success] = 'User successfully restored. Username has been reset.'
    end
    
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
