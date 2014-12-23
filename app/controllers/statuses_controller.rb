# This controller is for employee status # Author: Vidya Sagar Pogiri
class StatusesController < ApplicationController
  before_filter :admin_view,  only: ['edit']
  def index # for displaying all statuses
    @statuses = Status.all.order('updated_at DESC').page(params[:page]).per(1)
    @status = Status.new
    @comment = Comment.new
    @employees = Like.where(likeable_id: @status.id).map(&:employee)
  end

  def new # for creating a object for new status
    @status = Status.new
  end

  def create # creates New status record
    @post = current_user.employee.statuses.create(status_params)
    @albums = Album.all
    @statuses = Status.all
    @posts = [@albums, @statuses]
    @posts.flatten!
    @posts.sort!{|a,b| b.updated_at <=> a.updated_at}
  end
  # like will be created on the selected status
  def add_like
    @status = Status.find(params[:id])
    @like = @status.likes.create(employee_id: params[:employee_id])
    if (@status.likes_count == nil)
      @status.update(:likes_count => 0)
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
    @like = @status.likes.where(employee_id: employee.id).first
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

  def admin_view # method for editing only admin of that status
    @status = Status.find(params[:id])
    unless current_user.employee.id == @status.employee_id
      render text: 'You Don`t Have Permission'
    end
  end
end
