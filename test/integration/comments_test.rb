require "test_helper"

class CommentsTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should create comment with valid data" do
    assert_difference("Comment.count") do
      post article_comments_path(@article), params: {
        comment: {
          commenter: "Test User",
          body: "This is a test comment"
        }
      }
    end

    assert_redirected_to article_path(@article)
    follow_redirect!
    assert_response :success
  end

  test "should not create comment with invalid data" do
    assert_no_difference("Comment.count") do
      post article_comments_path(@article), params: {
        comment: {
          commenter: "",
          body: ""
        }
      }
    end

    # Should handle validation errors gracefully
    assert_response :success
  end
end
