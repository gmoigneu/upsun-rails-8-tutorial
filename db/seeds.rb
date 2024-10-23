# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Comment.destroy_all
Article.destroy_all

Article.create(
    title: "🚂 ☁️ All Aboard the Cloud Rails Express: Why Your Next Project Should Ride These Tracks", 
    body: "Rails has been chugging along for years, but like a fine wine (or that forgotten leftover code in your Git stash), it just keeps getting better with age. When paired with modern cloud platforms, Rails transforms from a reliable locomotive into a high-speed bullet train of productivity.
The cloud-Rails combo is like peanut butter and jelly – individually they're good, but together they create something magical. With automatic scaling, your Rails app can handle traffic spikes smoother than your coffee-fueled debugging sessions at 3 AM.
Deployment in the cloud is so seamless, you'll have more time to argue about tabs vs. spaces or debate whether dark mode should be the only mode. Gone are the days of SSH-ing into servers and praying to the deployment gods – now it's just git push and let the cloud do its thing.
Remember when scaling meant buying new servers and performing ritual sacrifices to the RAM gods? With Rails in the cloud, scaling is more like adjusting the temperature on your smart thermostat – just slide it up when you need more power, slide it down when you don't.", 
    comments: [
        Comment.create(
            commenter: "Ruby Rockstar", 
            body: "The PB&J analogy really hits home! I've been using Rails with AWS for the past 2 years and it's exactly like that - two great tastes that taste great together!"
        ),
        Comment.create(
            commenter: "Cloud Ninja", 
            body: "Love the deployment gods reference 😂 Remember the days of manual Capistrano deploys? So glad those are behind us!"
        ),
        Comment.create(
            commenter: "DevOps Dave", 
            body: "The scaling comparison to a smart thermostat is spot on. Our team switched to Rails on Heroku last year and haven't looked back since."
        ),
        Comment.create(
            commenter: "Sarah Smith", 
            body: "This article convinced me to finally make the switch from my self-hosted setup. Currently migrating everything to the cloud!"
        ),
        Comment.create(
            commenter: "Rails Veteran", 
            body: "Another great benefit is the cost savings on DevOps. No more late-night server maintenance calls!"
        )
    ]
)

Article.create(
    title: "🎮 🌩️ Level Up Your Game: Rails Cloud Deployment is the Ultimate Power-Up", 
    body: "Remember playing Super Mario and grabbing that mushroom that made you bigger and stronger? That's exactly what the cloud does for your Rails application, minus the 8-bit sound effects (though we can add those if you really want).
The cloud platform acts like your game's save state – you can always roll back to a previous deployment if something goes wrong. It's like having infinite lives in a game where the boss is production bugs, and you're armed with the ultimate weapon: rapid rollbacks.
Your database migrations flow smoother than a speedrunner's perfect playthrough. The cloud handles all the heavy lifting, letting you focus on what really matters: writing beautiful Ruby code and pretending you understand how ActiveRecord really works under the hood.
With features like auto-scaling and load balancing, your app becomes the final boss that can't be taken down. While your competitors are still trying to configure their servers manually (like playing Doom with a broken keyboard), you're already in the end game.", 
    comments: [
        Comment.create(
            commenter: "Gamer Dev", 
            body: "As both a gamer and a Rails developer, I absolutely love these analogies! Auto-scaling really is the ultimate power-up!"
        ),
        Comment.create(
            commenter: "Migration Master", 
            body: "The speedrunner comparison for database migrations made me laugh out loud. Too real! 😅"
        ),
        Comment.create(
            commenter: "Cloud Champion", 
            body: "Would love to see a follow-up article about boss battles (handling peak traffic) in the cloud!"
        ),
        Comment.create(
            commenter: "Debug Warrior", 
            body: "The infinite lives through rollbacks is such a perfect analogy. Saved our team multiple times!"
        ),
        Comment.create(
            commenter: "Full Stack Fighter", 
            body: "Now I can't stop thinking about adding 8-bit sound effects to our deployment pipeline... 🎮"
        )
        ]
)

Article.create(
    title: "The Perfect Marriage: Why Rails and Cloud Platforms are a Match Made in Developer Heaven", 
    body: "If Rails was on a dating app, its profile would read: \"Mature framework seeking cloud platform for long-term deployment relationship. Must love convention over configuration and hate XML.\" And guess what? The cloud swiped right!
This power couple works together better than pair programming with your rubber duck. The cloud handles all the infrastructure drama while Rails focuses on making your code look good. It's like having a personal assistant for your application – except this one doesn't need coffee breaks.
Security updates and patches? The cloud platform has your back faster than you can say \"bundle update\". It's like having a bodyguard for your application that also knows how to make a mean cup of coffee and crack decent programming jokes.
The monitoring tools available in cloud platforms integrate with Rails like they were meant to be together from the start. It's as if DHH himself descended from the Ruby heavens and blessed this union with endless performance graphs and logging capabilities.", 
    comments: [
        Comment.create(
            commenter: "Ruby Romance", 
            body: "The dating app profile for Rails is hilarious! Though you forgot to mention its love for beautiful code syntax 💝"
        ),
        Comment.create(
            commenter: "Cloud Cupid", 
            body: "As someone who plays matchmaker between apps and cloud platforms professionally, this article is spot on!"
        ),
        Comment.create(
            commenter: "DHH Fan", 
            body: "Lost it at 'DHH himself descended from the Ruby heavens' 😂 Great article that really captures the Rails philosophy!"
        ),
        Comment.create(
            commenter: "Infrastructure Idol", 
            body: "The rubber duck pair programming reference is perfect! My duck approves this article."
        ),
        Comment.create(
            commenter: "Deployment Diva", 
            body: "Been married to Rails for 5 years now, and the cloud made our relationship even better. Great analogies throughout!"
        )
        ]
)