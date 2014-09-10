class WelcomeController < ApplicationController

  layout "demo_template"
  
  def index
    render :layout => false
  end
  
  def hello
  end

end
