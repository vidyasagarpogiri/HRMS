class ReferenceLetter < Prawn::Document
  def initialize(user, hr_manager)
    super()
    @user = user
    @hr_manager = hr_manager
    @y = 700
    @x = 0
    logo
    date
    header
    text
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
    draw_text "TO WHOMSOEVER IT MAY CONCERN", style: :bold, size: 15, :at => [@x+150, @y-130]
  end
  
  def text
    draw_text "This is to certify that  #{@user.employee.title}.#{@user.employee.full_name} is a bonafide employee of our Company" , size: 12, :at => [@x+40, @y-200]
    draw_text "(Amzur Technologies Pvt Ltd) and is working as #{@user.employee.designation.designation_name if @user.employee.designation.present?}. We confirm that" , size: 12, :at => [@x+40, @y-220] 
    draw_text "he/she has been working in our company since #{@user.employee.date_of_join.to_date.strftime("%d %b, %Y") if @user.employee.date_of_join.present? }.", size: 12, :at => [@x+40, @y-240]

  end
  
  def sign
    draw_text "Yours sincerely,", :at => [@x+40, @y-340] 
    draw_text "#{@hr_manager},", :at => [@x+40, @y-400]
    draw_text "Human Resources", :at => [@x+40, @y-420]
  end 
 
end
