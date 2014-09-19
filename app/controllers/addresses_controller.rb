class AddressesController < ApplicationController
  
   layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]
 # include AddressHelper
  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  
  def index
    @employee = Employee.find(params[:employee_id])
		@address1 = @employee.addresses.where(:address_type=>0).first
		@address2 = @employee.addresses.where(:address_type=>1).first
  end
  
  def new
    @employee = Employee.find(params[:employee_id])
    @address = Address.new
   	@address_type_value, @address_type = false, "Present" if params[:address_type]=="0"
 		@address_type_value, @address_type = true, "Permanent" if params[:address_type]=="1"
  end
  
  def create
		@employee = Employee.find(params[:employee_id])
   	
   	@address = @employee.addresses.create(params_present_address)
		
		if @address.present? &&  !@address.errors.present?
		  redirect_to employee_addresses_path
		else
	 render 'new'
 	end
 	end

  
  def show
   #raise params.ispect
  end
  
  def edit
    #raise params.inspect
    @employee = Employee.find(params[:employee_id])
    @address = Address.find(params[:id])
    
  end
  
  def update
    @employee = Employee.find(params[:employee_id])
    @address = Address.find(params[:id])
    @address.update(params_present_address)
    if @address.errors.present?
      render :edit
    else
      redirect_to employee_addresses_path(@employee)
    end
    
  end
  
  
	def destroy
			
		@employee = Employee.find(params[:employee_id])
		@address = Address.find(params[:id])
    if @employee.present_address_id == @address.id
			@employee.update(:present_address_id => nil)
			@address.destroy
		#raise params.inspect
		else
			@address.destroy
			@employee.update(:permanent_address_id => nil)
		end
		
		redirect_to employee_addresses_path
	
	end
  
  
  
  private
  
  def params_present_address
    params.require(:address).permit(:line, :line1, :city, :state, :country, :zipcode, :address_type)
  end
   
  
end  
