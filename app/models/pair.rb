class Pair < ApplicationRecord
  
  has_many :users, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :discussion_records, dependent: :destroy
  
end
