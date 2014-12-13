class JobLocationsController < ApplicationController
 def index
  @job_locations = JobLocation.all
  @departments = Department.all
 end

 def new
  @job_location = JobLocation.new
  @address = Address.new
 end
 
 def create
  @address = Address.new
  @address=Address.create(:line => params[:line],:line1=> params[:line1],:city=> params[:city],:state=> params[:state],:country=> params[:country],:zipcode=> params[:zipcode])
  @job_location= JobLocation.create(:address_id => @address.id)
  redirect_to job_locations_path
 end
 
 def edit 
  @job_location = JobLocation.find(params[:id])
  @address = @job_location.address
 end
 
 def update
  @job_location = JobLocation.find(params[:id])
  @address = @job_location.address.update(:line => params[:line],:line1=> params[:line1],:city=> params[:city],:state=> params[:state],:country=> params[:country],:zipcode=> params[:zipcode])
   redirect_to job_locations_path
 end
 
 def show
  @job_location = JobLocation.find(params[:id])
 end
 
 def destroy
   @job_location = JobLocation.find(params[:id])
   @job_location.address.destroy
   @job_location.destroy
   redirect_to job_locations_path
 end
end





 
