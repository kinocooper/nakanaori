class DiscussRecordsController < ApplicationController
  def new
    @discuss_record = DiscussRecord.new
  end

  def create
    discuss_record = DiscussRecord.new(discuss_record_params)
    discuss_record.save
    redirect_to root_path, notice: "ケンカを投稿しました"
  end

  def show
    @discuss_record = DiscussRecord.find(params[:id])
  end

  def edit
    @discuss_record = DiscussRecord.find(params[:id])
  end

  def update
    discuss_record = DiscussRecord.find(params[:id])
    discuss_record.update(discuss_record_params)
    redirect_to discuss_record_path(discuss_record),notice:"投稿を更新しました！"
  end

  def destroy
    discuss_record = DiscussRecord.find(params[:id])
    discuss_record.destroy
    redirect_to discuss_records_path,notice:"投稿を削除しました！"
  end

  def congratulations
  end

  def index
    @discuss_records = DiscussRecord.all
  end


  private

  def discuss_record_params
    params.require(:discuss_record).permit(:pair_id,:title,:detail,:is_closed)
  end

end
