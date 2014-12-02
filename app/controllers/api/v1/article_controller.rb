class Api::V1::ArticleController < ApplicationController
 # return articles
 def index
   render json: Article.list(request)
 end
end
