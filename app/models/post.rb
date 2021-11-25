class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_many :charms, dependent: :destroy

  attachment :post_image, content_type: ["image/jpeg", "image/png"]

  with_options presence: true do
  validates :title, length: { maximum:20 }
  validates :prefecture_id
  validates :post_image
  validates :post_image_filename, on: :create
  validates :post_image_size
  validates :post_image_content_type, presence: { message: "jpegまたはpngのファイルにして下さい" }, on: :create
  validates :address
  validates :text, length: { maximum:400 }
  end

  def self.sort_user_by_charm_ranks
    self.joins(:charms).group(:user_id).select('posts.user_id, count(posts.id) AS count').order('count desc')
  end

  def self.search(keywords, prefecture_id, page)
    posts = Post.all
    keywords = "" if keywords == nil
    keywords.split(/\s+/).each do |keyword|
      if keyword == ""
        next
      end
      posts = posts.where('title LIKE(?) OR text LIKE(?) OR address LIKE(?)', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    end
    if prefecture_id.present?
      posts = posts.where(prefecture_id: prefecture_id)
    end
    return posts.page(page).order("created_at DESC")
  end

end
