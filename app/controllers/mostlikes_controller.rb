class MostlikesController < ApplicationController
  
    def show
      @articles = Article.top_like
    end
  end
  