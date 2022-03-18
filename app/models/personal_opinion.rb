class PersonalOpinion < ApplicationRecord
  attribute :claim, :text, default: ''
  attribute :conclude, :text, default: ''
  belongs_to :discuss_record
  belongs_to :user
  
end
