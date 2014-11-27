# This controller is for employee status
class StatusesController < ApplicationController
  
  def index # New method creates a object for new album
    @statuses = Status.all.order('created_at DESC').page(params[:page]).per(3)
    @status = Status.new
    @comment = Comment.new
  end

  def new
    @status = Status.new
  end

  def create
    @status = current_user.employee.statuses.new(status_params)
    if @status.save
      redirect_to statuses_path
    else
      render 'new'
    end
  end

  def add_like
    @like = Like.where(employee_id: params[:employee_id], status_id: params[:id]).first
    if @like
      @like.update is_like: true
    else
      @like = Like.create(is_like: true, employee_id: params[:employee_id], status_id: params[:id])
    end
    count = @like.status.likes_count
    @like.status.update likes_count: count + 1
    redirect_to statuses_path
  end

  def remove_like
    # raise params.inspect
    @like = Like.where(employee_id: params[:employee_id], status_id: params[:id]).first
    @like.update is_like: false
    count = @like.status.likes_count
    @like.status.update likes_count: count - 1
    redirect_to statuses_path
  end

  # Present we are not using this one.
  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    if @status.update(status_params)
      redirect_to statuses_path
    else
      render 'edit'
    end
  end

  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    redirect_to statuses_path
  end

  def show
    @status = Status.find(params[:id])
    @comments = @status.comments
    @comment = Comment.new
    @employees = Like.where(status_id: @status.id).map(&:employee)
  end

  private

  def status_params
    params.require(:status).permit(:status)
  end
end
