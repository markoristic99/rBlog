class Admin::CommentsController < Admin::ApplicationController
  before_action :verify_logged_in
  
  def destroy

    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end

end
