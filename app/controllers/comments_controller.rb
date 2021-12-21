class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :comments
    else
      @user = @post.user
      @comment = Comment.new
      render "error"
    end
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    @post = Post.find(params[:post_id])
    render :comments
  end


  private
  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
  end
end
