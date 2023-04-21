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
    @create_content_dto = CreateContentDto.new
  end

  # GET /create_content_dtos/1/edit
  def edit
  end

  # POST /create_content_dtos or /create_content_dtos.json
  def create
    @create_content_dto = CreateContentDto.new(create_content_dto_params)

    respond_to do |format|
      if @create_content_dto.save
        format.html { redirect_to create_content_dto_url(@create_content_dto), notice: "Create content dto was successfully created." }
        format.json { render :show, status: :created, location: @create_content_dto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @create_content_dto.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:create_content_dto).permit(:type, :title, :end_date, :start_date, :image, :body, :sites, :creation_tme, :author)
    end
end
