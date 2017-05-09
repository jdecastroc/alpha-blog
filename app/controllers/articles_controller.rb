class ArticlesController < ApplicationController
    
    def new
        @article = Article.new
    end
    
    def create
        #render plain: params[:article].inspect
        @article = Article.new(article_params)
        if @article.save  #Check the validations
            #do something
            flash[:notice] = "Article was successfully created" 
            redirect_to article_path(@article)
        else
            render 'new' #render the new template again when 
        end
    end
    
    def show
        @article = Article.find(params[:id]) #get ID from the params of the URL
    end
    
    private
        def article_params
           params.require(:article).permit(:title, :description)
        end
    
end
