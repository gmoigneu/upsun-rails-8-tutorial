# Rails Interview Challenge 🎯

A **1-hour Rails 8 coding challenge** designed to test real-world debugging and development skills.

## Quick Start

```bash
# Clone and enter directory
cd rails_interview

# Start the challenge  
docker-compose up --build

# In another terminal, setup database
docker-compose exec web rails db:setup
docker-compose exec web rails db:seed

# Visit the app
open http://localhost:3000
```

## For Candidates

📖 **Read the full challenge instructions:** [CHALLENGE.md](CHALLENGE.md)

## For Interviewers

🔑 **Solutions and evaluation guide:** [SOLUTIONS.md](SOLUTIONS.md)

## What This Tests

- **Speed:** How quickly can they identify and fix Rails bugs?
- **Communication:** Do they ask questions and provide updates?
- **Rails Knowledge:** Understanding of MVC, validations, and Rails conventions
- **Problem Solving:** Systematic debugging approach
- **Time Management:** Prioritizing critical issues first

## Challenge Overview

1. **🔴 Critical Bug** (20 min): Comment submission is broken
2. **🟡 Feature Implementation** (25 min): Complete trending articles feature  
3. **🟢 Validation Fix** (15 min): Adjust overly strict article validation

**Total Time:** 1 hour

---

Built with Rails 8, PostgreSQL, and Docker for consistent testing environment.
