# Interview Challenge Solutions 🔑

This file contains the solutions to the Rails interview challenge bugs. **Keep this private** - don't share with candidates!

---

## 🔴 Critical Bug: Comment Submission Broken

### **Problem Locations:** 
- `app/controllers/comments_controller.rb` (Multiple issues)
- `config/application.rb` (Hidden configuration issue)

### **The Complex Bug:**
This is a **multi-layered bug** designed to test advanced debugging skills:

#### **Issue 1: Disabled Strong Parameters (Most Critical)**
In `config/application.rb`, strong parameters are globally disabled:
```ruby
# This is the ROOT CAUSE - disables Rails security!
config.action_controller.permit_all_parameters = true
```

#### **Issue 2: Mass Assignment Vulnerability**
Controller uses `params[:comment]` directly instead of strong parameters:
```ruby
@comment = @article.comments.build(params[:comment])  # VULNERABLE!
```

#### **Issue 3: Poor Exception Handling**
Uses `save!` with broad exception rescue that hides validation errors:
```ruby
@comment.save!  # Raises exception on validation failure
rescue => e     # Catches ALL exceptions, even validation errors
```

#### **Issue 4: Unused Security Method**
A proper `comment_params` method exists but isn't being used (red herring).

### **Complete Solution:**

#### **Step 1: Fix Configuration (Critical)**
```ruby
# Remove or comment out in config/application.rb:
# config.action_controller.permit_all_parameters = true
```

#### **Step 2: Fix Controller**
```ruby
class CommentsController < ApplicationController
  before_action :find_article, only: [:create]
  
  def create
    @comment = @article.comments.build(comment_params)  # Use strong params
    
    if @comment.save  # Use save (not save!) for proper validation handling
      redirect_to article_path(@article), notice: "Comment was successfully created."
    else
      # Properly handle validation errors
      redirect_to article_path(@article), alert: "Comment could not be saved. Please check your input."
      # OR render 'articles/show', status: :unprocessable_entity for better UX
    end
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
```

### **Why This is Challenging:**
- ✅ **Tests pass with valid data** (misleading candidates)
- ✅ **Multiple interconnected issues** require systematic debugging  
- ✅ **Hidden configuration bug** tests deep Rails knowledge
- ✅ **Security implications** test understanding of Rails safety features
- ✅ **Exception vs Validation handling** tests proper error patterns

### **Time Estimate:** 15-20 minutes for senior Rails developer

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
<div class="container mx-auto px-4 py-8">
  <div class="mb-12">
    <h1 class="text-5xl font-bold text-ctp-text mb-4 bg-gradient-to-r from-ctp-mauve to-ctp-pink bg-clip-text text-transparent">🔥 Trending Articles</h1>
    <p class="text-ctp-subtext1 text-lg">The most discussed articles right now</p>
  </div>

  <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
    <% @trending_articles.each_with_index do |article, index| %>
      <article class="group bg-ctp-surface0 border border-ctp-surface1 rounded-xl p-6 hover:bg-ctp-surface1 hover:border-ctp-surface2 transition-all duration-300 transform hover:scale-[1.02] hover:shadow-2xl">
        <div class="space-y-4">
          <div class="flex items-center justify-between">
            <div class="bg-ctp-mauve text-ctp-base px-3 py-1 rounded-full text-sm font-bold">
              #<%= index + 1 %>
            </div>
            <div class="text-ctp-subtext0 text-sm">
              <%= pluralize(article.comments.size, 'comment') %>
            </div>
          </div>
          
          <h3 class="text-xl font-bold text-ctp-text group-hover:text-ctp-mauve transition-colors duration-200">
            <%= link_to article.title, article_path(article), class: "block" %>
          </h3>
          
          <% if article.body.present? %>
            <p class="text-ctp-subtext1 line-clamp-3 leading-relaxed">
              <%= truncate(strip_tags(article.body), length: 120) %>
            </p>
          <% end %>
          
          <div class="pt-4 border-t border-ctp-surface1 group-hover:border-ctp-surface2 transition-colors duration-200">
            <%= link_to article_path(article), class: "inline-flex items-center text-ctp-mauve hover:text-ctp-lavender font-medium transition-colors duration-200" do %>
              Read more
              <svg class="w-4 h-4 ml-1 transform group-hover:translate-x-1 transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
              </svg>
            <% end %>
          </div>
        </div>
      </article>
    <% end %>
  </div>

  <% if @trending_articles.empty? %>
    <div class="text-center py-16">
      <div class="mb-4">
        <svg class="w-16 h-16 mx-auto text-ctp-surface2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M7 12l3-3 3 3 4-4M8 21l4-4 4 4M3 4h18M4 4h16v12a1 1 0 01-1 1H5a1 1 0 01-1-1V4z"></path>
        </svg>
      </div>
      <h3 class="text-2xl font-bold text-ctp-text mb-2">No trending articles yet</h3>
      <p class="text-ctp-subtext1 mb-6">Be the first to start the conversation!</p>
      <%= link_to "View All Articles", root_path, class: "inline-flex items-center px-6 py-3 bg-ctp-mauve text-ctp-base font-medium rounded-lg hover:bg-ctp-lavender transition-colors duration-200" %>
    </div>
  <% end %>
</div>
```

#### 3. Add Navigation Link:
In `app/views/layouts/application.html.erb`, add the trending link to the left navigation:
```erb
<div class="flex items-center space-x-8">
  <%= link_to "Rails Blog", root_path, class: "text-xl font-bold text-ctp-text hover:text-ctp-mauve transition-colors duration-200" %>
  <%= link_to "All Articles", root_path, class: "text-ctp-subtext1 hover:text-ctp-text transition-colors duration-200" %>
  <%= link_to "Trending", trending_articles_path, class: "text-ctp-subtext1 hover:text-ctp-text transition-colors duration-200" %>
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
