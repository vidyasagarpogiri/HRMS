class AnnouncementsController < ApplicationController
before_filter :hr_view,  only: ["new", "edit"]
before_action :find_announcement, only: [:edit, :update, :destroy, :show]
 
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
  end
  
  def show
    @announcements = Announcement.all.page(params[:page]).per(5)
  end
  
  def update
     if @announcement.update(announcement_params)
        redirect_to announcements_path
      else
       flash.now[:error]
       render "edit"
    end   
  end
  
  def destroy
    @announcement.destroy
    redirect_to announcements_path 
  end
  
  
  private
  
  def announcement_params
     params.require(:announcement).permit(:title, :description) 
  end
   
  def find_announcement
    @announcement = Announcement.find(params[:id])
  end
  
end
