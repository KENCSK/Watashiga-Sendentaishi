class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿しました！！"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to root_path, alert: "不正なアクセスです。"
    end
  end


  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "投稿を更新しました！！"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to my_page_path, notice: "投稿を削除しました！！"
  end

  def search
    @keyword = params[:keyword]

    if (@keyword.present?) and ((params[:prefecture_id]).present?)
      @posts = Post.all
      # 分割したキーワードごとに検索
      @keyword.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        @posts = Post.where('title LIKE(?) OR text LIKE(?) OR address LIKE(?)',
                                "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
                                ).page(params[:page]).per(9).order("created_at DESC")
      end
        @posts = @posts.where(prefecture_id: params[:prefecture_id]).order("created_at DESC")
    elsif (params[:prefecture_id]).present?
      @posts = Post.where(prefecture_id: params[:prefecture_id]).page(params[:page]).per(9).order("created_at DESC")
    elsif @keyword.present?
      @posts = Post.all
      # 分割したキーワードごとに検索
      @keyword.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        @posts = Post.where('title LIKE(?) OR text LIKE(?) OR address LIKE(?)',
                                "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"
                                ).page(params[:page]).per(12).order("created_at DESC")
      end
    else
      redirect_to request.referer,  alert: '都道府県またはキーワードを入力してください'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :address, :post_image, :prefecture_id)
  end

end

