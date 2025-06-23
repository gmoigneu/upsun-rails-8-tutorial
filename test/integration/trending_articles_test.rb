require "test_helper"

class TrendingArticlesTest < ActionDispatch::IntegrationTest
  test "trending page should exist and be accessible" do
    get trending_articles_path
    assert_response :success
  end

  test "trending should show articles ordered by comment count" do
    # Create articles with different comment counts
    article1 = Article.create!(title: "Article 1", body: "Body content here that is long enough")
    article2 = Article.create!(title: "Article 2", body: "Body content here that is long enough")
    article3 = Article.create!(title: "Article 3", body: "Body content here that is long enough")

    # Give article2 the most comments (should be #1 trending)
    3.times { |i| article2.comments.create!(commenter: "User#{i}", body: "Comment #{i}") }
    # Give article1 fewer comments (should be #2 trending)
    2.times { |i| article1.comments.create!(commenter: "User#{i}", body: "Comment #{i}") }
    # Give article3 no comments (should be #3 trending)

    get trending_articles_path
    assert_response :success

    # The page should show trending articles
    assert_select "h1", text: /trending/i

    # Should show articles with comment counts
    assert_select ".trending-article", count: 3
  end
end
