  class InsentivesController < ApplicationController              
	      
  before_filter :hr_view,  only: ["new", "edit"]                                                   
                                                                                                                            
  before_filter :other_emp_view                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                              
 def index                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
  #raise params.inspect                                                                                                                                                                                                                                                                                                                                                  
  @salary = Salary.find(params[:salary_id])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
 end                                       
        
                 
   
