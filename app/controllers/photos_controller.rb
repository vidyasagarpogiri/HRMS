class PhotosController < ApplicationController   
  #author :Priyanka
  #Controller for updating and deleting Photos
  
    
 def update
 raise params.inspect
   if @photo.update(photo_params)
     format.html { redirect_to @photo.album, notice: "Album's photo was successfully updated." }
   end 
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


