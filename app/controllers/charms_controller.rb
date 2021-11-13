class CharmsController < ApplicationController
  def index
  end

  def create
    @post = Post.find(params[:post_id])
    @charm = current_user.charms.create(post_id: params[:post_id])
    @charm.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @charm = current_user.charms.find_by(post_id: @post.id)
    @charm.destroy
  end

end
