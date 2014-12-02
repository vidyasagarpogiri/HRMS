class PostsController < ApplicationController

  def index
   @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
 # raise params.inspect
   @post = current_user.employee.posts.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  
  def edit # Edits the status
    @post = Post.find(params[:id])
  end
  
   def update # Updates the status
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render 'edit'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  
  def add_comment_form
    @comment = @post.comments.new
    @post = Post.find(params[:id])
  end
  
  def add_comments
   @post = Post.find(params[:post_id])
   @employee = current_user.employee
   @comment =  @post.comments.new(:comment => params[:comment], :employee_id => @employee.id)
   if @comment.save
      redirect_to posts_path
   else
    render "add_comment_form"
    
   end
   
  end
  
  
   def add_like
   # raise params.inspect
    @post = Post.find(params[:id])
    #raise @post.inspect
    #@employee = current_user.employee
    @like = @post.likes.create(:employee_id => params[:employee_id])
    if (@post.likes_count == nil)
      
     @post.update(:likes_count => 0)
     #raise @post.likes_count.inspect
    end
    #raise @like.inspect
    if @like
      @like.update is_like: true
    else
      @like = Like.create(is_like: true, employee_id: params[:employee_id])
    end
    count = @post.likes_count
    @post.update likes_count: count + 1
    @post.update(updated_at: Time.now)
    redirect_to posts_path
  end
  
  
  def remove_like
    @post = Post.find(params[:id])
    employee = current_user.employee
    @like = @post.likes.where(:employee_id => employee.id).first
    @like.update is_like: false
    count = @post.likes_count
    @post.update likes_count: count - 1
    @post.update(updated_at: Time.now)
     @like.destroy
    redirect_to posts_path
  end
  
  
  private

  def post_params # New method creates a obje
    params.require(:post).permit(:title, :content, :tags, :category)
  end
end





