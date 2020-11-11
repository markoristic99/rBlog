class Admin::CategoriesController < Admin::ApplicationController
  before_action :verify_logged_in

  def new
    @page_title = 'Add category'
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @categories = Category.all
    if @category.save
        flash[:notice] = 'Category created'
        render 'index'
    else 
        render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @categories = Category.all
    if @category.update(category_params)
      flash[:notice] = 'Category updated'
      render 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @categories = Category.all
    @category.destroy

    flash[:alert] = 'Category removed'

    render 'index'
  end

  def index
    if params[:search]
      @categories = Category.search(params[:search]).all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    else
      @categories = Category.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
