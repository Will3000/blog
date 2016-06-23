class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find params[:post_id]
    favourite = Favourite.new(user:current_user, post: post)
    if favourite.save
      redirect_to post_path(post), notice: "Added to MyFavourites Sucessfully"
    else
      redirect_to post_path(post), notice: "Already Added to MyFavourites"
    end
  end

  def index
  end

  def destroy
    post = Post.find params[:post_id]
    favourite = Favourite.find params[:id]
    if favourite.user == current_user
      favourite.destroy
      redirect_to post_path(post), notice: "Removed Favourite"
    else
      redirect_to post_path(post), notice: "Failded to Remove Favourite"
    end
  end
end
