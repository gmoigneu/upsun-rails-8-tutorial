#!/bin/bash

# Rails Interview Challenge Setup Script
echo "🚀 Setting up Rails Interview Challenge..."

# Build and start containers
echo "📦 Building Docker containers..."
docker-compose up --build -d

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
sleep 10

# Setup database
echo "🗄️ Setting up database..."
docker-compose exec web rails db:create
docker-compose exec web rails db:migrate
docker-compose exec web rails db:seed

echo ""
echo "✅ Setup complete!"
echo ""
echo "🌐 Visit: http://localhost:3000"
echo "📖 Challenge instructions: see CHALLENGE.md"
echo "🔧 View logs: docker-compose logs web -f"
echo ""
echo "Happy coding! 🎯"
