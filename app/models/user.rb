class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :charms, dependent: :destroy
  has_many :charmed_users, through: :charms, source: :user

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :biography, length: { maximum:50 }

  def already_charmed?(post)
    self.charms.exists?(post_id: post.id)
  end

  scope :order_by_charm_count, -> {
    self.joins(:charms).group("users.id").order("count_all DESC").count.keys.map.with_index { |id, i| "WHEN #{id} THEN #{i} " }.join
  }

  def self.sort_user_by_charm_rank
    self.joins(posts: :charms).group("users.id, users.name").order("CASE users.id #{order_by_charm_count} END").order("users.id, count_all DESC").count
  end
end
