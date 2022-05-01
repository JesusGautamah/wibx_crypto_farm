class WibxAccountsController < ApplicationController
  before_action :set_wibx_account, only: %i[ show edit update destroy ]

  # GET /wibx_accounts or /wibx_accounts.json
  def index
    @wibx_accounts = WibxAccount.all
  end

  # GET /wibx_accounts/1 or /wibx_accounts/1.json
  def show
  end

  # GET /wibx_accounts/new
  def new
    @wibx_account = WibxAccount.new
  end

  # GET /wibx_accounts/1/edit
  def edit
  end

  # POST /wibx_accounts or /wibx_accounts.json
  def create
    @wibx_account = WibxAccount.new(wibx_account_params)

    respond_to do |format|
      if @wibx_account.save
        format.html { redirect_to wibx_account_url(@wibx_account), notice: "Wibx account was successfully created." }
        format.json { render :show, status: :created, location: @wibx_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wibx_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wibx_accounts/1 or /wibx_accounts/1.json
  def update
    respond_to do |format|
      if @wibx_account.update(wibx_account_params)
        format.html { redirect_to wibx_account_url(@wibx_account), notice: "Wibx account was successfully updated." }
        format.json { render :show, status: :ok, location: @wibx_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wibx_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wibx_accounts/1 or /wibx_accounts/1.json
  def destroy
    @wibx_account.destroy

    respond_to do |format|
      format.html { redirect_to wibx_accounts_url, notice: "Wibx account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wibx_account
      @wibx_account = WibxAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wibx_account_params
      params.require(:wibx_account).permit(:email, :password)
    end
end
