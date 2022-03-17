class Pair < ApplicationRecord

  has_many :users, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :discuss_records, dependent: :destroy
  has_one_attached :image

  def get_pair_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
