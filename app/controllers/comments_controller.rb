# this controller is for status comments
class CommentsController < ApplicationController
  def index
    # raise params.inspect
    # @employee = current_user.employee
   # @status = Status.find(params[:status_id])
    @comments = Comment.order('created_at ASC').limit(3)
    #@like = Like.all
    # raise @comments.inspect
  end

  def create
    # raise params.inspect
    @employee = current_user.employee
    @status = Status.find(params[:status_id])
    @comment = @status.comments.create(comment_params)
    if @comment.save
    # raise @comment.inspect
    # raise @comment.inspect
    # Notification.comment_notification(@employee, @comment, @status).deliver
    # raise Notification.inspect
    # end
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

  def destroy
  raise params.inspect
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment).merge(employee_id: @employee.id)
  end
end
