class UsersController < ApplicationController
    
    def new
        @page_title = 'Add user'
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            EmailSenderJob.perform_later(@user)
            render 'created'
        else 
            render 'new'
        end
    end

    def created
    end

     private
    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
