 class InsentivesController < ApplicationController         
  before_filter :hr_view,  only: ["new", "edit"]                   
  before_filter :other_emp_view                                                        
 end             
        
   
   
