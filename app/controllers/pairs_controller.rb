class PairsController < ApplicationController

  before_action :pair_nil_check, only:[:top,:edit,:invite,:complete,:confirm]

  def top
    @pair = current_user.pair
    @discussing_records = current_user.pair.discuss_records.where(is_closed: false).order("created_at DESC").limit(5)
    @closed_records = DiscussRecord.where(pair_id: current_user.pair.id).where(is_closed: true).order("created_at DESC").limit(5)
    @all_tags = current_user.pair.tags

    @y_dates = DiscussRecord.this_year_d_count(current_user.pair)
    @tags_ratio = DiscussRecord.each_tags_count(current_user.pair)
  end

  def introduction
  end

  def new
    @pair = Pair.new
  end

  # 招待前 メールアドレス入力画面
  def invite
    @pair = current_user.pair
  end

  # フォームに入力されたアドレスへメール送信
  def send_mail
    email = params[:email]
    name = current_user.name
    pair_id = current_user.pair_id
    # PairMailerにフォームに入力したemailとログイン中ユーザのnameの値を渡してwelcomeアクションを呼び出し⇒メール送信
    PairMailer.with(email: email, name: name, pair_id: pair_id).welcome.deliver_later
    redirect_to complete_path
  end

  # 招待メール送信完了画面
  def complete
    @pair = current_user.pair
  end

  # 招待される側 認証画面
  def join
  end

  # 認証チェック
  def pairing
    join_pair_id = params[:pair_id]
    join_keyword = params[:keyword]

    # 入力されたペアIDが存在するか
    if Pair.exists?(id: join_pair_id)
      pair = Pair.find_by(id: join_pair_id)

      # そのペアがまだ未ペアリングであるか
      if pair.is_paired == false

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

          # 4 ペアの_is_pairedステータスを更新
          pair.update(is_paired: true)

          redirect_to root_path, notice: 'ペアリングしました！'
        else
          redirect_to join_path, notice: 'キーワードが間違っています'
        end

      else
        redirect_to join_path, notice: '既にペアリング済みのペアIDです。'
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
    redirect_to root_path, notice:"ペア情報を更新しました！"
  end

  def destroy
    pair = current_user.pair
    pair.destroy
    redirect_to about_path, notice:"全情報を削除しました。ご利用ありがとうございました。"
  end

  # ペア削除 確認画面
  def confirm
    @pair = current_user.pair
  end


  private

  def pair_params
    params.require(:pair).permit(:name,:motto,:pair_type,:rank,:keyword,:image)
  end

end
