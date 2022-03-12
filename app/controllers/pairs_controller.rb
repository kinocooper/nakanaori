class PairsController < ApplicationController

  def new
    @pair = Pair.new
  end

  def join
  end

  def pairing
    join_pair_id = params[:pair_id]
    join_keyword = params[:keyword]

    # 入力されたペアIDが存在するか
    if Pair.exists?(id: join_pair_id)
      pair = Pair.find_by(id: join_pair_id)

      # キーワードが正しいか
      if pair.keyword == join_keyword
        # 1 自分のペアカラムを入れる
        person = User.find(current_user.id)
        person.update(pair_id: pair.id)

        # 2 自分のパートナーカラムを入れる
        # そのペアに結びつくuser2件のうち、自分じゃない方を入れる
        partner = User.where(pair_id: pair.id).where.not(id: current_user.id)
        # where句で検索したので、1件しかないけど『ids』でないと出せないっぽい
        # その『0件目』を使う
        person.update(partner_id: partner.ids[0])

        # 3 相方のパートナーカラムを入れる
        person.partner.update(partner_id: person.id)

        redirect_to root_path, notice: 'ペアリングしました！'
      else
        redirect_to join_path, notice: 'キーワードが間違っています'
      end
      
    else
      redirect_to join_path, notice: 'ペアが存在しません'

    end


  end

  def create
    # ペアの新規生成
    pair = Pair.new(pair_params)
    pair.save

    # 作成したてのペアidをcurrent_userに結びつける
    user = User.find(current_user.id)
    user.update(pair_id: pair.id)

    redirect_to root_path
  end

  def edit
    @pair = current_user.pair
  end

  def update
    pair = current_user.pair
    pair.update(pair_params)
    redirect_to root_path
  end

  def invite
  end

  def complete
  end

  def confirm
  end


  private

  def pair_params
    params.require(:pair).permit(:name,:motto,:pair_type,:rank,:keyword)
  end

end
