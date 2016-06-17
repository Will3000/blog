class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def create
    @post = Post.find params[:post_id]
    @comment = @post.comments.new comment_params
    @comment.user = User.find(session[:user_id])
    if @comment.save
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "please sign in" unless user_signed_in?
  end
end
