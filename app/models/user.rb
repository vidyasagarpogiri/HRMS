class User < ActiveRecord::Base
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :invitable, :omniauth_providers => [:google_oauth2]
      
         
  def self.from_omniauth(auth)
    if auth.extra.raw_info.hd == "amzur.com"
    #raise auth.inspect
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.token = auth.credentials.token
        user.secret = auth.credentials.secret
        user.email = auth.info.email
        #user.name = auth.info.name
        #user.remote_avatar_url = auth.info.image
        #user.save!
      end
    else
      false
    end
  end
  
  has_one :employee
  def password_required?
    super && provider.blank?
  end 
 
	def department
	  employee.department.department_name	
	end
	


end
