class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @articles = Article.all
    end

    def show
        @comments = @article.comments
    end

    def new
        # @article = Article.new
        @article = current_user.articles.build
    end

    def create
        # @article = Article.new(article_params)
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to article_path(@article), notice: 'Saved successfully'
        else
            flash.now[:error] = 'Failed to save'
            render :new
        end
    end

    def edit
        @article = current_user.articles.find(params[:id])
    end

    def update
        @article = current_user.articles.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path(@article), notice: 'Updated successfully'
        else
            flash.now[:error] = 'Unable to update'
            render :edit
        end
    end

    def destroy
        article = current_user.articles.find(params[:id])
        article.destroy!
        redirect_to root_path, notice: 'Deleted successfully'
    end

    private
    def article_params
        params.require(:article).permit(:title, :content, :eyecatch)
    end

    def set_article
        @article = Article.find(params[:id])
    end
end
