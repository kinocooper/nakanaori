class DiscussRecordsController < ApplicationController
  before_action :pair_nil_check
  before_action :this_pairs_record?, only:[:show,:edit,:update,:destroy,:reconcile]

  def new
    @discuss_record = DiscussRecord.new
    @title = "新規投稿"
    @my_opinion = PersonalOpinion.new
    @pair = current_user.pair
  end

  def create
    # レコードの新規生成
    @discuss_record = DiscussRecord.new(discuss_record_params)
    @discuss_record.pair_id = current_user.pair_id

    if @discuss_record.save #この時点で投稿の新規idが生成
      # 結びつく自分の意見 新規生成
      @my_opinion = PersonalOpinion.new(personal_opinion_params[:personal_opinion])
      @my_opinion.discuss_record_id = @discuss_record.id #ついさっきsaveされた投稿のidに結びつける
      @my_opinion.user_id = current_user.id
      @my_opinion.save

      # 結びつく相方の意見 新規生成(中身は空) 未ペアリング時は生成しない
      unless current_user.partner == nil
        partners_opinion = PersonalOpinion.new
        partners_opinion.discuss_record_id = @discuss_record.id #ついさっき生成された投稿のid
        partners_opinion.user_id = current_user.partner_id
        partners_opinion.save
      end
      redirect_to discuss_record_path(@discuss_record.id), notice: "ケンカを投稿しました"

    else # バリーデーションチェックにかかった場合
      @pair = current_user.pair
      @title = "新規投稿"
      @my_opinion = PersonalOpinion.new(personal_opinion_params[:personal_opinion])
      render :new
    end

  end

  def show
    @tag = Tag.new
    @tags = current_user.pair.tags
    @discuss_record = DiscussRecord.find(params[:id])
    @my_opinion = @discuss_record.personal_opinions.find_by(user_id: current_user.id)
    @partners_opinion = @discuss_record.personal_opinions.find_by(user_id: current_user.partner_id)
    @pair = current_user.pair
  end

  def edit
    @discuss_record = DiscussRecord.find(params[:id])
    @title = @discuss_record.title
    @my_opinion = @discuss_record.personal_opinions.find_by(user_id: current_user.id)
    @pair = current_user.pair
  end

  def update
    @discuss_record = DiscussRecord.find(params[:id])
    if @discuss_record.update(discuss_record_params)
      @my_opinion = @discuss_record.personal_opinions.find_by(user_id: current_user.id)
      @my_opinion.update(personal_opinion_params[:personal_opinion])
      redirect_to discuss_record_path(@discuss_record),notice:"投稿を更新しました！"
    else # バリーデーションチェックにかかった場合
      @pair = current_user.pair
      @title = DiscussRecord.find(params[:id]).title
      @my_opinion = PersonalOpinion.new(personal_opinion_params[:personal_opinion])
      render :edit
    end
  end

  def destroy
    discuss_record = DiscussRecord.find(params[:id])
    discuss_record.destroy
    redirect_to discuss_records_path, notice:"投稿を削除しました！"
  end

  def reconcile
    discuss_record = DiscussRecord.find(params[:id])
    discuss_record.update(is_closed: true)
    redirect_to congratulations_path, notice: "ナカナオリおめでとう＾＾"
  end

  def congratulations
    @pair = current_user.pair
  end

  def index
    @discuss_records = current_user.pair.discuss_records.order("created_at DESC")
    @pair = current_user.pair
  end


  private

  def discuss_record_params
    params.require(:discuss_record).permit(:title,:detail,:is_closed)
  end

  def personal_opinion_params
    params.require(:discuss_record).permit(personal_opinion:[:claim,:conclude])
  end

  def this_pairs_record? # 対象idの記事が現在のペアに結びつくものか
    # この記事　が　このペアの持っている記事　に　含まれているか
    unless current_user.pair.discuss_records.exists?(id: params[:id])
    redirect_to root_path
    end
  end


end
