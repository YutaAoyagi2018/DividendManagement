class CountoriesController < ApplicationController
  before_action :set_countory, only: %i[ show edit update destroy ]

  # GET /countories or /countories.json
  def index
    @countories = Countory.all
  end

  # GET /countories/1 or /countories/1.json
  def show
  end

  # GET /countories/new
  def new
    @countory = Countory.new
  end

  # GET /countories/1/edit
  def edit
  end

  # POST /countories or /countories.json
  def create
    @countory = Countory.new(countory_params)

    respond_to do |format|
      if @countory.save
        format.html { redirect_to countory_url(@countory), notice: "Countory was successfully created." }
        format.json { render :show, status: :created, location: @countory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @countory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countories/1 or /countories/1.json
  def update
    respond_to do |format|
      if @countory.update(countory_params)
        format.html { redirect_to countory_url(@countory), notice: "Countory was successfully updated." }
        format.json { render :show, status: :ok, location: @countory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @countory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countories/1 or /countories/1.json
  def destroy
    @countory.destroy

    respond_to do |format|
      format.html { redirect_to countories_url, notice: "Countory was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_countory
      @countory = Countory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def countory_params
      params.require(:countory).permit(:name)
    end
end
