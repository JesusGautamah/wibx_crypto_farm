# frozen_string_literal: true

# Wibx Products Controller
class WibxProductsController < ApplicationController
  before_action :set_wibx_product, only: %i[ show edit update destroy ]

  # GET /wibx_products or /wibx_products.json
  def index
    @wibx_products = WibxProduct.all
  end

  # GET /wibx_products/1 or /wibx_products/1.json
  def show
  end

  # GET /wibx_products/new
  def new
    @wibx_product = WibxProduct.new
  end

  # GET /wibx_products/1/edit
  def edit
  end

  # POST /wibx_products or /wibx_products.json
  def create
    @wibx_product = WibxProduct.new(wibx_product_params)

    respond_to do |format|
      if @wibx_product.save
        format.html { redirect_to wibx_product_url(@wibx_product), notice: "Wibx product was successfully created." }
        format.json { render :show, status: :created, location: @wibx_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wibx_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wibx_products/1 or /wibx_products/1.json
  def update
    respond_to do |format|
      if @wibx_product.update(wibx_product_params)
        format.html { redirect_to wibx_product_url(@wibx_product), notice: "Wibx product was successfully updated." }
        format.json { render :show, status: :ok, location: @wibx_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wibx_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wibx_products/1 or /wibx_products/1.json
  def destroy
    @wibx_product.destroy

    respond_to do |format|
      format.html { redirect_to wibx_products_url, notice: "Wibx product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wibx_product
      @wibx_product = WibxProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wibx_product_params
      params.require(:wibx_product).permit(:title, :facebook_link, :whatsapp_link, :telegram_link, :facebook_gain, :whatsapp_gain, :telegram_gain, :facebook_requests, :whatsapp_requests, :telegram_requests, :total_user_product_gain, :user_facebook_gain, :user_whatsapp_gain, :user_telegram_gain, :status)
    end
end
