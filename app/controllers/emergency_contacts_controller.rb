class EmergencyContactsController < ApplicationController
  before_action :get_employee, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :get_emergency_contact, only: [:edit, :update, :destroy]
  
  def index
   @emergency = @employee.emergency_contacts 
  end
  
  def new
    @emergency = EmergencyContact.new
  end
  
  def create
    @emergency = EmergencyContact.create(params.require(:emergency_contact).permit(:name, :relation, :mobile1, :mobile2).merge(employee_id: params[:employee_id]))   
    @errors = @emergency.errors.full_messages
    @emergency = @employee.emergency_contacts 
  end
  
  def edit   
  end
  
  def update
     @emergency.update(params.require(:emergency_contact).permit(:name, :relation, :mobile1, :mobile2).merge(employee_id: params[:employee_id]))
     @errors = @emergency.errors.full_messages 
      @emergency = @employee.emergency_contacts    
  end
  
 	def destroy
		@emergency.destroy
		@emergency = @employee.emergency_contacts
  end
  
  private
  
  def get_employee 
    @employee = Employee.find(params[:employee_id])
  end
  def get_emergency_contact
    @emergency = EmergencyContact.find(params[:id])
  end
end
