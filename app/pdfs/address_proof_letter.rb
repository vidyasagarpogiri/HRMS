class AddressProofLetter < Prawn::Document
  def initialize(user, hr_manager, address1, address2)
    super()
    @user = user
    @hr_manager = hr_manager
    @present_address = address1 
    @permanent_address = address2
    @pa
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
    draw_text "#{Time.now.strftime("%d %b, %Y")}", size: 12, :at => [@x+40, @y-100]
  end
  
  def header
    draw_text "TO WHOMSOEVER IT MAY CONCERN", style: :bold, size: 15, :at => [@x+150, @y-140]
  end
  
  def subject
    draw_text "Subject: Address Proof.", size: 14, :at => [@x+40, @y-200]
  end
  
  def text
    draw_text "This is to confirm that  #{@user.employee.title}.#{@user.employee.full_name} is a bonafide employee and is working as", size: 12, :at => [@x+40, @y-250]
    draw_text "#{@user.employee.designation.designation_name if @user.employee.designation.present?} since #{@user.employee.date_of_join.to_date.strftime("%d %b, %Y") if @user.employee.date_of_join.present? }, for Amzur Technologies Pvt Ltd and as per the company", size: 12, :at => [@x+40, @y-270]
    draw_text "records the residential address of him is as mentioned below.", size: 12, :at => [@x+40, @y-290]  
  end
  
  def details
    draw_text "Present Address", style: :bold, :at => [@x+40, @y-340]
    draw_text "#{@present_address.line}, #{@present_address.line1}, ", :at => [@x+40, @y-360]   
  
    draw_text "#{@present_address.city}, #{@present_address.state}, ", :at => [@x+40, @y-380]
    draw_text "#{@present_address.country}, #{@present_address.zipcode}. ", :at => [@x+40, @y-400]
    
    draw_text "Permanent Address", style: :bold, :at => [@x+250, @y-340]
    draw_text "#{@permanent_address.line}, #{@permanent_address.line1}, ", :at => [@x+250, @y-360]
    draw_text "#{@permanent_address.city}, #{@permanent_address.state}, ", :at => [@x+250, @y-380]
    draw_text "#{@permanent_address.country}, #{@permanent_address.zipcode}. ", :at => [@x+250, @y-400]  
  end
  
  def sign
    draw_text "Thanking You,", :at => [@x+40, @y-450] 
    draw_text "#{@hr_manager}", :at => [@x+40, @y-490]
    draw_text "Human Resources.", :at => [@x+40, @y-510]    
  end
  
  
end
