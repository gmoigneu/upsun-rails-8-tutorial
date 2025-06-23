class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)

    # BUG: Missing save and error handling
    if @comment.save
      redirect_to article_path(@article), notice: "Comment was successfully created."
    else
      # BUG: This redirects even on validation failure
      redirect_to article_path(@article)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
