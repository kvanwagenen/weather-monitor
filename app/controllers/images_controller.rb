class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    upload_image
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def upload_image
      if data = image_data
        # source = Magick::Image.from_blob(Base64.decode64(data)).first
        # source.add_profile(Rails.root + 'config/iccprofiles/srgb.icc')
        # x, y = source.columns, source.rows
        # max_dim = 1920
    
        # sizes = [{min: 0, resize: max_dim, quality: 100}]
        hash = Digest::MD5.hexdigest(Base64::decode64(data))
    
        # output = source.extent(max_dim,max_dim,-((max_dim-x)/2).ceil,-((max_dim-y)/2).ceil)
        # output.strip!
        # output.format = 'JPG'
    
        credentials = Aws::Credentials.new(Setting.find_by_key('aws_access_key_id').value, Setting.find_by_key('aws_secret_access_key').value)
        s3 = Aws::S3::Client.new(region: 'us-east-1', credentials: credentials)
    
        # sizes.each do |size|
        #   if max_dim >= size[:min]
        #     new_size = (size[:resize] || size[:min])
        #     sized_image = output.resize(new_size,new_size)
        #     sized_image.format = 'JPG'
            # s3.put_object(acl: 'public-read', bucket: 'images.ziggos.com', body: sized_image.to_blob{self.quality = (size[:quality] || 70)}, key: "weather-images/#{hash}.jpg")
        bucket = 'static.ziggos.com'
        key = "weather-images/#{hash}.jpg"
        s3.put_object(acl: 'public-read', bucket: bucket, body: Base64::decode64(data), key: key)
          # end
        # end
        @image.url = "http://#{bucket}/#{key}"
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:time, :position)
    end
    
    def image_data
      params.require(:image).require(:image_data)
    end
end
