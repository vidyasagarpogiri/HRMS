class GradesController<Controller                                   

  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view                                           
	                                                                       
  def index                                                                                                         
    @grades = Grade.all                                                                                                                                   
  end                                                                                                                                                                                                                              
                                                                                                                                                                                                                 
  def new                                                                                                                                             
    @grade = Grade.new                                                                             
  end                                   
      
  def create
    @designation = Designation.find(params[:grade][:designation_id])    
    @grade = @designation.grades.create(grade_params)
    redirect_to @designation 
  end   
            
  def show
    @grade = Grade.find(params[:id])
    @employees = @grade.employees
  end
                
  def update
    @grade = Grade.find(params[:id])
    @grade.update(grade_params)
    redirect_to @grade
  end
     
  def edit     
    @grade = Grade.find(params[:id])        
  end
                                           
  def destroy                              
     @grade = Grade.find(params[:id])                                         
     @grade.destroy                                 
     redirect_to @grade                                                                                                                                                                                           
  end                                                                                                                                                                                                                                                     
	                       
   def add_employee
    @grade = Grade.find(params[:id])
    @employee = Employee.all
  end 
	
   def update_employee
    #raise params.inspect
    @grade = Grade.find(params[:id])
    @employee = Employee.find(params[:employee_id])
    @employee.update(:grade_id => @grade.id)
    #raise @employee.inspect
    redirect_to @grade
   end  
  
  private
  def grade_params
    params.require(:grade).permit(:value) 
  end
end

