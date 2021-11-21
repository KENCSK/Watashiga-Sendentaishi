class HomesController < ApplicationController
  def top
    @user_post_like_ranks = Post.joins(:charms).group(:user_id).select('posts.user_id, count(posts.id) AS count').order('count desc')
    @prefectures = Prefecture.sort_prefecture_by_charm_rank.limit(10)
    @posts = Post.limit(10).order("created_at DESC")
  end

end
