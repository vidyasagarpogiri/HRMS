module AddressHelper

  def getCountryList
    @countries = Country.all
  end
  
  def getStateList(country_id)
    @states = State.where(:country_id=>country_id)
  end

  def getCityList(state_id)
    @cities = City.where(:state_id=>state_id)
  end
  
  
  
end
