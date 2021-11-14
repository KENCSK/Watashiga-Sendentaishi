class Prefecture < ApplicationRecord
  has_many :posts

  validates :prefecture, presence: true

end
