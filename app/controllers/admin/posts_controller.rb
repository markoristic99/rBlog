class Admin::PostsController < Admin::ApplicationController
  before_action :verify_logged_in

  def new
    @page_title = 'Add post'
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)

    if params[:post][:image].blank?
      @post.image = nil
    end

    if @post.save
      flash[:notice] = 'Post created'
      redirect_to admin_posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)

    if params[:post][:image].blank?
      @post.image = nil
    end
    if @post.update(post_params)
      flash[:notice] = 'Post updated'
      redirect_to admin_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    @post.destroy

    flash[:alert] = 'Post removed'

    redirect_to admin_posts_path
  end

  def index
    if params[:search]
      @posts = Post.search(params[:search]).all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    else
      @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :category_id, :user_id, :tags, :image, :body)
  end
end
