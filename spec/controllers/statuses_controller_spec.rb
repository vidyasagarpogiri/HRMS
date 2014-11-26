require 'rails_helper'

RSpec.describe StatusesController, :type => :controller do

   before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      current_user = FactoryGirl.create(:employee)
      #user = employee.user
      #sign_in user
    end
    
let(:valid_status_attributes) {
    {status: "Hello New Status", employee_id: current_user }
  }

  let(:invalid_status_attributes) {
    {status: nil, employee_id: current_user}
  }

  describe "GET index" do
    it "assigns all statuses as @statuses" do
      status = Status.create!(valid_status_attributes)
      status1 = Status.create!(valid_status_attributes)
      get :index, {}
      expect(assigns(:statuses)).to eq([status, status1])
    end
     
  end
=begin  
  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}
      expect(assigns(:user)).to be_a_new(User)
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_user_attributes}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user to @user" do
        post :create, {:user => valid_user_attributes}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the index page" do
        post :create, {:user => valid_user_attributes}
        expect(response).to redirect_to(users_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_user_attributes}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {:user => invalid_user_attributes}
        expect(response).to render_template("new")
      end
    end
  end


  describe "GET edit" do
    it "assigns the requested user as @user" do
      user = User.create!(valid_user_attributes)
      get :edit, {:id => user}
      expect(assigns(:user)).to eq(user)
    end
  end
  
  
  describe "PUT update" do
    describe "with valid params" do
      let(:new_user_attributes) {
        {fisrt_name: "Sridhar", last_name: "Vedula", city: "Hyd"}
      }


      it "assigns the requested user as @user" do
        user = User.create!(valid_user_attributes)
        put :update, {:id => user.to_param, :user => new_user_attributes}
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
       user = User.create!(valid_user_attributes)
        put :update, {:id => user, :user => new_user_attributes}
        expect(response).to redirect_to(users_path)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_user_attributes
        put :update, {:id => user, :user => invalid_user_attributes}
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_user_attributes
        put :update, {:id => user.to_param, :user => invalid_user_attributes}
        expect(response).to render_template("edit")
      end
    end
  end
  
   describe "DELETE destroy" do
    it "destroys the requested user" do
      user = User.create! valid_user_attributes
      expect {
        delete :destroy, {:id => user}
      }.to change(User, :count).by(0)
    end

    it "redirects to the user list" do
      user = User.create!(valid_user_attributes)
      delete :destroy, {:id => user.to_param}
      expect(response).to redirect_to(users_url)
    end
  end
  
  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_user_attributes
      get :show, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end
=end
end
