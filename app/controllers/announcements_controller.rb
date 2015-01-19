class AnnouncementsController < ApplicationController
before_filter :hr_view,  only: ["new", "edit"]
before_action :find_announcement, only: [:edit, :update, :destroy, :show]
 
  def index
   @announcements = Announcement.all.page(params[:page]).per(5)
   
  #@dept_announcemnets = current_user.employee.department.announcemnets
  #@group_announcemnets = current_user.employee.group.announcemnets
  #@workgroup_announcemnets =current_user.employee.workgroups.map(&:announcemnets).flatten
  end
  
  def new
   @announcement = Announcement.new
   @departments = Department.all
   @groups =Group.all
   @workgroups =Workgroup.all
  end
  
  def create
  #raise params.inspect
  
  
  
   case params[:announceable_type] 
  
     when "Group"
     #raise params.inspect
      @announcement = Group.find(params[:group_id]).announcements.create(announcement_params)
        if @announcement
        #raise @announcement.is_send_mail.inspect
          if @announcement.is_send_mail
            Group.find(params[:group_id]).employees.where(status: false).each do |emp|
            #Notification.delay.announcement_notification(emp.user,@announcement) 
          end
        end
          redirect_to welcome_wall_path
        else
           flash.now[:error]
           render "new"
        end
     
     when "Department"
         @announcement = Department.find(params[:department_id]).announcements.create(announcement_params)
        if @announcement.save
          if @announcement.is_send_mail
           Department.find(params[:department_id]).employees.where(status: false).each do |emp|
            #Notification.delay.announcement_notification(emp.user,@announcement) 
          end
        end
          redirect_to welcome_wall_path
        else
           flash.now[:error]
           render "new"
        end
     
     when "Workgroup"
     
        @announcement = Workgroup.find(params[:workgroup_id]).announcements.create(announcement_params)
        if @announcement.save
          if @announcement.is_send_mail
            Workgroup.find(params[:workgroup_id]).employees.where(status: false).each do |emp|
            #Notification.delay.announcement_notification(emp.user,@announcement) 
          end
        end
          redirect_to welcome_wall_path
        else
           flash.now[:error]
           render "new"
        end
     
     else
        @announcement = Announcement.create(announcement_params)
         
        if @announcement.save
          if @announcement.is_send_mail
            Employee.where(status: false).each do |emp|
            #Notification.delay.announcement_notification(emp.user,@announcement) 
          end
        end
          redirect_to welcome_wall_path
        else
           flash.now[:error]
           render "new"
        end
    
      end
  end
  
  def edit
    @announcement =Announcement.find(params[:id])
     
    @announceable = Announcement.get_eventable(@announcement)
  end
  
  def show
    @announcement =Announcement.find(params[:id])
    @announcements = Announcement.all.page(params[:page]).per(5)
    @announceable = Announcement.get_eventable(@announcement)
  end
  
  def update
  #raise params.inspect
   
     @announcement = Announcement.find(params[:id])
     @announcement.update(announcement_params)
       if @announcement
        redirect_to welcome_wall_path
        else
         flash.now[:error]
         render "edit"
       end  
      
  end
  
  def destroy
    @announcement.destroy
    redirect_to welcome_wall_path 
  end
  
  
  private
  
  def announcement_params
     params.require(:announcement).permit(:title, :description, :is_send_mail) 
  end
   
  def find_announcement
    @announcement = Announcement.find(params[:id])
  end
  
end
