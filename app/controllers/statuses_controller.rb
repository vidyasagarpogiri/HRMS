class StatusesController < ApplicationController
  
  def index 
  
    #raise params.inspect
    #@sta = Status.find(params[:id]) 
    @statuses = Status.all.order('created_at DESC').page(params[:page]).per(2)
    @status = Status.new
    @comment = Comment.new
   # @comments = Comment.all.page(params[:page]).per(2)
    #raise @comments.inspect
    #@comments = Comment.limit(4)
    end
  
  
  def new 
   @status = Status.new
 
  end
  
  def create
    @status = current_user.employee.statuses.new(status_params)
      if @status.save  
     
      #Employee.where(status: false).each do |emp|
      #raise @user.inspect
      #Notification.status_notification(@emp, @status).deliver
    #raise @emp.inspect
    #end
     redirect_to statuses_path
   else
     render "new"
   end
   end
  
  def add_like
    #raise params.inspect
    @like = Like.create(is_like: true, employee_id: params[:employee_id], status_id: params[:id])
    #raise @like.inspect
    #@like = Like.create(like_params)
    #raise params.inspect
    count = @like.status.likes_count
    @like.status.update :likes_count => count+1
    #raise @like.inspect
    #Notification.like_notification(@like).deliver 
    redirect_to statuses_path
  end
=begin 
  def remove_like
    #raise params.inspect
    @like = Like.update(is_like: false, employee_id: params[:employee_id], status_id: params[:id])
      count = @like.status.likes_count
      @like.status.update :likes_count => count-1
    redirect_to statuses_path
  end
=end  
  def edit     
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
    @status.destroy
    redirect_to statuses_path
   end
  
  def show
    @employee = Employee.all
    @status = Status.find(params[:id])
    @comments = @status.comments
    @comment = Comment.new
      
  end
  
  private
  
  def status_params
    params.require(:status).permit(:status)
  end 
 
end






















