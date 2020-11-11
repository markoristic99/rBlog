class PostsController < ApplicationController
  def index
    if params[:search]
      @posts = Post.search(params[:search]).all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    else
      @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    end
    @categories = Category.all


    respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @posts }
        format.json { render :json => @posts }
      end
  end

  def report
    @categories = Category.all
    ReportWorker.perform_async("27-10-2020", "28-10-2020")
    
  end

  def show
    @post = Post.find(params[:id])
    @categories = Category.all
    @comment = Comment.new
    @comments = Comment.all
  end
end
