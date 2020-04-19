class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index ]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
   # if params[:tag]
     # @albums = Album.tagged_with(params[:tag])
    #else
   #   @albums = Album.all
   # end

   #  @albums = Album.all
   # @albums = Album.order(:last_name).page(params[:page])
   var = current_user.admin
      if var ==true
          @albums = Album.all
          @albums = Album.order(:title).page(params[:page])
      else
          @albums = current_user.albums.page(params[:page])
      end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
   # @albums = Album.image.all
    #@albums = Album.images.order(:none).page(params[:page])
   # @album = Album.find(params[:current.user.email])
  end
  
  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
    @album.user = current_user
    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
 
  # DELETE /albums/1.json
  def destroy
    
   @album.destroy
       respond_to do |format|
        format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
        format.json { head :no_content }
       end
  end

  def delete_upload

    attachment = ActiveStorage::Attachment.find(params[:id])
    
    attachment.purge # or use purge_later
    
    redirect_back(fallback_location: albums_url)
    
  end

  def tagged
    if params[:tag].present?
      @albums = Album.tagged_with(params[:tag])
    else
      @ablums = Album.all
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:title, :discription, :tag_list, images: [])
    end
end
