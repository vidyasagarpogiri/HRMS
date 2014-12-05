# This controller is for employee status # Author: Vidya Sagar Pogiri
class StatusesController < ApplicationController
  
  def index # for displaying all statuses 
    @statuses = Status.all.order('updated_at DESC').page(params[:page]).per(3)
    @status = Status.new
    #raise @status.inspect
    @comment = Comment.new
  end

  def new # for creating a object for new status
    @status = Status.new
  end

  def create # creates New status record 
  
    @status = current_user.employee.statuses.new(status_params)
    #raise @status.inspect
    if @status.save
      redirect_to statuses_path
    else
      render 'new'
    end
  end
=begin
  def add_like # creates like to the status
    @like = Like.where(employee_id: params[:employee_id], status_id: params[:id]).first
    if @like
      @like.update is_like: true
    else
      @like = Like.create(is_like: true, employee_id: params[:employee_id], status_id: params[:id])
    end
    count = @like.status.likes_count
    @like.status.update likes_count: count + 1
    @like.status.update(updated_at: Time.now)
    redirect_to statuses_path
=end
  
  def add_like
   # raise params.inspect
    @status = Status.find(params[:id])
    #raise @post.inspect
    #@employee = current_user.employee
    @like = @status.likes.create(:employee_id => params[:employee_id])
    if (@status.likes_count == nil)
      
     @status.update(:likes_count => 0)
     #raise @post.likes_count.inspect
    end
    #raise @like.inspect
    if @like
      @like.update is_like: true
    else
      @like = Like.create(is_like: true, employee_id: params[:employee_id])
    end
    count = @status.likes_count
    @status.update likes_count: count + 1
    @status.update(updated_at: Time.now)
    redirect_to statuses_path
  end
=begin
  def remove_like # destroys like to the status
    # raise params.inspect
    @like = Like.where(employee_id: params[:employee_id], status_id: params[:id]).first
    @like.update is_like: false
    count = @like.status.likes_count
    @like.status.update likes_count: count - 1
    @like.status.update(updated_at: Time.now)
    @like.destroy
    redirect_to statuses_path
=end
  
    def remove_like
    @status = Status.find(params[:id])
    employee = current_user.employee
    @like = @status.likes.where(:employee_id => employee.id).first
    @like.update is_like: false
    count = @status.likes_count
    @status.update likes_count: count - 1
    @status.update(updated_at: Time.now)
     @like.destroy
    redirect_to statuses_path
  end
  
  # Present we are not using this one.
  def edit # Edits the status
    @status = Status.find(params[:id])
  end

  def update # Updates the status
    @status = Status.find(params[:id])
    if @status.update(status_params)
      redirect_to statuses_path
    else
      render 'edit'
    end
  end

  def destroy # Deletes the status
    @status = Status.find(params[:id])
    @status.destroy
    redirect_to statuses_path
  end

  def show # Dsiplays the status in a show page
    @status = Status.find(params[:id])
    @comments = @status.comments.order('created_at ASC')
    #raise @comments.inspect
    @comment = Comment.new
    #raise @comment.inspect
    #@employees = Like.where(status_id: @status.id).map(&:employee)
  end
  
  
  def add_comment_form
    @comment = @status.comments.new
    @status = Status.find(params[:id])
    @status.update(updated_at: Time.now)
  end
  
  def add_comments
    #raise params.inspect
     @status = Status.find(params[:status_id])
     @employee = current_user.employee
     @status.comments.create(:comment => params[:comment], :employee_id => @employee.id)
     @status.update(updated_at: Time.now)
     redirect_to statuses_path
    
  end

  private

  def status_params # New method creates a obje
    params.require(:status).permit(:status)
  end
end
