class TagsController < ApplicationController

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


  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
