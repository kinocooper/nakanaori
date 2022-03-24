class TagsController < ApplicationController
  before_action :pair_nil_check

  def create
    tag = Tag.new(tag_params)
    tag.pair_id = current_user.pair.id
    tag.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_back(fallback_location: root_path)
  end

  def show
    @pair = current_user.pair
    @tag = Tag.find(params[:id])
    @discuss_records = @tag.discuss_records
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
