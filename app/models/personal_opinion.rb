class PersonalOpinion < ApplicationRecord
  
  belongs_to :discussion_record
  belongs_to :user
  
end
