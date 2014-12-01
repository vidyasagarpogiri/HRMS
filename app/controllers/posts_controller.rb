class PostsController < ApplicationController

  def index
   @posts = Post.all
   @post = Post.new
  end
  
  def new
    @post = Post.new
  end
  
  def create
    raise params.inspect
  end
  
  private

  def post_params # New method creates a obje
    params.require(:post).permit(:title, :content, :tags, :category_id)
  end
end





