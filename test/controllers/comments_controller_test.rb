require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = articles(:one)
  end

  test "create comment" do
    assert_difference("Comment.count") do
      post article_comments_path(@article), params: {
        comment: {
          commenter: "Test User",
          body: "This is a great article!"
        }
      }
    end

    assert_redirected_to article_path(@article)
    assert_equal "Comment posted successfully!", flash[:notice]
  end

  test "create comment redirects" do
    post article_comments_path(@article), params: {
      comment: {
        commenter: "Another User",
        body: "Really enjoyed reading this"
      }
    }

    assert_redirected_to article_path(@article)
  end

  test "create comment association" do
    initial_count = @article.comments.count

    post article_comments_path(@article), params: {
      comment: {
        commenter: "Article Reader",
        body: "Commenting on this specific article"
      }
    }

    @article.reload
    assert_equal initial_count + 1, @article.comments.count
  end
end
