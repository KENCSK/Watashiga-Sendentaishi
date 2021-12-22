class Post < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture
  has_many :charms, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :post_image, content_type: ['image/jpeg', 'image/png']
  geocoded_by :address
  after_validation :geocode

  with_options presence: true do
    validates :title, length: { maximum: 20 }
    validates :prefecture_id
    validates :post_image
    validates :post_image_filename, on: :create
    validates :post_image_size
    validates :post_image_content_type, presence: { message: 'jpegまたはpngのファイルにして下さい' }, on: :create
    validates :address
    validates :text, length: { maximum: 400 }
  end

  # 一人のユーザーの全ての投稿に、付けられた魅力度の合計を元に、多い順でユーザーをソート
  def self.sort_user_by_charm_ranks
    joins(:charms).group(:user_id).select('posts.user_id, count(posts.id) AS count').order('count desc')
  end

  # 都道府県とキーワードごとに絞り込み検索
  def self.search(keywords, prefecture_id, page)
    posts = Post.all
  # キーワードが入力されているならキーワードごとに絞り込み
    keywords = '' if keywords.nil?
    keywords.split(/\s+/).each do |keyword|
      next if keyword == ''
      posts = posts.where('title LIKE(?) OR text LIKE(?) OR address LIKE(?)', "%#{keyword}%", "%#{keyword}%",
                          "%#{keyword}%")
    end
  # 都道府県が選択されているなら都道府県で絞り込み
    posts = posts.where(prefecture_id: prefecture_id) if prefecture_id.present?
    posts.page(page).order('created_at DESC')
  end
end
