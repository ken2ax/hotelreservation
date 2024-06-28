class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to mypage_user_path
    else
      render 'edit'
    end
  end

  def mypage
    @user = current_user
  end

  def account
    @user = current_user
  end

  def show_room
    @user = current_user
    @rooms = @user.rooms
  end

  def show_reservation
    @user = current_user
    @reservations = @user.reservations.includes(:room)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
  end
end
