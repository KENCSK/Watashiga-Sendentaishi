class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_many :charms, dependent: :destroy

  attachment :post_image

  with_options presence: true do
  validates :title
  validates :prefecture_id
  validates :post_image
  validates :address
  validates :text, length: { maximum:400 }
  end

end
