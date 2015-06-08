class PostsController < ApplicationController
  def view
    #erb :view
    #render :view
    @post = Post.find(params[:id])
  end
end