class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def create
    @post = Post.find params[:post_id]
    @comment = @post.comments.new comment_params
    @comment.user = current_user
    rating = Rating.create  star_count: params[:star_count]
    @comment.rating = rating
    if @comment.save
      CommentMailer.notify_post_owner(@comment).deliver_now
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def remove_rating
    @post = Post.find params[:id]
    @comment = Comment.find ({user:current_user, post:@post})
    @comment.rating.destroy
    redirect_to post_path(@post)
  end
  private

  def comment_params
    params.require(:comment).permit(:body, :star_count)
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "please sign in" unless user_signed_in?
  end
end
