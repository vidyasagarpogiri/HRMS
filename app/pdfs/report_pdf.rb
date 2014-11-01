class ReportPdf < Prawn::Document
  def initialize(payslip)
    super()
    @payslip = payslip
    header
    text_content
    table_content
  end
 
  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/amzur-logo.png", :position => :left, :width => 50, :height => 30
  end
 
  def text_content
    stroke_axis
    stroke_color "ff0000"
    stroke do
     # just lower the current y position
       move_down 50
       horizontal_rule
       vertical_line 100, 300, :at => 50
       horizontal_line 200, 500, :at => 150
     end

   
 
    
      text "Duis vel", size: 15, style: :bold
      text "Duis vel tortor elementum, ultrices tortor vel, accumsan dui. Nullam in dolor rutrum, gravida turpis eu, vestibulum lectus. Pellentesque aliquet dignissim justo ut fringilla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut venenatis massa non eros venenatis aliquet. Suspendisse potenti. Mauris sed tincidunt mauris, et vulputate risus. Aliquam eget nibh at erat dignissim aliquam non et risus. Fusce mattis neque id diam pulvinar, fermentum luctus enim porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
  
  end
 
  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
   
  end
 
  def product_rows
  
    end

end
