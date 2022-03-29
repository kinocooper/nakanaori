class PersonalOpinion < ApplicationRecord

  # text型カラムのdefault値設定のため
  attribute :claim, :text, default: ''
  attribute :conclude, :text, default: ''

  # アソシエーション
  belongs_to :discuss_record
  belongs_to :user

end
