class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :charms, dependent: :destroy
  has_many :charmed_posts, through: :charms, source: :post

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :biography, length: { maximum:50 }

  def already_charmed?(post)
    self.charms.exists?(post_id: post.id)
  end

  # def self.sort_user_by_charm_rank
  #   self.joins(:charms).group(:id).select('user, count(users.id) AS count').order('count desc')
  # end

end
