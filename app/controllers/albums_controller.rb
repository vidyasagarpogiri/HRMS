# author :Priyanka
# Controller for creating and editing Albums
class AlbumsController < ApplicationController
  def index  # Index method for displaying all album
    @albums = Album.all.order('created_at DESC')
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
        @photo = @album.photos.create(:image => photoimage)
      end
    redirect_to welcome_wall_path
    else
      format.html { render action: 'new' }
    end
  end
  
  def add_like # action to like album
    @album = Album.find(params[:id])
    @like = @album.likes.create(employee_id: params[:employee_id])
    if (@album.likes_count == nil)
      @album.update(:likes_count => 0)
    end
    if @like
      @like.update is_like: true
    else
      @like = Like.create(is_like: true, employee_id: params[:employee_id])
    end
    count = @album.likes_count
    @album.update likes_count: count + 1 # increases the likes count by one
    @album.update(updated_at: Time.now)
    @album = Album.new
  end

  def remove_like # unlikes the Album which is being liked previously
    @album = Album.find(params[:id])
    employee = current_user.employee
    @like = @album.likes.where(employee_id: employee.id).first
    @like.update is_like: false
    count = @album.likes_count
    @album.update likes_count: count - 1 # decreases the likes count by one
    @album.update(updated_at: Time.now)
    @like.destroy
    @album = Album.new
    #redirect_to welcome_wall_path
  end

  def show  # Show method for displaying perticular album based on its id
    @album = Album.find(params[:id])
    @photos = @album.photos
    @id = @album.employee_id
    # raise @id.inspect
  end
  
  def add_comment # Creating object to New comment(form)
    @comment = @album.comment.new
    @album = Album.find(params[:id])
    @album.update(updated_at: Time.now)
  end  

  def add_comments #Action to create comment to respective album 
    @album = Album.find(params[:album_id])
    @employee = current_user.employee
    @album.comments.create(comment: params[:comment], employee_id: @employee.id)
    @album.update(updated_at: Time.now)
    redirect_to welcome_wall_path
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
      @photo = @album.photos.create(:image => photoimage)
    end
    redirect_to @album
  end

  private

  def album_params
    params.require(:album).permit(:title, :description)
  end
end
