class LikesController < ApplicationController
  
  def index
    @like = Like.all
  end
  
  def new
    @like = Like.new
  end
  
  def create
    @like = Like.create
    @like.save
  end
  
  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    
  end
  
  def likes_new
    raise params.inspect
    
  end
  
  private
  
  def like_params
  params.require(:like).permit(:is_like)
  end
  
end
