class AnnouncementsController < ApplicationController
before_filter :hr_view,  only: ["new", "edit"]
 
  def index
   @announcements = Announcement.all.page(params[:page]).per(5)
  end
  
  def new
   @announcement = Announcement.new
  end
  
  def create
   @announcement = Announcement.new(announcement_params)
   @users = User.all
  
    if @announcement.save
    #raise params.inspect
      Employee.where(status: false).each do |emp|
      Notification.delay.announcement_notification(emp.user,@announcement) 
    end
      redirect_to announcements_path
    else
       flash.now[:error]
       render "new"
    end
  end
  
  def edit
    @announcement = Announcement.find(params[:id]) 
  end
  
  def show
    @announcement = Announcement.find(params[:id])
    @announcements = Announcement.all.page(params[:page]).per(5)
  end
  
  def update
    @announcement = Announcement.find(params[:id])
     if @announcement.update(announcement_params)
        redirect_to announcements_path
      else
       flash.now[:error]
       render "edit"
    end   
  end
  
  def destroy
  #raise params.inspect
    @announcement =  Announcement.find(params[:id])
    @announcement.destroy
    redirect_to announcements_path 
  end
  
  
  private
  
  def announcement_params
     params.require(:announcement).permit(:title, :description) 
  end
  
end
