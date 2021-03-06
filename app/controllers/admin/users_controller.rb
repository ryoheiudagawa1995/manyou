class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @tasks = @user.tasks
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.name}を追加しました。"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.name}を編集しました。"
    else
      flash[:alert] = '編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "#{@user.name}を削除しました。"
    else
      flash[:alert] = '削除出来ません。'
      redirect_to admin_users_path
    end
  end

  private

  def set_admin
    user = current_user
    if user.nil?
      redirect_to tasks_path, notice: 'あなたは管理者ではありません'
    else
      if user.admin == false
        redirect_to new_session_path, notice: 'あなたは管理者ではありません'
      end
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
