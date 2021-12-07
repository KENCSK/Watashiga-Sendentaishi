class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image, content_type: ['image/jpeg', 'image/png']

  has_many :posts, dependent: :destroy
  has_many :charms, dependent: :destroy
  has_many :charmed_posts, through: :charms, source: :post
  has_many :comments

  with_options presence: true do
    validates :name, length: { maximum: 20 }
    validates :email, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  end

  # 投稿に魅力度が付与されているかチェックする
  def already_charmed?(post)
    charms.exists?(post_id: post.id)
  end
end
