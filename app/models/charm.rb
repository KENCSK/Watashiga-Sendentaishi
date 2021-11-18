class Charm < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :prefectures,  through: :post

  validates_uniqueness_of :post_id, scope: :user_id

  def self.sort_user_by_charm_rank
    self.group(:user_id).select('user_id, count(post_id) AS count').order('count desc')
  end
end
