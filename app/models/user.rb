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
end
