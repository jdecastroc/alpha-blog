class ArticlesController < ApplicationController
    
    def index
        @articles = Article.all #grab all the articles from the db
    end
    
    def new
        @article = Article.new
    end
    
    def update #When editing and updating object
        @article = Article.find(params[:id]) #can be shown in the rake routes command
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
        @article = Article.find(params[:id]) #get ID from the params of the URL
    end
    
    def edit #Fire update when submit
        @article = Article.find(params[:id]) #get ID from the params of the URL
    end
    
    private
        def article_params
           params.require(:article).permit(:title, :description)
        end
    
end
