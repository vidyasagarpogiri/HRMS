class PhotosController < ApplicationController
  
  def update
    if @photo.update(photo_params)
      format.html { redirect_to @photo.album, notice: 'photo was successfully updated.' }
    end
  end
  
  private
  def photo_params
    params.require(:photo).permit(:album_id, :image)  
  end
end


