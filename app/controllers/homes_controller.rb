class HomesController < ApplicationController
  def top
    @prefectures = Prefecture.sort_prefecture_by_charm_rank
    @users = Charm.sort_user_by_charm_rank
    # binding.irb
    @posts = Post.limit(10).order("created_at DESC")
  end

end
