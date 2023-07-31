 class PromotionsController<Controller                                                                                         
                                                     
 before_filter :hr_view, :only => [:create, :new, :edit, :update]	                                                                                                                  
 before_filter :other_emp_view                                                         
 layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]                                                 
                                                                                                                                    
 def index                                                                                                                                                                                               
  @employee = Employee.find(params[:employee_id])                                                                                                                                                                                        
  @promotions = @employee.promotions                                                                                                                                                             
 end                                                                   
	                                                                                                        
  def new                                                         
    @promotion = Promotion.new                              
    @employee = Employee.find(params[:employee_id])                                 
  end                                            
      
 def create
   # raise params.inspect
   @employee = Employee.find(params[:employee_id])    
   @promotion = Promotion.create(:date_of_promotion=> params[:promotion][:date_of_promotion], :employee_id=>params[:employee_id],
:designation_id=>param[:promotion][:designation_id])                      
if @promotion.saves
@employee.update(:designation_id => @promotion.designation_id)
redirect_to employee_promotions_path
else 
 render 'new'               
 end 
end                                                       
  
  def edit   
    @employee = Employee.find(params[:employee_id])        
    @promotion = Promotion.find(params[:id])   
  end                  
                                      
  def update                                                                                               
    # raise params.inspect                                                                                                                                                                                                                                                                                                    
    @employee = Employee.find(params[:employee_id])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    @promotion = Promotion.find(params[:id])                                                                                                                                                   
    if @promotion.update(:date_of_promotion=> params[:promotion][:date_of_promotion], :designation_id=>params[:promotion][:designation_id] )
    redirect_to employee_promotions_path               
    else
    render 'edit' 
    end  
  end
	
  def destroy
   @employee = Employee.find(params[:employee_id])
   @promotion = Promotion.find(params[:id])
   @promotion.destroy
   redirect_to employee_promotions_path(@employee)            
 end
   
private
def user_authentication	
@employee = Employee.find(params[:employee_id])
#raise @employee.inspect
if current_user.employee.employee_id  == @employee.employee_id || current_user.employee.role_id == 2
else
	redirect_to employees_path
end
end
     
           
end


  
