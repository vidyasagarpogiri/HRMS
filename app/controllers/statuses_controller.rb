# This controller is for employee status
class StatusesController < ApplicationController
  def index
    # raise params.inspect
    # @sta = Status.find(params[:id])
    @statuses = Status.all.order('created_at DESC').page(params[:page]).per(3)
    @status = Status.new
    @comment = Comment.new
    # @comments = Comment.all.page(params[:page]).per(2)
    # raise @comments.inspect
    # @comments = Comment.limit(4)
  end

  def new
    @status = Status.new
  end

  def create
    @status = current_user.employee.statuses.new(status_params)
    if @status.save
      # Employee.where(status: false).each do |emp|
      # raise @user.inspect
      # Notification.delay.status_notification(@emp, @status) # email notification for like
      # raise @emp.inspect
      # end
      redirect_to statuses_path
    else
      render 'new'
    end
  end

  def add_like
    # raise params.inspect
    @like = Like.where(employee_id: params[:employee_id], status_id: params[:id]).first
    if @like
      @like.update is_like: true
    else
      @like = Like.create(is_like: true, employee_id: params[:employee_id], status_id: params[:id])
    end
    # raise @like.inspect
    # @like = Like.create(like_params)
    # raise params.inspect
    count = @like.status.likes_count
    @like.status.update likes_count: count + 1
    # raise @like.inspect
    # Notification.delay.like_notification(@like) # email notification for like
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
    @status.comments.destroy_all
    @status.destroy
    redirect_to statuses_path
  end

  def show
    @employee = Employee.all
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
