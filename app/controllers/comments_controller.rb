class CommentsController < ApplicationController
  before_action :find_article, only: [:create]
  
  def create
    @comment = @article.comments.build(params[:comment])
    @comment.save!
    redirect_to article_path(@article), notice: "Comment posted successfully!"
  rescue => e
    Rails.logger.error "Comment creation failed: #{e.message}"
    redirect_to article_path(@article)
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
