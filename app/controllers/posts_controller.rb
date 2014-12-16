class PostsController < ApplicationController
before_filter :edit_view, only: ['edit']
  def index
   @search = Post.search do
    fulltext params[:search]
  end
  @posts = @search.results
  # @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
   @post = current_user.employee.posts.new(post_params) 
   @post.update(:tags => params[:hidden_tags].chop)
  
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
    @post.update(:tags => params[:hidden_tags].chop)
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
      redirect_to post_path(@post.id)
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
  
  def destroy
  #raise params.inspect
    @post =  Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    # @posts = current_user.employee.projects
    # @employee = current_user.employee
  end
  private

  def post_params # New method creates a obje
    params.require(:post).permit(:title, :content, :category)
  end
  
  def edit_view
  @post = Post.find(params[:id])
 #raise WorkgroupsEmployee.last.inspect
    unless current_user.employee == @post.employee
     render :text => "You Don`t Have Permission"  
    end  
   end
end





