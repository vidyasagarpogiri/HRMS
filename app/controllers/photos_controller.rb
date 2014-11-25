class PhotosController < ApplicationController
 
 def edit
  #raise params.inspect
  @photo = Photo.find(params[:id])
  #raise @photo.inspect    
 end
 
 
  
 def update
 raise params.inspect
   if @photo.update(photo_params)
     format.html { redirect_to @photo.album, notice: "Album's photo was successfully updated." }
   end 
 end
 
  def show
    @photo = Photo.find(params[:id])
    @album = @photo.album
    #raise @photo.inspect
  end
 
  def destroy
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully deleted photo"
    redirect_to album_path(@album)
  end
  
 private
  def photo_params
    params.require(:photo).permit(:album_id, :image)  
  end
end


