class InsentivesController < ApplicationController              
	   
  before_filter :hr_view,  only: ["new", "edit"]                                              
                                                                                             
  before_filter :other_emp_view                                                                                                                                      
                                                                                                                                                                                                                                                                                                                          
 def index                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
  #raise params.inspect                                                                                                                                                                                                                                                                  
  @salary = Salary.find(params[:salary_id])                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
 end                                                                                                                                                                                                                                 
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 def new                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                                                                    
 private                                                                           
                                                                            
  def params_insentive                                       
    params.require(:insentive).permit(:insentive_type, :value).merge(:salary_id => params[:salary_id])
  end
  
  
end
             
     
