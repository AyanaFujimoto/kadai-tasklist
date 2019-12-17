class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if login(email, password)
      flash[:success] = 'ログインに成功しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    Rails.logger.info('in sessions destroy !!!!!!!!!!!!!!!!!')
    Rails.logger.info(session[:user_id])
    session[:user_id] = nil
    Rails.logger.info('session user_id !!!!!!!!!!!!!!!!!')
    Rails.logger.info(session[:user_id])
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      #login success
      session[:user_id] = @user.id
      return true
    else
      #login failed
      return false
    end
  end
end
