class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_many :charms, dependent: :destroy

  attachment :post_image

  validates :title, presence: true
  validates :prefecture_id, presence: true
  validates :post_image, presence: true
  validates :address, presence: true
  validates :text, presence: true,length: { maximum:400 }
end
