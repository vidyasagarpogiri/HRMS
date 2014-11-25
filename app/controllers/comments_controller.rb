class CommentsController < ApplicationController
=begin
  def index
    
    @status = Status.find(params[:status_id]) 
    @comments = Comment.order('created_at DESC')
  end


  def new
   @comment = Comment.new
 
  end
  
  def create
    @status = current_user.employee.statuses.new(status_params)
      if @status.save          
        redirect_to statuses_path
          else
            render "new"
      end
  end
=end
    def index
    #raise params.inspect
    #@employee = current_user.employee
    @status = Status.find(params[:status_id]) 
    @comments = Comment.order('created_at ASC').limit(3)
    @like = Like.all 
    #raise @comments.inspect
  end

   def create
   #raise params.inspect
    @employee = current_user.employee
    @status = Status.find(params[:status_id])
    @comment = @status.comments.create(comment_params)
    @comment.save
    #raise @comment.inspect
    #raise @comment.inspect
    #Notification.comment_notification(@employee, @comment, @status).deliver
    #raise Notification.inspect
    #end
    redirect_to status_path(@status.id)
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
    
=begin  
  def edit     
  #raise params.inspect
    @status = Status.find(params[:id])        
  end
  
  def update
    @status = Status.find(params[:id])
    if @status.update(status_params)     
      redirect_to statuses_path
        else
      render "edit"
      end
  end
  
  
  def destroy
    @status = Status.find(params[:id])    
    if @status.destroy
      redirect_to statuses_path
      else
      render "index"
    end
  end
  
  def show
    @status = Status.find(params[:id]) 
  end
  
  private
  
  def status_params
    params.require(:status).permit(:status)
  end 
=end  
end






















