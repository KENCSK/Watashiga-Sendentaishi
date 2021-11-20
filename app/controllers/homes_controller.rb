class HomesController < ApplicationController
  def top
    @prefectures = Prefecture.sort_prefecture_by_charm_rank.limit(10)
    @users = Charm.sort_user_by_charm_rank.limit(10)
    @posts = Post.limit(10).order("created_at DESC")
    # ユーザーの全投稿に対するいいね数ランキング
  #   post_charm_count = {}
  #   User.all.each do |user|
  #     post_charm_count.store(user, Charm.where(post_id: Post.where(user_id: user.id).pluck(:id)).count)
  #   end
  #   @user_post_like_ranks = post_charm_count.sort_by { |_, v| v }.reverse.to_h.keys
  end

end
