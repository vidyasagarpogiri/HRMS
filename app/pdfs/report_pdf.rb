class ReportPdf < Prawn::Document
  def initialize(payslip)
    super()
    @payslip = payslip
    @y = 700
    @x = 0
    header
    employee_details
    employee_salary
    #total_salary
    #net_pay
    #genral_info
    #footer
    #text_content
    table_content
  end
 
 
  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/amzur-logo.png", :position => :right, :width => 150, :height => 80, :at => [380,750]    
  end
 
  def employee_details
  draw_text "PaySlip", style: :bold,  size: 15, :at => [@x+230, @y-60]
    draw_text "MONTH/YEAR:", :at => [@x+50, @y-100] #1
    draw_text "#{I18n.t("date.abbr_month_names")[@payslip.month]}-#{@payslip.year}", :at => [@x+150, @y-100]
    draw_text "ATTD:", :at => [@x+300, @y-100]
    draw_text "#{@payslip.working_days}", :at => [@x+400, @y-100]
    draw_text "EMP CODE:", :at => [@x+50, @y-120] #2
    draw_text "#{@payslip.employee.employee_id}", :at => [@x+150, @y-120]
    draw_text "DEPARTMENT:", :at => [@x+300, @y-120]
    draw_text "#{@payslip.employee.department.department_name if @payslip.employee.department.present? }", :at => [@x+400, @y-120]
    draw_text "NAME:", :at => [@x+50, @y-140] #3
    draw_text "#{@payslip.employee.full_name}", :at => [@x+150, @y-140]
    draw_text "PF No:", :at => [@x+300, @y-140]
    draw_text "#{@payslip.employee.PFAccountNumber}", :at => [@x+400, @y-140]
    draw_text "LOCATION:", :at => [@x+50, @y-160] #4
    draw_text "#{@payslip.employee.job_location.address.city if @payslip.employee.job_location.present? }", :at => [@x+150, @y-160]
    draw_text "PAN No:", :at => [@x+300, @y-160]
    draw_text "#{@payslip.employee.pan}", :at => [@x+400, @y-160]
    draw_text "MODE:", :at => [@x+50, @y-180] #5
    draw_text "#{@payslip.mode}", :at => [@x+150, @y-180]
    draw_text "A/c No:", :at => [@x+300, @y-180]
    draw_text "#{@payslip.employee.account_number}", :at => [@x+400, @y-180]
    stroke_color "000000"
    fill_color "D1D0BD"
    stroke do
      fill_and_stroke_rectangle [@x+10, @y-220], 520, 20 
    end
    fill_color "000000"
    font("Times-Roman") do
      draw_text "EARNINGS:", :at => [@x+50, @y-235]
      draw_text "DEDUCTIONS", :at => [@x+300, @y-235]
    end
  end
  
  def employee_salary
  
    draw_text "BASIC:", :at => [@x+50, @y-260] #1
    draw_text "#{@payslip.basic_salary}", :at => [@x+200, @y-260]
    
    
    #non -dedcutable allowances
    @z = @y-260
    @payslip.allowances.each do |allowance|
      draw_text "#{allowance.allowance_name}:", :at => [@x+50, @z-20] #2
      draw_text "#{allowance.total_value}", :at => [@x+200, @z-20] 
      @z = @z-20
    end
    
    if @payslip.special_allowance.present?
      draw_text "Special Allowance:", :at => [@x+50, @z-20] 
      draw_text "#{@payslip.special_allowance}", :at => [@x+200, @z-20] 
      @z = @z-20
    end
    
    if @payslip.arrears.present?
      draw_text "Arrears", :at => [@x+50, @z-20] 
      draw_text "#{@payslip.arrears}", :at => [@x+200, @z-20] 
      @z = @z-20
    end
    
    @d = @y-240
    #deducations 
    if @payslip.tds.present?
      draw_text "TDS:", :at => [@x+300, @d-20]
      draw_text "#{@payslip.tds}", :at => [@x+450, @d-20]
      @d = @d -20
    end 
    
    if @payslip.pt.present? 
      draw_text "PT:", :at => [@x+300, @d-20]
      draw_text "#{@payslip.pt}", :at => [@x+450, @d-20]
      @d = @d -20
    end
    
    if @payslip.pf.present? 
      draw_text "PF:", :at => [@x+300, @d-20]
      draw_text "#{@payslip.pf}", :at => [@x+450, @d-20]
      @d = @d -20
    end 
   
    if @payslip.esic.present? 
      draw_text "ESIC:", :at => [@x+300, @d-20]
      draw_text "#{@payslip.esic}", :at => [@x+450, @d-20]
      @d = @d -20
    end 
    
    @payslip.allowances.where(:is_deductable => true).each do |allowance|
      draw_text "#{allowance.allowance_name}:", :at => [@x+300, @d-20]
      draw_text "#{(allowance.total_value/12).round(2)}", :at => [@x+450, @d-20]
      @d = @d -20
    end     
    k = @z<@d ? @z : @d
   total_salary(k)

   
  end
  
  def total_salary(z)
  @z= z
    stroke_color "000000"
    fill_color "D1D0BD"
    stroke do
      fill_and_stroke_rectangle [@x+10, @z-20], 520, 20 
    end
    fill_color "000000"
    font("Times-Roman") do
      draw_text "TOTAL:", :at => [@x+50, @z-35]
      draw_text "#{@payslip.gross_salary}", :at => [@x+200, @z-35]
      draw_text "TOTAL:", :at => [@x+300, @z-35]
      draw_text "#{@payslip.total_deductions}", :at => [@x+450, @z-35]

    end
    net_pay(@z)
  end
  
  def net_pay(z)
    stroke_color "000000"
    fill_color "ADD6FF"
    stroke do
      fill_and_stroke_rectangle [@x+10, z-60], 520, 20 
    end
    fill_color "000000"
    font("Times-Roman") do
      draw_text "NET PAY SALARY:", :at => [@x+50, z-75]
      draw_text "#{@payslip.netpay}", :at => [@x+200, z-75]    
      draw_text "(Rupees In words)", :at => [@x+300, z-75] 

    end
    genral_info(z)
  end   
  
  def genral_info(z)
      draw_text "Computer generated print, Hence sign not required ", :at => [@x+10, z-130]
      footer(z)      
  end     
  
  def footer(z)
    stroke_color "000000"
    fill_color "0047B2"
    stroke do
      fill_and_stroke_rectangle [@x+10, z-150], 520, 40 
    end
    fill_color "ffffff"
    font("Times-Roman") do    
      draw_text "Amzur Technologies (I) Private Limited, 9-29-22, Pioneer Sankar Shantiniketan, Balaji Nagar, Siripuram, ", :at => [@x+20, z-165]
      draw_text "Visakhaptnam. Tel: +91-891-6451882", :at => [@x+20, z-180]      
    end
  end
  
  def text_content
    stroke_axis
    stroke_color "ff0000"
    stroke do
     # just lower the current y position
       move_down 500
       horizontal_rule
       vertical_line 100, 300, :at => 50
       horizontal_line 200, 500, :at => 150
     end        
  end
 
  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
   
  end
 
  def product_rows  
  
  end

end
