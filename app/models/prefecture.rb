class Prefecture < ApplicationRecord
  has_many :posts
  has_many :charms, through: :posts

  validates :prefecture, presence: true

  # 一つの都道府県の全ての投稿に、付けられた魅力度の合計を元に、多い順で都道府県をソート
  def self.sort_prefecture_by_charm_rank
    joins(:charms).group(:id).select('prefectures.id, prefecture, count(prefectures.id) AS count').order('count desc')
  end
end
