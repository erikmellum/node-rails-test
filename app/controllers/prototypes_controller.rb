class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  skip_before_filter  :verify_authenticity_token
  # GET /prototypes
  # GET /prototypes.json
  def index
    @prototypes = Prototype.all
  end

  # GET /prototypes/1
  # GET /prototypes/1.json
  def show
  end

  # GET /prototypes/new
  def new
    @prototype = Prototype.new
  end

  # GET /prototypes/1/edit
  def edit
  end

  # POST /prototypes
  # POST /prototypes.json
  def create
     puts "#{params[:attachment]}"
     @temp_upload = Prototype.new(filename: params[:attachment])

     @upload = Prototype.where(:filename => @temp_upload.filename).first

     if @upload.nil?
       @upload = Prototype.create(filename: params[:attachment])
     else
      #  if @upload.upload_file_size.nil?
      #    @upload.upload_file_size = @temp_upload.upload_file_size
      #  else
      #   @upload.upload_file_size += @temp_upload.upload_file_size
      # end
     end

    p = params[:attachment]
    name = p.original_filename
    directory = "tmp/uploads"

    path = File.join(directory, name.gsub(" ", "_"))
    puts(path)
    File.open(path, "ab") { |f| f.write(p.read) }

    respond_to do |format|
      if @upload.save
        format.html {
          render :json => [@upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@upload]}, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prototypes/1
  # PATCH/PUT /prototypes/1.json
  def update
    respond_to do |format|
      if @prototype.update(prototype_params)
        format.html { redirect_to @prototype, notice: 'Prototype was successfully updated.' }
        format.json { render :show, status: :ok, location: @prototype }
      else
        format.html { render :edit }
        format.json { render json: @prototype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prototypes/1
  # DELETE /prototypes/1.json
  def destroy
    @prototype.destroy
    respond_to do |format|
      format.html { redirect_to prototypes_url, notice: 'Prototype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prototype_params
      #params.require(:prototype).permit(:filename, :directory)
    end
end
