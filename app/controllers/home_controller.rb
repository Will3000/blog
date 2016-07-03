class HomeController < ApplicationController
  def index
    session[:word] = params[:search] if params[:search]
    @pages = (1..(Post.count/10.0).ceil).to_a
    @page = params[:page].to_i
    if params[:search]
      @posts = Post.search(params[:search]).order(created_at: :desc).page(@page).per(10)
      if params[:search].length > 0
        @pages = (1..(@posts.count/10.0).ceil).to_a
      end
    end
  end

  def about
  end
end
