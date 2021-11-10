class CharmsController < ApplicationController
  def index
  end
  
  def create
    @post = Post.find(params[:post_id])
    @charm = current_user.charms.create(charm_id: params[:charm_id])
    @charm.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @charm = current_user.charms.find_by(charm_id: @charm.id)
    @c.destroy

  end
end
