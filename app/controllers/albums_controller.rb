# author :Priyanka
# Controller for creating and editing Albums
class AlbumsController < ApplicationController
  def index  # Index method for displaying all album
    @albums = Album.all
  end
   
  def new   # New method creates a object for new album
    @album = Album.new
    @photo = @album.photos.build
  end

  def create  # Create method for creating album and respective photos record
    #raise album_params.inspect
    @employee = current_user.employee
    @album = @employee.albums.new(album_params)
    if @album.save
      params[:photos][:image].each do |photoimage|
        @photo = @album.photos.create(:image => photoimage, :album_id => @album.id)
      end
    redirect_to @album
    else
      format.html { render action: 'new' }
    end
  end

  def show  # Show method for displaying perticular album based on its id
    @album = Album.find(params[:id])
    @photos = @album.photos
    @id = @album.employee_id
    # raise @id.inspect
  end

  def edit
    @album = Album.find(params[:id])
    @photos = @album.photos.count
    # raise @photos.inspect
  end

  def update
    # raise params[:album][:title].inspect
    @employee = current_user.employee.id
    @album = Album.find(params[:id])
    # raise @album.inspect
    @album.update(:title => params[:album][:title], :description => params[:album][:decription])
    redirect_to @album
  end

  def destroy
    # raise params.inspect
    @album.destroy
  end

  def add_more_photos_form # method for adding new photos for album based on id
    @album = Album.find(params[:id])
    @photo = @album.photos.build
  end

  def add_more_photos
    # raise params.inspect
    @album = Album.find(params[:id])
    params[:photos][:image].each do |photoimage|
      @photo = @album.photos.create(:image => photoimage, album_id: '@album.id')
    end
    redirect_to @album
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end
end
