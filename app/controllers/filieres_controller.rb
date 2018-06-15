class FilieresController < ApplicationController
  def index
    @filieres = Filiere.all
  end

  def new
    @filiere = Filiere.new
  end

  def create
    
    if user_signed_in?
      if current_user.role == "admin"
        @f = Filiere.find_by(nom: params[:filiere][:nom])
        if @f.valid?
          @f.save
         
          flash[:error] = "Enregistrement filière réussi!"
          redirect_to filieres_path
        #enregistrement filiere invalide
        else
          flash[:error] = "Erreur d'enregistrement filiere!"
          redirect_to new_filiere_path
        end
      end
      #if responsable
      if session[:responsable] != nil
        #if son etablissement exist
        if session[:etab_id] != nil
          @f = Filiere.find_by(nom: params[:filiere][:nom])
          #if filiere n'existe pas
          if @f == nil
            @f = Filiere.new(nom: params[:filiere][:nom])
            
            if @f.valid?
              @f.save
             
              flash[:error] = "Enregistrement filière réussi!"
              redirect_to filieres_path
            #enregistrement filiere invalide
            else
              flash[:error] = "Erreur d'enregistrement filiere!"
              redirect_to new_filiere_path
            end
          #filiere existe déjà
          else

            flash[:error] = "Filiere dejà existe!"
            redirect_to filieres_path
            #-----------------------
          end
        #la personne n'as pas encore un établissement
        else
          flash[:error] = "Créez dabord votre établissement!"
          redirect_to new_etablissement_path  
        end
      #if not responsable
      else 
        flash[:error] = "Vous n'avez pas le droit de faire ça!"
        redirect_to filieres_path
      end
        
    else
    # pas connecté
      redirect_to user_session_path
    end
    
  end


  def show
  end

  def edit
    if user_signed_in?
      if current_user.role == "admin"
          @filiere = Filiere.find(params[:id])
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def update
    @filiere = Filiere.find(params[:id])
    filiere_params = params.require(:filiere).permit(:nom)
    @filiere.update(filiere_params)
    redirect_to filieres_path
  end

  def destroy
    @filiere = Filiere.find(params[:id])
    @filiere.destroy
    redirect_to filieres_path
  end
end
