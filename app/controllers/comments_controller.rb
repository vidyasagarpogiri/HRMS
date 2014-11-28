# this controller is for status comments # Author: Vidya Sagar Pogiri
class CommentsController < ApplicationController
  def index 
    @comments = Comment.order('created_at ASC').limit(3)
  end

  def create
    @employee = current_user.employee
    @status = Status.find(params[:status_id])
    @comment = @status.comments.create(comment_params)
    @status.update(updated_at: Time.now)
    if @comment.save
      redirect_to statuses_path
    else
      render 'new'
    end
  end

  def new
    @employee = current_user.employee
    @status = Status.find(params[:status_id])
    @comment = Comment.new
  end



  private

  def comment_params
    params.require(:comment).permit(:comment).merge(employee_id: @employee.id)
  end
end
