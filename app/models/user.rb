class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :pair
  # 本人から見て
  belongs_to :partner, class_name: "User"
  # 相方から見て
  has_one :person, class_name: "User"

  has_many :personal_opinions, dependent: :destroy
end
