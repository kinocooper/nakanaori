class DiscussRecord < ApplicationRecord
  
  belongs_to :pair
  has_many :personal_opinions, dependent: :destroy
  has_many :tag_relationships, dependent: :destroy
  # 投稿はN個のタグをもつ
  has_many :tags, through: :tag_relationships
  
end
