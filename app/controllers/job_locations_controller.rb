class JobLocationsController < ApplicationController
 def index
  @job_locations = JobLocation.all
 end

 def new
  @job_location = JobLocation.new
  @address = Address.new
 end
 
 def create
 raise params.inspect
 end
 
end
