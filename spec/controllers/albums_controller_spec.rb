require 'rails_helper'

RSpec.describe AlbumsController, :type => :controller do

  let(:album_attributes){
    {title: "Album1", description: "Just demo"}
  }
  
  let(:invalid_album_attributes){
    {title: nil, description: "Just demo"}
  }
  
  describe "GET index" do
    it "List of all Albums @albums" do
      album = Album.create!(album_attributes)
      album1 = Album.create!(invalid_album_attributes)
      get :index,{}
      expect(assigns(:albums)).to eq([album,album1])
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
          Post :create, {:album => album_attributes }
        }.to change(Album, :count). by(1)
      end
    end
    
    describe "with invalid attributes" do
      it "create Album with in valid attributes" do       
        Post :create, {:album => invalid_album_attributes }
        expect(assigns(:album)).to eq([Album])
      end
      it "re-directing to new template" do
        Post :create, {:album => invalid_album_attributes }
        expect(response).to redirect-template("new")
      end
    end
  end
  
  

end
