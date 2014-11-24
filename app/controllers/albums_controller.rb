class AlbumsController < ApplicationController 
  def index
    @albums = Album.all
  end
   
  def new 
    @album = Album.new  
    @photo = @album.photos.build      
  end

  def create
    @employee = current_user.employee.id  
    @album = Album.new(album_params)    
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
   @photos = @album.photos.all
  end
  
  def edit
   @album = Album.find(params[:id])
   @photos = @album.photos.all
  end
  
   def update             
    @employee = current_user.employee.id
    @album = Album.find(params[:id])
    @photo = @album.photos.find(params[:id])
  end  
  
  def destroy
		@album.destroy
		@album.photos.destroy
		redirect_to @album
	end

  private

  def album_params
    params.require(:album).permit(:title, :description, @employee, photos_attributes: [:id, :album_id, :image])
  end 
 
end

