require 'faraday'

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
    if image.nil?
      @create_content_dto.image = ''
    else
      hash = { data: Base64.strict_encode64(IO.binread(image.tempfile)), type: image.content_type }
      @create_content_dto.image = hash.to_json
    end

    # Format start and end dates
    start_date = params[:dates][:start].split("-").reverse
    @create_content_dto.start_date = start_date.join('-')
    end_date = params[:dates][:end].split("-").reverse
    @create_content_dto.end_date = end_date.join('-')

    # Check which button has been pressed and act accordingly
    case params[:submit_btn]
      # Render show view as external tab
    when 'Vis'
      render 'show'

      # Send post via faraday to API
    when 'Gem'

      # Change type to english
      case @create_content_dto.content_type
      when 'Nyhed'
        @create_content_dto.content_type = 'News'

      when 'Event'
        @create_content_dto.content_type = 'Event'

      else
        @create_content_dto.content_type

      end

      # Add missing attributes (creation_time, author)
      @create_content_dto.creation_time = Time.now.strftime("%d-%m-%Y")
      @create_content_dto.author = "Feature not implemented"

      payload_henrik = {
        id: 21,
        type: @create_content_dto.content_type,
        title: @create_content_dto.title,
        sites: @create_content_dto.sites,
        body: @create_content_dto.body,
        image: @create_content_dto.image,
        startDate: @create_content_dto.end_date,
        endDate: @create_content_dto.start_date,
        creationTime: @create_content_dto.creation_time,
        author: @create_content_dto.author
      }

      response = base_connection.post('contents') do |req|
        req.body = payload_henrik.to_json
      end

      render json: response.status
    else

      # This is useless, unless weird bug happens
      render formats: :json
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

  # Base connection for Faraday
  def base_connection
    Faraday.new(
      url:'https://ascendance.hrmoller.com/api/',
      headers: {'Content-Type' => 'application/json'}
    )
  end
end
