class CreateContentDtosController < ApplicationController
  before_action :set_create_content_dto, only: %i[ show edit update destroy ]

  # GET /create_content_dtos or /create_content_dtos.json
  def index
    @create_content_dtos = CreateContentDto.all
  end

  # GET /create_content_dtos/1 or /create_content_dtos/1.json
  def show
  end

  # GET /create_content_dtos/new
  def new
    @sites_options = ['Ordbogen.com', 'Abc-ordbogen.com']
    @create_content_dto = CreateContentDto.new
  end

  # GET /create_content_dtos/1/edit
  def edit
  end

  # POST /create_content_dtos or /create_content_dtos.json
  def create
    @create_content_dto = CreateContentDto.new(create_content_dto_params)

    # This makes sites work, for some reason it doesn't do it automatically, same for content_type
    @create_content_dto.sites = params[:sites]
    @create_content_dto.content_type = params[:content_type]

    # Convert the file to a hash containing a data field & a type field
    # Unless: If NilClass don't do it, to escape error.
    image = params[:create_content_dto][:image]
    hash = { data: Base64.strict_encode64(IO.binread(image.tempfile)), type: image.content_type} unless image.class == NilClass
    @create_content_dto.image = hash.to_json unless image.class == NilClass

    # Add missing attributes (creation_time, author)
    @create_content_dto.creation_time = Time.now.strftime("%d-%m-%Y")
    @create_content_dto.author = "Feature not implemented"

    # Format the dates so it is correct format
    start_date = params[:dates][:start].split("-").reverse
    @create_content_dto.start_date = start_date.join('-')
    end_date = params[:dates][:end].split("-").reverse
    @create_content_dto.end_date = end_date.join('-')

    # Check which button has been pressed and act accordingly
    puts "Which button? " + params[:submit_btn].to_s
    case params[:submit_btn]
    when 'Vis'
      render 'show'
    when 'Gem'
      render formats: :json
    else
      # IDK WHERE THIS LEADS
      render create_content_dto_path
    end


    #    respond_to do |format|
    #  if @create_content_dto.save
    #    format.html { redirect_to create_content_dto_url(@create_content_dto), notice: "Create content dto was successfully created." }
    #    format.json { render :show, status: :created, location: @create_content_dto }
    #  else
    #    format.html { render :new, status: :unprocessable_entity }
    #    format.json { render json: @create_content_dto.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /create_content_dtos/1 or /create_content_dtos/1.json
  def update
    respond_to do |format|
      if @create_content_dto.update(create_content_dto_params)
        format.html { redirect_to create_content_dto_url(@create_content_dto), notice: "Create content dto was successfully updated." }
        format.json { render :show, status: :ok, location: @create_content_dto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @create_content_dto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /create_content_dtos/1 or /create_content_dtos/1.json
  def destroy
    @create_content_dto.destroy

    respond_to do |format|
      format.html { redirect_to create_content_dtos_url, notice: "Create content dto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_create_content_dto
      @create_content_dto = CreateContentDto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def create_content_dto_params
      params.require(:create_content_dto).permit(:content_type, :title, :end_date, :start_date, :image, :body, :sites)
    end
end
