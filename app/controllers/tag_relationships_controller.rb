class TagRelationshipsController < ApplicationController
  before_action :pair_nil_check

  def create
    tag_relationship = TagRelationship.new(discuss_record_id: params[:discuss_record_id], tag_id: params[:tag_id])
    tag_relationship.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tag_relationship = TagRelationship.find_by(discuss_record_id: params[:discuss_record_id], tag_id: params[:tag_id])
    tag_relationship.destroy
    redirect_back(fallback_location: root_path)
  end

end
