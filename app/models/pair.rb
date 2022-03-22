class Pair < ApplicationRecord
  # text型カラムのdefault値設定のため
  attribute :motto, :text, default: 'もっと～！'

  has_many :users, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :discuss_records, dependent: :destroy
  has_one_attached :image

  enum pair_type: {not_set: 0, married: 1, couple: 2, family: 3, other: 4}
  enum rank: {tamago: 0, hiyoko: 1, kokko: 2, oshidori: 3}

  def get_pair_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
