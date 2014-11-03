class ReportPdf < Prawn::Document
  def initialize(payslip)
    super()
    @payslip = payslip
    header
    employee_details
    employee_salary
    total_salary
    #text_content
    #table_content
  end
 
  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/amzur-logo.png", :position => :right, :width => 150, :height => 80
    draw_text "PaySlip", style: :bold,  size: 15, :at => [230, 700]
  end
 
  def employee_details
    draw_text "MONTH/YEAR:", :at => [50, 600] #1
    draw_text "#{@payslip.month}-#{@payslip.year}", :at => [150, 600]
    draw_text "ATTD:", :at => [300, 600]
    draw_text "MONTH/YEAR", :at => [400, 600]
    draw_text "EMP CODE:", :at => [50, 580] #2
    draw_text "MONTH/YEAR2:", :at => [150, 580]
    draw_text "DEPARTMENT:", :at => [300, 580]
    draw_text "MONTH/YEAR4:", :at => [400, 580]
    draw_text "NAME:", :at => [50, 560] #3
    draw_text "MONTH/YEAR2:", :at => [150, 560]
    draw_text "PF No:", :at => [300, 560]
    draw_text "MONTH/YEAR4:", :at => [400, 560]
    draw_text "LOCATION:", :at => [50, 540] #4
    draw_text "MONTH/YEAR2:", :at => [150, 540]
    draw_text "PAN No:", :at => [300, 540]
    draw_text "MONTH/YEAR4:", :at => [400, 540]
    draw_text "MODE:", :at => [50, 520] #5
    draw_text "MONTH/YEAR2:", :at => [150, 520]
    draw_text "A/c No:", :at => [300, 520]
    draw_text "MONTH/YEAR4:", :at => [400, 520]
    stroke_color "000000"
    fill_color "666222"
    stroke do
      fill_and_stroke_rectangle [10, 480], 520, 20 
    end
    fill_color "000000"
    font("Times-Roman") do
      draw_text "EARNINGS:", :at => [50, 465]
      draw_text "DEDUCTIONS", :at => [300, 465]
    end
  end
  
  def employee_salary
    draw_text "BASIC:", :at => [50, 440] #1
    draw_text "#{@payslip.month}-#{@payslip.year}", :at => [150, 440]
    draw_text "TDS:", :at => [300, 440]
    draw_text "MONTH/YEAR", :at => [400, 440]
    draw_text "HRA:", :at => [50, 420] #2
    draw_text "#{@payslip.month}-#{@payslip.year}", :at => [150, 420]
    draw_text "PT:", :at => [300, 420]
    draw_text "MONTH/YEAR", :at => [400, 420]
  end
  
  def total_salary
    stroke_color "000000"
    fill_color "666222"
    stroke do
      fill_and_stroke_rectangle [10, 400], 520, 20 
    end
    fill_color "000000"
    font("Times-Roman") do
      draw_text "TOTAL:", :at => [50, 385]
      draw_text "100000", :at => [150, 385]
      draw_text "TOTAL:", :at => [300, 385]
      draw_text "1000", :at => [400, 385]
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
