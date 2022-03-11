class TagRelationship < ApplicationRecord

  belongs_to :tag
  belongs_to :discussion_record

end
