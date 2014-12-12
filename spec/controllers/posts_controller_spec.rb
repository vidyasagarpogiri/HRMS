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
      e = Post.create!(:title => "some title", :employee_id =>  @employee.id, :content => "some content")
      Sunspot.commit
      results = Post.solr_search { keywords "some title" }.results
      expect(results.size).to  eq(results.size)
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
        expect{ post :create, {post: FactoryGirl.attributes_for(:post, employee_id: @employee.id), hidden_tags: "Java,"}}.to change(Post,:count).by(1) 
        end
        
          it "After create redirect to index page" do
          post :create, {post: FactoryGirl.attributes_for(:post, employee_id: @employee.id), hidden_tags: "Java,"}
          expect(response).to redirect_to(posts_path) 
        end
      end
      context "with invalid attributes" do
        it "re-renders the 'new' template" do 
          post :create, post: FactoryGirl.attributes_for(:post, title:nil, employee_id: nil), hidden_tags: "Java,"
          expect(response).to render_template("new")
        end
    end
    

  end

  
  
  
  describe "PUT #update" do
    before :each do
     @updated_post = FactoryGirl.attributes_for(:post, title: "updated title") 
     @post  = FactoryGirl.create(:post)
     @invalid_post = FactoryGirl.attributes_for(:post, title: nil) 
    end 
  end
  
   describe "DESTORY delete" do 
    before(:each) do
       @post  = FactoryGirl.create(:post, employee_id: @employee.id )
    end

    it "destroys the requested Recruitment " do 
      expect{ delete :destroy, {id: @post}}.to change(Post, :count).by(-1)
    end

    it "redirect_to index page" do 
      delete :destroy, {id: @post}
      expect(response).to redirect_to(posts_path)
    end
  end
end
