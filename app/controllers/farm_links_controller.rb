class FarmLinksController < ApplicationController
  before_action :set_farm_link, only: %i[ show edit update destroy ]

  # GET /farm_links or /farm_links.json
  def index
    @pagy, @farm_links = pagy(FarmLink.all)
  end

  # GET /farm_links/1 or /farm_links/1.json
  def show
  end
  
  # GET /farm_links/1/edit
  def edit
  end

  # POST /farm_links or /farm_links.json
  def create
    @farm_link = FarmLink.new(farm_link_params)

    respond_to do |format|
      if @farm_link.save
        format.html { redirect_to farm_link_url(@farm_link), notice: "Farm link was successfully created." }
        format.json { render :show, status: :created, location: @farm_link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @farm_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /farm_links/1 or /farm_links/1.json
  def update
    respond_to do |format|
      if @farm_link.update(farm_link_params)
        format.html { redirect_to farm_link_url(@farm_link), notice: "Farm link was successfully updated." }
        format.json { render :show, status: :ok, location: @farm_link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @farm_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /farm_links/1 or /farm_links/1.json
  def destroy
    @farm_link.destroy

    respond_to do |format|
      format.html { redirect_to farm_links_url, notice: "Farm link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_farm_link
      @farm_link = FarmLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def farm_link_params
      params.require(:farm_link).permit(:href)
    end
end
