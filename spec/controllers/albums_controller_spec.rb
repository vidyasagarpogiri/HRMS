require 'rails_helper'

RSpec.describe AlbumsController, :type => :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    employee = FactoryGirl.create(:employee)
    user = employee.user
    sign_in user
  end    
  
  describe "GET #index" do 
  	it "Generates an array of albums" do
    	album1 = FactoryGirl.create(:album) 
      album2 = FactoryGirl.create(:album) 
      album3 = FactoryGirl.create(:album)  
      get :index, {}
      expect(assigns(:albums)).to eq([album1, album2, album3]) 
    end
	end		
	    
  describe "GET new" do  
    it "Creates a new album object" do
      get :new,{}
      expect(assigns(:album)).to be_a_new(Album)
    end    
  end  
  
  describe "Post create" do
    describe "with valid attributes" do
      it "creates a valid album" do       
        expect{
          post :create, {album: FactoryGirl.attributes_for(:album), photos: {image: {image: "Hello.jpg", album_id: 1}} }
        }.to change(Album, :count). by(1)
      end      
    end       
  end   
end


