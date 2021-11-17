class HomesController < ApplicationController
  def top
    @prefectures = Prefecture.sort_prefecture_by_charm_rank
  end



        # article_total = Blog.joins(categories: :articles).where(id: 1).count

        # Post.group(:talent_id).order('count_talent_id desc').count(:talent_id)

        # @post_ranks = Post.joins(:charms).select('post.id, post.prefecture_id, count(charms.id) as charms_count')
        # @charms_count = 0
        # @post_ranks.each do |post|
        #   @charms_count += post.charms.count
        # end

      # # 分かりやすく
      # blog = Blog.first
      # article_counts = blog.categories.map { |category| category.articles.count }
      # article_total = article_counts_counts.sum

      # # joinsを使う
      # article_total = Blog.joins(categories: :articles).where(id: 1).count
      # # 別パターン
      # blog = Blog.first
      # article_total = blog.categories.joins(:articles).count

      # @posts = Post.includes(:charmed_users).sort {|a,b| b.charmed_users.size <=> a.charmed_users.size}
      # @posts = Post.find(Charm.group(:posts_prefecture))
      # @posts = Post.includes(:charms)
      # @prefectures = Post.includes(:prefecture, :charms)
      # @posts = Post.joins(:charms)
      # @prefectures = Post.joins(:prefecture, :charms)

      # post_charms_count = {}
      # Prefecture.all.each do |prefecture|
      #   post_charms_count.store(prefecture, Charm.where(post_id: Post.where(prefecture_id: prefecture.id).pluck(:id)).count)
      # end
      # @prefecture_post_like_ranks = post_charms_count.sort_by { |_, v| v }.reverse.to_h.keys
end
