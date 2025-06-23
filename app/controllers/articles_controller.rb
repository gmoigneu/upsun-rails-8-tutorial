class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new
    end
  end

  def trending
    redirect_to root_path, alert: "Trending feature coming soon!"
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
