# frozen_string_literal: true

# Face Accounts Controller
class FaceAccountsController < ApplicationController
  before_action :set_face_account, only: %i[ show edit update destroy ]

  # GET /face_accounts or /face_accounts.json
  def index
    @face_accounts = FaceAccount.all
  end

  # GET /face_accounts/1 or /face_accounts/1.json
  def show
  end

  # GET /face_accounts/new
  def new
    @face_account = FaceAccount.new
  end

  # GET /face_accounts/1/edit
  def edit
  end

  # POST /face_accounts or /face_accounts.json
  def create
    @face_account = FaceAccount.new(face_account_params)

    respond_to do |format|
      if @face_account.save
        format.html { redirect_to face_account_url(@face_account), notice: "Face account was successfully created." }
        format.json { render :show, status: :created, location: @face_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @face_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /face_accounts/1 or /face_accounts/1.json
  def update
    respond_to do |format|
      if @face_account.update(face_account_params)
        format.html { redirect_to face_account_url(@face_account), notice: "Face account was successfully updated." }
        format.json { render :show, status: :ok, location: @face_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @face_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /face_accounts/1 or /face_accounts/1.json
  def destroy
    @face_account.destroy

    respond_to do |format|
      format.html { redirect_to face_accounts_url, notice: "Face account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_face_account
      @face_account = FaceAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def face_account_params
      params.require(:face_account).permit(:email, :password)
    end
end
