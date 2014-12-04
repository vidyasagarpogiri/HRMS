require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

  before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @employee = FactoryGirl.create(:employee)
      user = @employee.user
      sign_in user
    end
    
    
    describe "GET #index" do 
  	it "Sunspot works", :solr => true do
      e = Post.create!(:title => "some title", :employee_id =>  1, :content => "some content")
      Sunspot.commit
      results = Post.solr_search { keywords "some title" }.results
      expect(results.size).to   eq(1)
    end 
	end
	
	
	describe "GET #new" do
    it "redirect to new page " do
      get :new, {}
      expect(assigns(:post)).to be_a_new(Post)
    end
  end
  
  
  describe "POST #create" do
    context "with valid attributes" do
      it "When we create a new record" do
      
      end
      
    end

  end

  

end
