class HomesController < ApplicationController
  def top
    @user_ranks = Post.sort_user_by_charm_ranks.limit(10)
    @prefecture_ranks = Prefecture.sort_prefecture_by_charm_rank.limit(10)
    @posts = Post.limit(10).order('created_at DESC')
  end
end
