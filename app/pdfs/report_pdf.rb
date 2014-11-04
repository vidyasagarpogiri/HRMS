class ReportPdf < Prawn::Document
  def initialize(payslip)
    super()
    @payslip = payslip
    @y = 700
    @x = 0
    header
    employee_details
    employee_salary
    total_salary
    net_pay
    genral_info
    footer
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
    draw_text "#{@payslip.month}-#{@payslip.year}", :at => [@x+150, @y-100]
    draw_text "ATTD:", :at => [@x+300, @y-100]
    draw_text "30", :at => [@x+400, @y-100]
    draw_text "EMP CODE:", :at => [@x+50, @y-120] #2
    draw_text "0891", :at => [@x+150, @y-120]
    draw_text "DEPARTMENT:", :at => [@x+300, @y-120]
    draw_text "Development", :at => [@x+400, @y-120]
    draw_text "NAME:", :at => [@x+50, @y-140] #3
    draw_text "BALA", :at => [@x+150, @y-140]
    draw_text "PF No:", :at => [@x+300, @y-140]
    draw_text "8328213", :at => [@x+400, @y-140]
    draw_text "LOCATION:", :at => [@x+50, @y-160] #4
    draw_text "VSKP", :at => [@x+150, @y-160]
    draw_text "PAN No:", :at => [@x+300, @y-160]
    draw_text "fgdgdf435", :at => [@x+400, @y-160]
    draw_text "MODE:", :at => [@x+50, @y-180] #5
    draw_text "BANK", :at => [@x+150, @y-180]
    draw_text "A/c No:", :at => [@x+300, @y-180]
    draw_text "6326592335", :at => [@x+400, @y-180]
    stroke_color "000000"
    fill_color "666222"
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
    draw_text "10000", :at => [@x+150, @y-260]
    draw_text "TDS:", :at => [@x+300, @y-260]
    draw_text "400", :at => [@x+400, @y-260]
    draw_text "HRA:", :at => [@x+50, @y-280] #2
    draw_text "2000", :at => [@x+150, @y-280]
    draw_text "PT:", :at => [@x+300, @y-280]
    draw_text "100", :at => [@x+400, @y-280]
    draw_text "HRA:", :at => [@x+50, @y-300] #3
    draw_text "2000", :at => [@x+150, @y-300]
    draw_text "PT:", :at => [@x+300, @y-300]
    draw_text "100", :at => [@x+400, @y-300]
    draw_text "HRA:", :at => [@x+50, @y-320] #4
    draw_text "2000", :at => [@x+150, @y-320]
    draw_text "PT:", :at => [@x+300, @y-320]
    draw_text "100", :at => [@x+400, @y-320]
    draw_text "HRA:", :at => [@x+50, @y-340] #5
    draw_text "2000", :at => [@x+150, @y-340]
    draw_text "HRA:", :at => [@x+50, @y-360] 
    draw_text "2000", :at => [@x+150, @y-360]
    draw_text "HRA:", :at => [@x+50, @y-380] #6
    draw_text "2000", :at => [@x+150, @y-380]
    draw_text "HRA:", :at => [@x+50, @y-400] 
    draw_text "2000", :at => [@x+150, @y-400]
   
  end
  
  def total_salary
    stroke_color "000000"
    fill_color "666222"
    stroke do
      fill_and_stroke_rectangle [@x+10, @y-420], 520, 20 
    end
    fill_color "000000"
    font("Times-Roman") do
      draw_text "TOTAL:", :at => [@x+50, @y-435]
      draw_text "100000", :at => [@x+150, @y-435]
      draw_text "TOTAL:", :at => [@x+300, @y-435]
      draw_text "1000", :at => [@x+400, @y-435]
    end
  end
  
  def net_pay
    stroke_color "000000"
    fill_color "ADD6FF"
    stroke do
      fill_and_stroke_rectangle [@x+10, @y-460], 520, 20 
    end
    fill_color "000000"
    font("Times-Roman") do
      draw_text "NET PAY SALARY:", :at => [@x+50, @y-475]
      draw_text "38765", :at => [@x+150, @y-475]    
      draw_text "(Rupees In words)", :at => [@x+200, @y-475] 
    end
  end   
  
  def genral_info    
      draw_text "Computer generated print, Hence sign not required ", :at => [@x+50, @y-540]      
  end     
  
  def footer
    stroke_color "000000"
    fill_color "002E8A"
    stroke do
      fill_and_stroke_rectangle [@x+10, @y-460], 520, 20 
    end
    fill_color "000000"
    font("Times-Roman") do    
      draw_text "Amzur Technologies (I) Private Limited, 9-29-22, Pioneer Sankar Shantiniketan, Balaji Nagar, Siripuram, Visakhaptnam. Tel: +91-891-6451882", :at => [@x+50, @y-565]      
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
