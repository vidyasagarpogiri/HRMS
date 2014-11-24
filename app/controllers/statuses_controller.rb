class StatusesController < ApplicationController
  
  def index 
  
    #raise params.inspect
    #@sta = Status.find(params[:id]) 
    @statuses = Status.all.order('created_at DESC')
    @status = Status.new
    @comment = Comment.new
    #@st = Status.find(params[:status_id]) 
    #raise @statuses.inspect
    
   
    #raise  @comments.inspect
  end
  
  def new 
   @status = Status.new
 
  end
  
  def create
  @employee = Employee.all
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
    @like.save
      count = @like.status.likes_count
      @like.status.update :likes_count => count+1
    #@like = count+1
    redirect_to statuses_path
  end
  
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
    @status.destroy
    redirect_to statuses_path
   end
  
  def show
    @status = Status.find(params[:id])
    @comments = @status.comments
    @comment = Comment.new
      
  end
  
  private
  
  def status_params
    params.require(:status).permit(:status)
  end 
 
end






















