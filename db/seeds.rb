# Create sample data for the interview challenge
puts "🌱 Seeding the database..."

# Clear existing data
Comment.destroy_all
Article.destroy_all

# Create articles with realistic content
articles_data = [
  {
    title: "Getting Started with Rails 8",
    body: "Rails 8 brings exciting new features including solid queue, solid cache, and improved deployment tools. In this comprehensive guide, we'll explore how to get started with Rails 8 and take advantage of its powerful new capabilities. From setup to deployment, we'll cover everything you need to know to build modern web applications."
  },
  {
    title: "Hotwire and Turbo: The Future of Rails Frontend",
    body: "Hotwire has revolutionized how we think about building interactive web applications in Rails. With Turbo Frames, Turbo Streams, and Stimulus, you can create rich, responsive user experiences without writing a lot of JavaScript. This article explores best practices and real-world examples of Hotwire in action."
  },
  {
    title: "Database Performance Tips for Rails Applications",
    body: "As your Rails application grows, database performance becomes crucial. Learn about indexing strategies, query optimization, and how to use tools like bullet gem to identify N+1 queries. We'll also cover advanced topics like database sharding and read replicas for high-traffic applications."
  },
  {
    title: "Building APIs with Rails 8",
    body: "Rails continues to be an excellent choice for API development. With Rails 8, we have improved tools for building robust, scalable APIs. This guide covers authentication, serialization, versioning, and best practices for API design. Perfect for both REST and GraphQL implementations."
  },
  {
    title: "Testing Strategies for Modern Rails Apps",
    body: "Testing is essential for maintaining code quality in Rails applications. We'll explore different testing approaches including unit tests, integration tests, and system tests. Learn about factories, mocking, and how to test complex user interactions with Capybara and Selenium."
  },
  {
    title: "Deployment and DevOps for Rails",
    body: "Deploying Rails applications has never been easier with tools like Kamal and traditional platforms like Heroku. This comprehensive guide covers different deployment strategies, monitoring, logging, and maintaining production Rails applications. Includes Docker best practices and CI/CD setup."
  },
  {
    title: "Rails Security Best Practices",
    body: "Security should be a top priority in any web application. Rails provides many built-in security features, but you need to know how to use them correctly. This article covers common vulnerabilities, how to prevent them, and tools like Brakeman for security auditing."
  },
  {
    title: "Optimizing Rails Performance",
    body: "Performance optimization is crucial for user experience and cost efficiency. Learn about caching strategies, background jobs, and how to profile your Rails application. We'll cover tools like New Relic, memory profiling, and techniques for handling high-traffic scenarios."
  }
]

# Create articles
created_articles = []
articles_data.each do |article_data|
  article = Article.create!(article_data)
  created_articles << article
  puts "✅ Created article: #{article.title}"
end

# Create comments for each article
comments_data = [
  "Great article! This really helped me understand the concepts better.",
  "Thanks for sharing these insights. Very practical examples.",
  "I've been looking for exactly this information. Perfect timing!",
  "Could you expand on the section about deployment? Really interesting stuff.",
  "This solved a problem I've been struggling with for weeks. Much appreciated!",
  "Excellent write-up. Looking forward to more content like this.",
  "Clear and concise explanation. Bookmarked for future reference.",
  "Any plans for a follow-up article on advanced topics?",
  "This approach worked perfectly in my project. Thanks!",
  "Well-structured tutorial. The examples are very helpful."
]

# Add 2-4 comments per article
created_articles.each do |article|
  comment_count = rand(2..4)
  comment_count.times do
    comment_body = comments_data.sample
    commenter_names = ["Alice", "Bob", "Charlie", "Diana", "Eve", "Frank", "Grace", "Henry"]
    
    Comment.create!(
      article: article,
      commenter: commenter_names.sample,
      body: comment_body
    )
  end
  puts "💬 Added #{comment_count} comments to '#{article.title}'"
end

puts ""
puts "🎉 Seeding completed!"
puts "📊 Created #{Article.count} articles and #{Comment.count} comments"
puts ""
puts "🚀 You can now visit http://localhost:3000 to see the application!"
