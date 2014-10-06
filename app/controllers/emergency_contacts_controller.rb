class EmergencyContactsController < ApplicationController
  def index
   @employee = Employee.find(params[:employee_id])
   #raise @employee.inspect
   @emergency = @employee.emergency_contacts
  
  end
  def new
    @emergency = EmergencyContact.new
    @employee = Employee.find(params[:employee_id])
  end
  
  def create
   #raise params.inspext
    @new_education = EmergencyContact.create(params.require(:emergency_contact).permit(:name, :relation, :mobile1, :mobile2).merge(employee_id: params[:employee_id]))
    
    @errors = @new_education.errors.full_messages
    @employee = Employee.find(params[:employee_id])
    @emergency = EmergencyContact.new
    @emergency = @employee.emergency_contacts
    @form_type = params[:commit]
  end
  
  def edit
    @employee = Employee.find(params[:employee_id])
    @emergency = EmergencyContact.find(params[:id])
   
  end
  
  def update
     @employee = Employee.find(params[:employee_id])
     @emergency = EmergencyContact.find(params[:id])
     @emergency.update(params.require(:emergency_contact).permit(:name, :relation, :mobile1, :mobile2).merge(employee_id: params[:employee_id]))
     @emergency = @employee.emergency_contacts
     
  end
  
 	def destroy
		@employee = Employee.find(params[:employee_id])
    @emergency = EmergencyContact.find(params[:id])
		@emergency.destroy
		@emergency = @employee.emergency_contacts
  end
end
