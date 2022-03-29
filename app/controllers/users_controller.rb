class UsersController < ApplicationController
  before_action :pair_nil_check

  def edit
    @user = current_user
    @pair = current_user.pair
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice:"ユーザ情報を更新しました！"
    else
      @pair = current_user.pair
      render :edit
    end
  end

  def confirm
    @pair = current_user.pair
  end

  def disabling
    user = User.find(current_user.id)
    user.update(is_active: FALSE)

    user.pair.update(is_pair)
  end


  private

  def user_params
    params.require(:user).permit(:name,:email,:oko_gauge)
  end
end
