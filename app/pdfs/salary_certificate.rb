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
    @z = @y-230
    if @user.employee.salary.allowances.present?
      @user.employee.salary.allowances.each do |allowance|
        draw_text "#{allowance.allowance_name}", :at => [@x+40, @z]
        draw_text "#{allowance.total_value}", :at => [@x+360, @z]
      @z = @z-30
      end
    end
    draw_text "ADDITIONAL ALLOWANCE:", :at => [@x+40, @z] #5
    draw_text "#{@user.employee.salary.special_allowance}", :at => [@x+360, @z]
    draw_text "PROVIDENT FUND:", :at => [@x+40, @z-30] #6
    draw_text "#{@user.employee.salary.pf}", :at => [@x+360, @z-30]
    draw_text "GRATUITY:", :at => [@x+40, @z-60] #7 
    draw_text "#{@user.employee.salary.gratuity}", :at => [@x+360, @z-60]
    draw_text "QPLC:", :at => [@x+40, @z-90] #8
    draw_text "#{@user.employee.salary.bonus}", :at => [@x+360, @z-90]
    draw_text "MEDICAL ALLOWANCE:", :at => [@x+40, @z-120] #9
    draw_text "#{@user.employee.salary.medical_insurance}", :at => [@x+360, @z-120]
    draw_text "MONTHLY GROSS:",style: :bold, :at => [@x+40, @z-150] #10
    draw_text "#{@user.employee.salary.gross_salary}", :at => [@x+360, @z-150]        
  end
  
  def sign
    draw_text "This certificate is issued at employee request.", :at => [@x+40, @y-520] 
    draw_text "For Verification of this letter, you can get in touch with (Mail ID)", :at => [@x+40, @y-540]
    draw_text "For Amzur Technologies", :at => [@x+40, @y-590] 
    draw_text "AUTHORISED SIGNATORY", :at => [@x+40, @y-640]
  end
 
end
