class TagRelationship < ApplicationRecord

  # アソシエーション
  belongs_to :tag
  belongs_to :discuss_record

end
