class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum oko_gauge: { nomal: 0, sad: 1, oko: 2, gekioko: 3, alone: 4 }

  belongs_to :pair, optional: true
  # 本人から見て
  belongs_to :partner, class_name: "User", optional: true
  # 相方から見て
  has_one :person, class_name: "User"

  has_many :personal_opinions, dependent: :destroy
end
