class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    if user_signed_in?
      if session[:responsable]
        @article = Article.new
      else
        redirect_to articles_path
      end
    else
      redirect_to user_session_path
    end
  end

  def create
    
        @article = Article.new(titre: params[:article][:titre], message: params[:article][:message], photo: params[:article][:photo])
        @article.etablissement = Etablissement.find(session[:etab_id])
        if @article.save
          flash[:success] = "Création article avec succès!"
          redirect_to articles_path
        else
          flash[:error] = "Champ invalide!"
          redirect_to new_article_path
        end

  end

  def show
    if user_signed_in?
      if session[:responsable]
        @article = Article.where(etablissement_id: session[:etab_id])
      else
        redirect_to articles_path
      end
    else
      redirect_to user_session_path
    end
  end

  def edit
    if user_signed_in?
      if session[:responsable]
        @article = Article.find(params[:id])
      else
        redirect_to articles_path
      end
    else
      redirect_to user_session_path
    end
  end

  def update
    @article = Article.find(params[:id])
    article_params = params.require(:article).permit(:titre, :message, :photo)
    @article.update(article_params)
    redirect_to article_path(session[:etab_id])
  end

  def destroy
    if user_signed_in?
      if session[:responsable]
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to article_path(session[:etab_id])
      else
        redirect_to articles_path
      end
    else
      redirect_to user_session_path
    end
  end
end
