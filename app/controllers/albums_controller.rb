class AlbumsController < ApplicationController

=begin  
  def index
    @albums = Album.all
  end
=end

  def show
    @photos = @album.photos.all
  end
  
  def new 
    @album = Album.new  
    @photo = @album.photos.build      
  end

  def create
  
    @employee = current_user.employee
    @employee.albums.create(album_params)  
    @album = Album.new(album_params)
      respond_to do |format|
        if @album.save
          params[:photos]['album'].each do |a|
            @photo = @album.photos.create!(:album => a, :album_id => @album.id)
          end
          format.html { redirect_to @album, notice: 'Album created successfully' }
        else
          format.html { render action: 'new'}
        end
      end     
  end  

  private

  def album_params
    params.require(:album).permit(:title, :description, :employee_id, photos_attributes: [ :album_id, :album])
  end 
 
end

