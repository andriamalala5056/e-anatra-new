class EtablissementsController < ApplicationController
  before_action :get_id, only: [:show, :update, :destroy, :likes]

  def index
    @q = Etablissement.ransack(params[:q])
    @etablissements = @q.result.page(params[:page]).per(10)
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

  def edit
    redirect_to etablissements_path
=begin
    if user_signed_in?
      if session[:responsable] 
        if session[:etab_id]
          @@etablissement = Etablissement.find(session[:etab_id])
        else
          redirect_to etablissements_path
        end
      else
        redirect_to etablissements_path
      end
    else
      redirect_to user_session_path
    end
=end
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


=begin
  

                                 <!--a href="<%= etablissement_path(@etablissements.last.id) %>">
                          <div class="col-lg-6">
                            <div class="item">
                              <div class="item-image">
                                  <%= image_tag @etablissements.last.image_etablissement.url(#:thumb), class: "img-fluid" %>
                                  <% #if @etablissements.last.category? %>
                                  <div class="item-badges">
                                    <div class="item-badge-left"><%= @etablissements.last.category %></div>
                                  </div>
                                  <% #end %>
                                <a href="<%= etablissement_path(@etablissements.last.id) %>"></a>
                              </div>
                            <div class="item-info">
                              <h3 class="item-title"><%= @etablissements.last.nom %></h3>
                              <div class="item-location"><i class="fa fa-map-marker"></i>&nbsp;
<%= @etablissements.last.adress %></div>
                                 <a href="<%= likes_path(@etablissements.last)%>">
                              <div class="item-details-i"><i class="fa fa-thumbs-up"></i>&nbsp;
<%= @etablissements.last.likers_count %> </div>
                                 </a>
                            </div>
                            </div>
                          </div>
                        </a -->
=end