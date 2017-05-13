class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    
    def index
        @articles = Article.all #grab all the articles from the db
    end
    
    def new
        @article = Article.new
    end
    
    def update #When editing and updating object
        set_article #can be shown in the rake routes command
        if @article.update(article_params)  #Check the validations and update whit the params 
            flash[:notice] = "Article was successfully edited" 
            redirect_to article_path(@article)
        else
            render 'edit' #render the edit template again when 
        end
    end
    
    def create
        #render plain: params[:article].inspect
        @article = Article.new(article_params)
        if @article.save  #Check the validations
            flash[:notice] = "Article was successfully created" 
            redirect_to article_path(@article)
        else
            render 'new' #render the new template again when 
        end
    end
    
    def show
        set_article
    end
    
    def destroy
        set_article
        @article.destroy
        flash[:notice] = "Article was successfully deleted"
        redirect_to articles_path
    end
    
    def edit #Fire update when submit
        set_article
    end
    
    private
        def set_article
            @article = Article.find(params[:id]) #get ID from the params of the URL
        end
        
        def article_params
           params.require(:article).permit(:title, :description)
        end
    
end
