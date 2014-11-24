class PhotosController < ApplicationController

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo.album, notice: 'photo was successfully updated.' }
      end 
    end
  end

end
