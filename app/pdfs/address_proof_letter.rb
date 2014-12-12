class AddressProofLetter < Prawn::Document
  def initialize(user)
    super()
    @user = user
    @y = 700
    @x = 0
    logo
    date
    header
    subject
    text
    details
    sign
  end
  
   def logo
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/amzur-logo.png", :position => :right, :width => 150, :height => 80, :at => [350,700]       
  end
  
  def date
    draw_text "31st January 2014", size: 12, :at => [@x+40, @y-100]
  end
  
  def header
    draw_text "TO WHOMSOEVER IT MAY CONCERN", style: :bold, size: 15, :at => [@x+150, @y-140]
  end
  
  def subject
    draw_text "Subject: Address Proof.", size: 15, :at => [@x+40, @y-200]
  end
  
  def text
    draw_text "This is to confirm that #{@user.employee.full_name} is a bonafide employee and is working as", size: 12, :at => [@x+40, @y-250]
    draw_text "#{@user.employee.designation.designation_name if @user.employee.designation.present?} since #{@user.employee.date_of_join}, for Amzur Technologies Pvt Ltd and as per the company", size: 12, :at => [@x+40, @y-270]
    draw_text "records the residential address of him is as mentioned below.", size: 12, :at => [@x+40, @y-290]  
  end
  
  def details
    draw_text "Details as under –", :at => [@x+40, @y-340]
    draw_text "Employee Name ", style: :bold, :at => [@x+40, @y-360]
    draw_text "Present Address", style: :bold, :at => [@x+40, @y-400]
    draw_text "Permanent Address", style: :bold, :at => [@x+40, @y-440]  
  end
  
  def sign
    draw_text "Thanking You,", :at => [@x+40, @y-490] 
    draw_text "<HR Name>", :at => [@x+40, @y-540]
    draw_text "Human Resources", :at => [@x+40, @y-560]    
  end
  
  
end
