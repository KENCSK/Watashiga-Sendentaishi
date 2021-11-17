class Prefecture < ApplicationRecord
  has_many :posts
  has_many :charms, through: :posts

  validates :prefecture, presence: true

  scope :order_by_charm_count, -> {
    self.joins(:charms).group("prefectures.id").order("count_all DESC").count.keys.map.with_index { |id, i| "WHEN #{id} THEN #{i} " }.join
  }

  def self.sort_prefecture_by_charm_rank
    self.joins(posts: :charms).group("prefectures.id, prefectures.prefecture").order("CASE prefectures.id #{order_by_charm_count} END").order("prefectures.id, count_all DESC").count
  end
end
