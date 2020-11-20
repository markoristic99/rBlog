class Admin::UsersController < Admin::ApplicationController
  before_action :verify_logged_in

  def new
    @page_title = 'Add user'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if params[:search]
      @users = User.search(params[:search]).all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    else
      @users = User.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    end
    
    if @user.save
        EmailSenderJob.perform_later(@user)
        flash[:notice] = 'User created'
        render 'index'
    else 
        render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @users = User.all
    if @user.update(user_params)
      flash[:notice] = 'User updated'
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    
    if params[:search]
      @users = User.search(params[:search]).all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    else
      @users = User.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    end

    @user.destroy

    flash[:alert] = 'User removed'

    render 'index'
  end

  def index
    if params[:search]
      @users = User.search(params[:search]).all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    else
      @users = User.all.order('created_at DESC').paginate(:page => params[:page], per_page: 10)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :uid, :provider)
  end
end
