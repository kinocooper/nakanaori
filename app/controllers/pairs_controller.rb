class PairsController < ApplicationController
  # ペア未作成段階では下記3アクション以外を制限
  before_action :pair_nil_check, except:[:new,:join,:create,:pairing]
  # ペア作成済みであれば下記アクションを制限
  before_action :pair_presence_check, only:[:new,:join]
  # ペアリング済であれば、加えて下記アクションも制限
  before_action :already_paired?, only:[:invite]

  def top
    @pair = current_user.pair
    @discussing_records = current_user.pair.discuss_records.where(is_closed: false).order("created_at DESC").limit(5)
    @closed_records = DiscussRecord.where(pair_id: current_user.pair.id).where(is_closed: true).order("created_at DESC").limit(5)
    @all_tags = @pair.tags

    @y_dates = DiscussRecord.this_year_d_count(current_user.pair)
    @tags_ratio = DiscussRecord.each_tags_count(current_user.pair)
  end

  def new
    @pair = Pair.new
  end

  def create
    # ペアの新規生成
    @pair = Pair.new(pair_params)
    if @pair.save

      # 作成したてのペアidをcurrent_userに結びつける
      user = User.find(current_user.id)
      user.update(pair_id: @pair.id)

      redirect_to root_path
    else
      render :new
    end
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
    redirect_to complete_pair_path
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

          # 5 これまでの全投稿にの空個人意見を生成
          discuss_records = pair.discuss_records
          discuss_records.each do |discuss_record|
            PersonalOpinion.create(user_id: person.id, discuss_record_id: discuss_record.id)
          end

          redirect_to root_path, notice: 'ペアリングしました！'

        else
          redirect_to join_pair_path, notice: 'キーワードが間違っています'
        end

      else
        redirect_to join_pair_path, notice: '既にペアリング済みのペアIDです。'
      end

    else
      redirect_to join_pair_path, notice: 'ペアが存在しません'

    end


  end

  def edit
    @pair = current_user.pair
  end

  def update
    @pair = current_user.pair
    if @pair.update(pair_params)
      redirect_to root_path, notice:"ペア情報を更新しました！"
    else
      render :edit
    end
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

  def pair_presence_check
    redirect_to root_path if current_user.pair != nil
  end

  def already_paired?
    redirect_to root_path if current_user.pair.is_paired
  end

end
