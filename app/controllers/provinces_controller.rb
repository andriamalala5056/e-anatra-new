class ProvincesController < ApplicationController
  before_action :set_province, only: [:show, :edit, :update, :destroy]

  # GET /provinces
  # GET /provinces.json
  def index
    @provinces = Province.all
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
  end

  # GET /provinces/new
  def new
    if user_signed_in?
      if current_user.role == "admin"
        @province = Province.new
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # GET /provinces/1/edit
  def edit
    if user_signed_in?
      if current_user.role != "admin"
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # POST /provinces
  # POST /provinces.json
  def create
    @province = Province.new(province_params)

    respond_to do |format|
      if @province.save
        format.html { redirect_to @province, notice: 'Province was successfully created.' }
        format.json { render :show, status: :created, location: @province }
      else
        format.html { render :new }
        format.json { render json: @province.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provinces/1
  # PATCH/PUT /provinces/1.json
  def update
    if user_signed_in?
      if current_user.role == "admin"
        respond_to do |format|
          if @province.update(province_params)
            format.html { redirect_to @province, notice: 'Province was successfully updated.' }
            format.json { render :show, status: :ok, location: @province }
          else
            format.html { render :edit }
            format.json { render json: @province.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /provinces/1
  # DELETE /provinces/1.json
  def destroy
    if user_signed_in?
      if current_user.role == "admin"
        @province.destroy
        respond_to do |format|
          format.html { redirect_to provinces_url, notice: 'Province was successfully destroyed.' }
          format.json { head :no_content }
        end
      else
      redirect_to root_path
      end
    else
      redirect_to root_path  
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_province
      @province = Province.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def province_params
      params.require(:province).permit(:nom)
    end
end
