class ReferenceLetter < Prawn::Document
  def initialize(user)
    super()
    @user = user
    @y = 700
    @x = 0
    logo
    date
    header
    text
    sign
    hr
  end
  
  def logo
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/amzur-logo.png", :position => :right, :width => 150, :height => 80, :at => [350,700]    
  end
  
  def date
    draw_text "#{Time.now.strftime("%Y-%m-%d")}", size: 13, :at => [@x+15, @y-100]
  end
  
  def header
    draw_text "TO WHOMSOEVER IT MAY CONCERN", style: :bold, size: 15, :at => [@x+150, @y-130]
  end
  
  def text
    draw_text "This is to certify that #{@user.employee.full_name} is a bonafide employee of our Company" , size: 13, :at => [@x+15, @y-200]
    draw_text "(Amzur Technologies Pvt Ltd) and is working as  #{@user.employee.full_name.designation.designation_name if @user.employee.designation.present?}. We confirm that" , size: 13, :at => [@x+15, @y-220] 
    draw_text "he/she has been working in our company since #{@user.employee.date_of_join}.", size: 13, :at => [@x+15, @y-240]
  end
  
  def sign
    draw_text "Yours sincerely,", :at => [@x+15, @y-340]
  end
   
  def hr
    draw_text "Ravi Nuni", :at => [@x+15, @y-400]
    draw_text "Human Resources", :at => [@x+15, @y-420]
  end 
 
end
