class Tag < ApplicationRecord

  belongs_to :pair
  has_many :tag_relationships, dependent: :destroy
  # タグはN個の投稿から付けられる
  has_many :discussion_records, through: :tag_relationships

end
