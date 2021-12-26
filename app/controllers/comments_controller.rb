class CommentsController < ApplicationController

    def new
        article= Article.find(params[:article_id])
        @comment = article.comments.build
    end

    def create
        article = Article.find(params[:article_id])
        @comment = article.comments.build(comments_params)
        if @comment.save
            redirect_to article_path(article), notice: 'Added a comment'
        else
            flash.now[:error] = 'Unable to add a comment'
            render :new
        end
    end

    private
    def comments_params
        params.require(:comment).permit(:content)
    end
end