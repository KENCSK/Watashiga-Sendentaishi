class Prefecture < ApplicationRecord
  has_many :posts
  has_many :charms, through: :posts

  validates :prefecture, presence: true

  def self.sort_prefecture_by_charm_rank
    self.joins(:charms).group(:id).select('prefectures.id, prefecture, count(prefectures.id) AS count').order('count desc')
  end
end
