class WelcomeController < ApplicationController
  
  def index
    render :layout => false
  end
  
  def dashboard
    @welcomeevent = AmzurEvent.all
    @welcomeannouncements = Announcement.all
    @welcomerecruitments = Recruitment.where(:status => "open")
  end

end
