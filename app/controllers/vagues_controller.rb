class VaguesController < ApplicationController
  
  # GET /vagues
  # GET /vagues.json
  def index
      @vagues = Vague.all
  end

  # GET /vagues/1
  # GET /vagues/1.json
  def show
    
  end

  # GET /vagues/new
  def new
    if user_signed_in?
      if current_user.role == "admin"
        @vague = Vague.new
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # GET /vagues/1/edit
  def edit
    
  end

  # POST /vagues
  # POST /vagues.json
  def create
    v = Vague.new()
    v.rentree = params[:vague][:rentree]
    v.etablissement = Etablissement.find(params[:vague][:etablissement_id])
    v.save
    redirect_to vagues_path
  end

  # PATCH/PUT /vagues/1
  # PATCH/PUT /vagues/1.json
  def update
    
  end

  # DELETE /vagues/1
  # DELETE /vagues/1.json
  def destroy
    
  end

end
