class TagRelationship < ApplicationRecord

  belongs_to :tag
  belongs_to :discuss_record

end
