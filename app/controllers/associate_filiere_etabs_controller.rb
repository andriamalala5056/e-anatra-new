class AssociateFiliereEtabsController < ApplicationController
    def index
            if user_signed_in?
              #a=AssociateUserEtab.find_by(user_id: current_user.id)
              #@e = a.etablissement
              @f_etab = AssociateFiliereEtab.where(etablissement_id: session[:etab_id])
            else
                redirect_to user_session_path
            end
    end

    def new
        @assoc_fil_etab = AssociateFiliereEtab.new
    end

    def create
        @a = AssociateFiliereEtab.where(etablissement_id: session[:etab_id])
        @f = Filiere.find(params[:associate_filiere_etab][:filiere_id])
        @e = Etablissement.find(session[:etab_id])
        @n = Level.find(params[:associate_filiere_etab][:level_id])
        couple =false
        @a.each do |assoc|
            if assoc.filiere == @f && assoc.etablissement == @e && assoc.level == @n
                # couple déjà existé
                couple = true
            end
        end

        # couple déjà existé
        if couple 
            flash[:error] = "Données déjà existés!"
            redirect_to associate_filiere_etabs_path
        else
            afu = AssociateFiliereEtab.new()
            afu.filiere = @f
            afu.etablissement = @e
            afu.level = @n
            afu.place = params[:associate_filiere_etab][:place].to_i
            if afu.save
                flash[:error] = "Enregistrement filière avec niveau réussi dans votre étab!"
                redirect_to associate_filiere_etabs_path
            else
                flash[:error] = "Erreur d'enregistrement filière avec niveau!"
                redirect_to new_associate_filiere_etab_path
            end
        end
        
    end

    def destroy
        @f_etab = AssociateFiliereEtab.find(params[:id])
        @f_etab.destroy
        redirect_to associate_filiere_etabs_path
    end
end
