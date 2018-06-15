class EtablissementsController < ApplicationController
  before_action :get_id, only: [:show, :update, :destroy, :likes]

  def index
    @q = Etablissement.ransack(params[:q])
    @etablissements = @q.result.page(params[:page]).per(8)
  end

  def show

  end

  def new
    if user_signed_in?
      if session[:responsable] != nil
        if session[:etab_id] == nil
        @etablissement = Etablissement.new
        else
          flash[:error] = "Vous avez déjà votre établissement!"
          redirect_to etablissement_path(session[:etab_id])
        end
      else
        flash[:error] = "Vous n'êtes pas un responsable!"
        redirect_to etablissements_path
      end
    else
      flash[:error] = "Sign in please!"
      redirect_to user_session_path      
    end
  end

  def create

    @p = Province.find(params[:etablissement][:province_id])
   
    #@etablissement = Etablissement.new(etablissement_params)
    #@etablissement.image_etablissement = params[:etablissement][:image_etablissement]
    #if @etablissement.save
     # redirect_to etablissements_path
    #else
    #  redirect_to etablissements_path
    #end
    # en tant que responsable = CREER SON ETABLISSEMENT
    test = false
    if user_signed_in?
      # si la personne est RESPONSABLE
      if session[:responsable] != nil
        # si le responsable n'a pas un établissement
        if session[:etab_id] == nil
          # la personne peut créer son étab
          @etablissement = Etablissement.new(etablissement_params)

          @etablissement.responsable_id = current_user.id  # qui est le responsable de cet établissement
          @etablissement.image_etablissement = params[:etablissement][:image_etablissement]
          puts "===================="
            puts @etablissement.nom
            puts @etablissement.mail
            puts @etablissement.telephone
            puts @etablissement.adress
            puts @etablissement.description
            puts @etablissement.category
            puts @etablissement.longitude
            puts @etablissement.latitude
            puts @etablissement.responsable_id
            puts @etablissement.province_id
            puts @etablissement.image_etablissement == true
            puts @etablissement.dossier_a_fournir == true
          puts "===================="
          @etablissement.province = @p
          if @etablissement.save
            session[:etab_id] =  @etablissement.id
            # créer association 
            @a = AssociateUserEtab.new()
            @a.etablissement = @etablissement
            @a.user = current_user
            @a.save

            flash[:success] = "Félicitation! Votre établissement est bien créé!"

            redirect_to etablissement_path(@etablissement.id)
          else
            flash[:error] = "Erreur de création!"
            redirect_to new_etablissement_path
          end
        else
          #rediriger vers son établissement
          flash[:error] = "Vous avez déjà un établissement!"
          redirect_to etablissement_path(session[:etab_id])
        end
      else
          #la personne n'est pas responsable
          redirect etablissements_path
        end
      else
        #login obligatoire
        flash[:error] = "Sign in please!"
        redirect_to user_session_path
      end
    
  end

  def update

  end

  def delete
  end

  def destroy
  end

  def likes
    if user_signed_in?

        if @etablissement.liked_by?(current_user)
          current_user.unlike!(@etablissement)
          @etablissement.likers_count -= 1
          @etablissement.save
          redirect_to @etablissement
        else
          current_user.like!(@etablissement)
          current_user.likees_count += 1
          @etablissement.likers_count += 1
          current_user.save
          @etablissement.save
          redirect_to @etablissement
        end
    else
      redirect_to new_user_session_path
    end
  end

  private

  def etablissement_params
    params.require(:etablissement).permit(:nom, :mail, :telephone, :adress, :description, :category, :longitude, :latitude, :dossier_a_fournir, :image_etablissement)
  end

  # Récupère au préalable l'id pour les actions show, update, destroy, likes
  # Gère aussi les erreurs au cas où un utilisateur rendre une id non existant
  def get_id
    begin
      @etablissement = Etablissement.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      puts "We couldn't find that record"
      redirect_to root_path
    end
  end

end
