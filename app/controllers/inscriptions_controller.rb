class InscriptionsController < ApplicationController
  def index
    @inscriptions = Inscription.all
  end

  def show
  end

  def new
    if user_signed_in?
      if current_user.role == nil 
        #si c'est un étudiant
        @inscription = Inscription.new
      else
        flash[:error] = "Tsy mpianatra ianao!"
        redirect_to inscriptions_path
      end
    else
      flash[:error] = "Ampidiro ny mombamomba anao azafady!"
      redirect_to user_session_path
    end
  end

  def create

    @etab = Etablissement.find(params[:inscription][:etablissement_id])
    @filiere = Filiere.find(params[:inscription][:filiere_id])
    @province = Province.find(params[:inscription][:province_id])
    @vague = Vague.find(params[:inscription][:vague_id])
    @level = Level.find(params[:inscription][:level_id])

    #raha ao @ ilay province ilay universite======================
    if @etab.province == @province
      #jerena n filiere niveau
      test = false
      @f_e = AssociateFiliereEtab.where(etablissement_id: @etab.id)
      @f_e.each do |a|
        if a.filiere == @filiere && a.level == @level
          test = true
        end
      end
      if test 
          #ok
              #tout les inscrits dans une établissement donné
        @inscrit = Inscription.where(etablissement_id: @etab.id)
        couple =false
        @inscrit.each do |assoc|
          # si l'etudiant en question est déjà inscrit dans une session donné
            if assoc.user_id == current_user && assoc.vague_id == @vague
                # couple déjà existé
                couple = true
            end
        end

        # couple déjà existé
        if couple 
            flash[:error] = "Efa voasoratra ianao!"
            redirect_to etablissement_path(@etab.id)
        else
            inscri = Inscription.new()
            inscri.filiere = @filiere
            inscri.etablissement = @etab
            inscri.level = @level
            inscri.vague = @vague
            inscri.province = @province
            inscri.user = current_user
            
            if inscri.save
                flash[:error] = "Félicitation, vous êtes inscrit!"
                redirect_to etablissement_path(@etab.id)
            else
                flash[:error] = "Erreur lors d'inscription! Champ invalid peut être"
                redirect_to new_etablissement_path
            end
        end

      else
        # tsy misy anio filiere @ io niveau io ao 
        flash[:error] = "tsy misy anio filiere @ io niveau io ao "
        redirect_to new_inscription_path
      end
    else
        flash[:error] = "TSy misy an'io université io any @ io province io"
        redirect_to new_inscription_path
    end
        
  end

  def edit
  end

  def update
  end

  def delete
  end
end
