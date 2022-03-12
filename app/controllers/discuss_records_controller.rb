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
  end

  def edit
  end

  def congratulations
  end

  def index
  end


  private

  def discuss_record_params
    params.require(:discuss_record).permit(:pair_id,:title,:detail,:is_closed)
  end

end
