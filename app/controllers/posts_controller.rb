class PostsController < ApplicationController

  def show
    #erb :show
    #render :show
    @post = Post.find(params[:id])
  end

  def index
    page = params[:page] || 1
    @posts = self.get_page(page)
  end

  def new
    render :new
  end

  protected
  def get_page(n)
    page_offset = (n-1) * 10
    page_size = 10
    Post.order(written_at: :desc).offset(page_offset).limit(page_size)
  end
end