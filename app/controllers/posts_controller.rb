class PostsController < ApplicationController

  before_action :authenticate_user!

  def new
    @post = Post.new
    @post.photos.build
  end

  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to root_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def index
    @posts = Post.limit(10).includes(:photos, :user)
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(9)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @like = Like.new
    @comments = @post.comments
    @comment = Comment.new
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.user == current_user
      flash[:notice] = "投稿が削除されました" if @post.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:food_name, :store_name, :description, photos_attributes: [:image]).merge(user_id: current_user.id)
    end
end
