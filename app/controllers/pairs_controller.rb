class PairsController < ApplicationController

  def new
    @pair = Pair.new
  end

  def create
    # ペアの新規生成
    pair = Pair.new(pair_params)
    pair.save
    
    # 作成したてのペアidをcurrent_userに結びつける
    @user = User.find(current_user.id)
    @user.update(pair_id: pair.id)

    redirect_to root_path
  end

  def edit
  end

  def invite
  end

  def complete
  end

  def confirm
  end


  private

  def pair_params
    params.require(:pair).permit(:name,:motto,:pair_type,:rank)
  end

end
