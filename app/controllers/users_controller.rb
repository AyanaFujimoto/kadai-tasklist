class UsersController < ApplicationController
  # before_action :require_user_logged_in
  # before_action :correct_user, only: [:show]
  
  def index
    # @users = User.order(id: :desc).page(params[:page]).per(10)
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order('created_at DESC').page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] ='ユーザを登録しました'
      redirect_to root_path
    else
      flash[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])
    @user_id = current_user.id
    
    if @user.id != @user_id
      flash[:danger] = '他人のタスクリストは閲覧できません'
      redirect_to root_url
    end
  end
end
