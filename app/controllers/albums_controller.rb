class AlbumsController < ApplicationController 
  #author :Priyanka
  #Controller for creating and editing Albums

  
  def index  #Index method for displaying all albums
    @albums = Album.all
  end
   
  def new   #New method creates a object for new album
    @album = Album.new  
    @photo = @album.photos.build      
  end

  def create  #Create method for creating album and respective photos record
     #raise params.inspect   
    @employee = current_user.employee
    @album = @employee.albums.create(album_params)    
     if @album.save
      params[:photos][:image].each do |a|
          @photo = @album.photos.create(:image => a, :album_id => @album.id)
       end
     redirect_to @album
     else
       format.html { render action: 'new' }
     end  
  end  
   
  def show  #Show method for displaying perticular album based on its id
   @album = Album.find(params[:id])
   @photos = @album.photos
   @id = @album.employee_id
   #raise @id.inspect
  end
  
  def edit  
   @album = Album.find(params[:id])
   @photos = @album.photos.count
   #raise @photos.inspect
  end
  
   def update 
   #raise params[:album][:title].inspect
             
     @employee = current_user.employee.id
     @album = Album.find(params[:id])
     #raise @album.inspect
     @album.update(:title => params[:album][:title], :description => params[:album][:decription])
     redirect_to @album
   end  
  
 def destroy
    #raise params.inspect
    @album.destroy
  
    
  end

  def add_more_photos_form #method for adding new photos for a album based on its id
    @album = Album.find(params[:id]) 
    @photo = @album.photos.build      
  end
  
  def add_more_photos
  #raise params.inspect
  @album = Album.find(params[:id]) 
    params[:photos][:image].each do |a|
          @photo = @album.photos.create(:image => a, :album_id => @album.id)
    end
     redirect_to @album 
  end
  private

  def album_params
    params.require(:album).permit(:title, :description, photos_attributes: [:id, :album_id, :image])
  end 
 
end

