# This controller is for employee status # Author: Vidya Sagar Pogiri
class StatusesController < ApplicationController
  
  def index # for displaying all statuses
    @statuses = Status.all.order('updated_at DESC').page(params[:page]).per(3)
    @status = Status.new
    @comment = Comment.new
    @employees = Like.where(likeable_id: @status.id).map(&:employee)
  end

  def new # for creating a object for new status
    @status = Status.new
  end

  def create # creates New status record
    @status = current_user.employee.statuses.new(status_params)
    if @status.save
      redirect_to statuses_path
    else
      render 'new'
    end
  end

  def add_like # like will be created on the selected status
   # raise params.inspect
    @status = Status.find(params[:id])
    # @employee = current_user.employee
    @like = @status.likes.create(:employee_id => params[:employee_id])
    if (@status.likes_count == nil) 
     @status.update(:likes_count => 0)
     #raise @post.likes_count.inspect
    end
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

  def remove_like # unlikes the status which is being liked previously
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

  def update # Updates the selected status
    @status = Status.find(params[:id])
    if @status.update(status_params)
      redirect_to statuses_path
    else
      render 'edit'
    end
  end

  def destroy # Deletes the selected status
    @status = Status.find(params[:id])
    @status.destroy
    redirect_to statuses_path
  end

  def show # Displays the status in a show page
    @status = Status.find(params[:id])
    @comments = @status.comments.order('created_at ASC')
    @comment = Comment.new
    @employees = Like.where(likeable_id: @status.id).map(&:employee)
  end
  
  
  def add_comment_form # comments form
    @comment = @status.comments.new
    @status = Status.find(params[:id])
    @status.update(updated_at: Time.now)
  end
  
  def add_comments # creating comments
    @status = Status.find(params[:status_id])
    @employee = current_user.employee
    @status.comments.create(comment: params[:comment], employee_id: @employee.id)
    @status.update(updated_at: Time.now)
    redirect_to statuses_path
    
  end

  private

  def status_params # method for passing parameters 
    params.require(:status).permit(:status)
  end
end
