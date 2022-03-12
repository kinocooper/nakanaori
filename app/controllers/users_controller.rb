class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to root_path, notice:"ユーザ情報を更新しました！"
  end

  def confirm
  end


  private

  def user_params
    params.require(:user).permit(:name,:email,:oko_gauge)
  end
end
