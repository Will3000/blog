class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find params[:post_id]
    favourite = Favourite.new(user:current_user, post: @post)
    respond_to do |format|
      if favourite.save
        format.html { redirect_to @post, notice: "Added to MyFavourites Sucessfully" }
        format.js   { render :create_success }
      else
        format.html { redirect_to @post, notice: "Already Added to MyFavourites" }
      end
    end
  end

  def index
    user = current_user
    @favourites = user.fav_posts
  end

  def destroy
    @post = Post.find params[:post_id]
    favourite = Favourite.find params[:id]
    respond_to do |format|
      if favourite.user == current_user
        favourite.destroy
        format.html { redirect_to @post, notice: "Removed Favourite" }
        format.js   { render }
      else
        format.html { redirect_to @post, notice: "Failded to Remove Favourite" }
      end
    end
  end
end
