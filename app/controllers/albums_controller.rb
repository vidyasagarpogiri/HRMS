class AlbumsController < ApplicationController 
  def index
    @albums = Album.all
  end
   
  def new 
    @album = Album.new  
    @photo = @album.photos.build      
  end

  def create
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
   
  def show
   @album = Album.find(params[:id])
   @photos = @album.photos
  end
  
  def edit
   @album = Album.find(params[:id])
   @photos = @album.photos
  end
  
   def update          
    @employee = current_user.employee.id
    @album = Album.find(params[:id])
    @photo = @album.photos.find(params[:id])
  end  
  
 def destroy
    #raise params.inspect
    @album.destroy
  
    
  end

  def add_more_photos_form
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

