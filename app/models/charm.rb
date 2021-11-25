class Charm < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :prefectures,  through: :post

  validates_uniqueness_of :post_id, scope: :user_id

end
