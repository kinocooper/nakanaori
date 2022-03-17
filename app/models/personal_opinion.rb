class PersonalOpinion < ApplicationRecord
  
  belongs_to :discuss_record
  belongs_to :user
  
end
