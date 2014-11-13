class SalaryCertificate < Prawn::Document
  def initialize(user )
    super()
    @user = user 
    @y = 700
    @x = 0
    logo
    date
    header
    text
    salary
    sign
  end
  
   def logo
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/amzur-logo.png", :position => :right, :width => 150, :height => 80, :at => [350,750]      
  end
  
   def date
    draw_text "31st January 2014", size: 12, :at => [@x+40, @y-50]
  end
  
  def header
    draw_text "TO WHOMSOEVER IT MAY CONCERN", style: :bold, size: 15, :at => [@x+150, @y-70]
  end
  
  def text
    draw_text "This is to certify that #{@user.employee.title}.#{@user.employee.full_name} (Emp No. #{@user.employee.employee_id} ) , (#{@user.employee.designation.designation_name if @user.employee.designation.present?})  ",  size: 12, :at => [@x+40, @y-110]
    draw_text " is an employee of Amzur Technologies , since #{@user.employee.date_of_join}",  size: 12, :at => [@x+40, @y-130]
    draw_text "As per our records his / her Salary details in Indian Rupee is as follows :",:at => [@x+40, @y-170]
  end
  
  def salary
    
    draw_text "BASIC:", :at => [@x+40, @y-200] #1
    draw_text "#{@user.employee.salary.basic_salary}", :at => [@x+360, @y-200]
    draw_text "HOUSE RENT ALLOWANCE:", :at => [@x+40, @y-230] #2
    draw_text "XXX", :at => [@x+360, @y-230]
    draw_text "CONVEYANCE ALLOWANCE:", :at => [@x+40, @y-260] #3
    draw_text "XXX", :at => [@x+360, @y-260]
    draw_text "AMZUR BENEFITS PLAN:", :at => [@x+40, @y-290] #4
    draw_text "XXX", :at => [@x+360, @y-290]
    draw_text "ADDITIONAL ALLOWANCE:", :at => [@x+40, @y-320] #5
    draw_text "XXX", :at => [@x+360, @y-320]
    draw_text "PROVIDENT FUND:", :at => [@x+40, @y-350] #6
    draw_text "#{@user.employee.salary.pf}", :at => [@x+360, @y-350]
    draw_text "GRATUITY:", :at => [@x+40, @y-380] #7 
    draw_text "#{@user.employee.salary.gratuity}", :at => [@x+360, @y-380]
    draw_text "QPLC:", :at => [@x+40, @y-410] #8
    draw_text "XXX", :at => [@x+360, @y-410]
    draw_text "MEDICAL ALLOWANCE:", :at => [@x+40, @y-440] #9
    draw_text "XXX", :at => [@x+360, @y-440]
    draw_text "MONTHLY GROSS:",style: :bold, :at => [@x+40, @y-470] #10
    draw_text "XXX", :at => [@x+360, @y-470]        
  end
  
  def sign
    draw_text "This certificate is issued at employee request.", :at => [@x+40, @y-520] 
    draw_text "For Verification of this letter, you can get in touch with (Mail ID)", :at => [@x+40, @y-540]
    draw_text "For Amzur Technologies", :at => [@x+40, @y-590] 
    draw_text "AUTHORISED SIGNATORY", :at => [@x+40, @y-640]
  end
 
end
