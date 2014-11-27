# This controller is for employee status # Author: Vidya Sagar Pogiri
class StatusesController < ApplicationController
  
  def index # for displaying all statuses 
    @statuses = Status.all.page(params[:page]).per(3)
    @status = Status.new
    @comment = Comment.new
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
  end

  def remove_like # destroys like to the status
    # raise params.inspect
    @like = Like.where(employee_id: params[:employee_id], status_id: params[:id]).first
    @like.update is_like: false
    count = @like.status.likes_count
    @like.status.update likes_count: count - 1
    @like.status.update(updated_at: Time.now)
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
    @comments = @status.comments
    @comment = Comment.new
    @employees = Like.where(status_id: @status.id).map(&:employee)
  end

  private

  def status_params # New method creates a obje
    params.require(:status).permit(:status)
  end
end
