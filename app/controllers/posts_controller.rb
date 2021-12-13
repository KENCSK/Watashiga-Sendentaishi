class PostsController < ApplicationController
  def show
    @visible_search_form = true
    @post_detail = Post.find(params[:id])
    @user = @post_detail.user
    @comment = current_user.comments.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: '投稿しました！！'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to root_path, alert: '不正なアクセスです。' if @post.user_id != current_user.id
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: '投稿を更新しました!!'
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to my_page_path, notice: '投稿を削除しました.'
  end

  def search
    @visible_search_form = true
    if params[:keyword].present? == false and params[:prefecture_id].present? == false
      redirect_to request.referer,  alert: '都道府県またはキーワードを入力してください'
    end
    @keyword = params[:keyword]
    @posts = Post.search(@keyword, params[:prefecture_id], params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :address, :post_image, :prefecture_id)
  end
end
