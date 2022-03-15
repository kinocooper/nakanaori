class DiscussRecordsController < ApplicationController
  def new
    @discuss_record = DiscussRecord.new
    @my_opinion = PersonalOpinion.new
  end

  def create
    # レコードの新規生成
    discuss_record = DiscussRecord.new(discuss_record_params)
    discuss_record.pair_id = current_user.pair_id
    discuss_record.save #この時点で投稿の新規idが生成

    # 結びつく自分の意見 新規生成
    my_opinion = PersonalOpinion.new(personal_opinion_params[:personal_opinion])
    my_opinion.discuss_record_id = discuss_record.id #ついさっき生成された投稿のid
    my_opinion.user_id = current_user.id
    my_opinion.save

    # 結びつく相方の意見 新規生成(中身は空)
    partners_opinion = PersonalOpinion.new
    partners_opinion.discuss_record_id = discuss_record.id #ついさっき生成された投稿のid
    partners_opinion.user_id = current_user.partner_id
    partners_opinion.save

    redirect_to discuss_record_path(discuss_record.id), notice: "ケンカを投稿しました"
  end

  def show
    @discuss_record = DiscussRecord.find(params[:id])
    @my_opinion = @discuss_record.personal_opinions.find_by(user_id: current_user.id)
    @partners_opinion = @discuss_record.personal_opinions.find_by(user_id: current_user.partner_id)
  end

  def edit
    @tag = Tag.new
    @tags = Tag.all
    @discuss_record = DiscussRecord.find(params[:id])
    @my_opinion = @discuss_record.personal_opinions.find_by(user_id: current_user.id)
  end

  def update
    discuss_record = DiscussRecord.find(params[:id])
    discuss_record.update(discuss_record_params)
    my_opinion = discuss_record.personal_opinions.find_by(user_id: current_user.id)
    my_opinion.update(personal_opinion_params[:personal_opinion])
    redirect_to discuss_record_path(discuss_record),notice:"投稿を更新しました！"
  end

  def destroy
    discuss_record = DiscussRecord.find(params[:id])
    discuss_record.destroy
    redirect_to discuss_records_path, notice:"投稿を削除しました！"
  end

  def reconcile
    discuss_record = DiscussRecord.find(params[:id])
    discuss_record.update(is_closed: TRUE)
    redirect_to congratulations_path, notice: "ナカナオリおめでとう＾＾"
  end

  def congratulations
  end

  def index
    @discuss_records = DiscussRecord.all
  end


  private

  def discuss_record_params
    params.require(:discuss_record).permit(:title,:detail,:is_closed)
  end

  def personal_opinion_params
    params.require(:discuss_record).permit(personal_opinion:[:claim,:conclude])
  end

end
