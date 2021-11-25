class UsersController < ApplicationController

  def my_page
    @visible_search_form = true
    @user = current_user
    @posts = current_user.posts.page(params[:page])
  end

  def charms
    @visible_search_form = true
    @user = current_user
    @posts = current_user.charmed_posts.page(params[:page])
  end

  def show
    @visible_search_form = true
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to root_path, alert: "不正なアクセスです"
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_page_path, notice: "ユーザー情報を更新しました！！"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :biography, :profile_image)
  end

end
