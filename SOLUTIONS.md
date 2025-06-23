# Interview Challenge Solutions 🔑

This file contains the solutions to the Rails interview challenge bugs. **Keep this private** - don't share with candidates!

---

## 🔴 Critical Bug: Comment Submission Broken

### **Problem Location:** 
`app/controllers/comments_controller.rb`

### **The Bug:**
The comments controller has a logic error in the `create` action. Even when validation fails, it redirects to the article page without showing errors, making it appear that comments are being silently discarded.

### **Solution:**
```ruby
def create
  @article = Article.find(params[:article_id])
  @comment = @article.comments.build(comment_params)
  
  if @comment.save
    redirect_to article_path(@article), notice: 'Comment was successfully created.'
  else
    # BUG WAS HERE: Need to render the article show page with errors
    # Old code: redirect_to article_path(@article)
    render 'articles/show', status: :unprocessable_entity
  end
end
```

### **Alternative Solution:**
Some candidates might fix this by storing the comment in an instance variable and handling errors in the show view:

```ruby
def create
  @article = Article.find(params[:article_id])
  @comment = @article.comments.build(comment_params)
  
  if @comment.save
    redirect_to article_path(@article), notice: 'Comment was successfully created.'
  else
    flash.now[:alert] = 'Please fix the errors below.'
    render 'articles/show', status: :unprocessable_entity
  end
end
```

### **Time Estimate:** 15-20 minutes for experienced Rails developer

---

## 🟡 High Priority: Complete Trending Articles Feature

### **Problem Location:** 
`app/controllers/articles_controller.rb` and missing view

### **The Bug:**
The `trending` action is incomplete - it just redirects with a "coming soon" message.

### **Solution:**

#### 1. Fix the Controller Action:
```ruby
def trending
  @trending_articles = Article.joins(:comments)
                             .group('articles.id')
                             .order('COUNT(comments.id) DESC')
                             .limit(5)
                             .includes(:comments)
end
```

#### 2. Create the View `app/views/articles/trending.html.erb`:
```erb
<div class="max-w-4xl mx-auto px-4 py-8">
  <h1 class="text-3xl font-bold text-gray-900 mb-8">🔥 Trending Articles</h1>
  
  <div class="space-y-6">
    <% @trending_articles.each_with_index do |article, index| %>
      <div class="bg-white shadow rounded-lg p-6 trending-article">
        <div class="flex justify-between items-start">
          <div class="flex-1">
            <h2 class="text-xl font-semibold text-gray-900 mb-2">
              <%= link_to article.title, article_path(article), class: "hover:text-indigo-600" %>
            </h2>
            <p class="text-gray-600 mb-3"><%= truncate(article.body, length: 150) %></p>
          </div>
          <div class="ml-4 text-center">
            <div class="bg-indigo-100 text-indigo-800 rounded-full px-3 py-1 text-sm font-medium">
              #<%= index + 1 %>
            </div>
            <div class="text-sm text-gray-500 mt-1">
              <%= pluralize(article.comments.size, 'comment') %>
            </div>
          </div>
        </div>
      </div>
    <% end %>
  </div>
  
  <% if @trending_articles.empty? %>
    <div class="text-center py-8">
      <p class="text-gray-500">No trending articles yet. Be the first to comment!</p>
      <%= link_to "View All Articles", root_path, class: "text-indigo-600 hover:text-indigo-500" %>
    </div>
  <% end %>
</div>
```

### **Advanced Solution (Bonus Points):**
Some candidates might suggest adding a method to the Article model:

```ruby
# In app/models/article.rb
scope :trending, ->(limit = 5) { 
  joins(:comments)
    .group('articles.id')
    .order('COUNT(comments.id) DESC')
    .limit(limit)
    .includes(:comments)
}
```

Then in controller:
```ruby
def trending
  @trending_articles = Article.trending(5)
end
```

### **Time Estimate:** 20-30 minutes

---

## 🟢 Medium Priority: Article Validation Too Strict

### **Problem Location:** 
`app/models/article.rb`

### **The Bug:**
The body validation requires minimum 100 characters, but business requirement is 10 characters.

### **Solution:**
```ruby
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 } # Changed from 100 to 10
end
```

### **Time Estimate:** 2-5 minutes

---

## 🧪 Testing the Solutions

### **Manual Testing:**
1. **Comment Bug:** Try posting a comment with empty fields - should show validation errors
2. **Trending Feature:** Visit `/trending` - should show articles ordered by comment count  
3. **Validation Fix:** Try creating an article with 20-character body - should work

### **Automated Testing:**
```bash
docker-compose exec web rails test
```

All tests should pass with the fixes implemented.

---

## 🎯 Evaluation Notes

### **Red Flags:**
- **Silent struggling >15 minutes** without asking questions
- **Over-engineering** (e.g., adding caching, complex algorithms for simple sorting)
- **Poor communication** (no progress updates)
- **Wrong priorities** (spending 40 minutes on validation fix instead of critical bug)

### **Green Flags:**
- **Systematic debugging** (checking logs, understanding error flow)
- **Clear communication** ("Found the issue, it's in the controller logic")
- **Asking clarifying questions** ("Should trending show all articles or just those with comments?")
- **Rails conventions** (using proper status codes, following REST patterns)
- **Time management** (fixing critical bug first)

### **Bonus Points:**
- Adding model scopes for reusability
- Proper error handling with status codes
- Adding flash messages for better UX
- Suggesting performance improvements (like counter caches)
- Writing tests for their fixes

---

## 💬 Discussion Points After Challenge

1. How would you handle this differently with more time?
2. What would you do to prevent these bugs in the future?
3. How would you scale the trending feature for high traffic?
4. What testing strategy would you recommend?

---

**Total Expected Time: 45-55 minutes for all three issues**
