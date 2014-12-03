# author :Priyanka
# Controller for updating and deleting Photos
class PhotosController < ApplicationController
  def update # Updates pics for photos record with respect to Album
    # raise params.inspect
    unless @photo.update(photo_params).blank?
      format.html { redirect_to @photo.album, notice: "Album's photo was successfully updated." }
    end
  end

  def destroy # Deletes photos with respect to Album
    @album = Album.find(params[:album_id])
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = 'Successfully deleted photo'
    redirect_to album_path(@album)
  end
  
  private

  def photo_params
    params.require(:photo).permit(:album_id, :image)
  end
end
