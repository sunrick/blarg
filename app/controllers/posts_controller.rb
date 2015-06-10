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

  def create
    tags = params[:tags].split(", ")
    tag_models = tags.map { |tag| Tag.find_or_create_by(name: tag)}
    @post = Post.create(title: params[:title], content: params[:content], 
                        written_at: DateTime.now, tags: tag_models)
    @method = "post"
    redirect_to post_path(@post)
    # redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
    @tags =@post.tags.pluck(:name).join(", ")
    @method = "put"
    render :edit
  end

  def update
    tags = params[:tags].split(", ")
    tag_models = tags.map { |tag| Tag.find_or_create_by(name: tag)}
    @post = Post.find(params[:id])
    @post.update(title: params[:title], content: params[:content], 
                written_at: DateTime.now, tags: tag_models)
    redirect_to post_path(@post)
  end

  protected
  def get_page(n)
    page_offset = (n-1) * 10
    page_size = 10
    Post.order(written_at: :desc).offset(page_offset).limit(page_size)
  end
end