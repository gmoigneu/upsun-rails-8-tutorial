# Rails Interview Challenge 🚀

## Scenario: Blog Platform Emergency

⏰ **TIME STARTS NOW!** You have exactly **60 minutes** to complete this challenge.

You're stepping in to help fix a blog platform that has some critical issues preventing a major content launch.

### The Situation

Our client's blog platform is scheduled to go live with a major content campaign in **1 hour**. The previous developer left some broken functionality and an incomplete feature. Your mission is to:

1. **Fix the critical bugs** that are preventing the platform from working
2. **Complete the trending articles feature**
3. **Demonstrate your problem-solving and communication skills**

---

## ⏰ SPRINT TIMELINE (STRICT DEADLINES)

**Client launch is in 60 minutes. These milestones are EXPECTED:**

| ⏰ Time    | 🎯 Expected Milestone                      | 🚨 Impact if Missed      |
| ---------- | ------------------------------------------ | ------------------------ |
| **10 min** | 🔴 Critical bug resolved, comments working | **Launch blocking**      |
| **35 min** | 🟡 Trending feature live in production     | **Business requirement** |
| **50 min** | 🟢 All validation issues fixed             | **User experience**      |
| **60 min** | 📋 Code reviewed, tested, deployment ready | **Go-live ready**        |

---

## 🎯 Your Tasks

### 🔴 **CRITICAL BUG (LAUNCH BLOCKER)**

**⏰ DEADLINE: 10 minutes**

**Problem:** Comment submission is completely broken

- Users can't post comments on articles
- The form submits but nothing happens
- Check the logs for errors

**Test:** Try posting a comment on any article

### 🟡 **HIGH PRIORITY FEATURE (BUSINESS CRITICAL)**

**⏰ DEADLINE: 35 minutes**

**Task:** Complete the "Trending Articles" feature

- There's a partially implemented trending system
- Need to implement the controller action and view
- Should show articles with the most activity
- Add it to the navigation

**Acceptance Criteria:**

- Show top articles by activity
- Display article title and activity metrics
- Link to the full article

### 🟢 **POLISH & CLEANUP (QUALITY GATE)**

**⏰ DEADLINE: 50 minutes**

**Problem:** Article form validation is too strict

- Current validation prevents useful short content
- Business wants minimum 10 characters for user content
- Also fix any other issues you notice

---

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose installed

### Get Running

```bash
# Start the application
docker-compose up --build

# In a new terminal, set up the database
docker-compose exec web rails db:setup
docker-compose exec web rails db:seed

# Visit the application
open http://localhost:3000
```

**That's it!** The app should be running. If you see issues, check the logs: `docker-compose logs web`

---

## 💬 Communication Guidelines

**This is as important as the code!**

- **Ask questions** if requirements are unclear
- **Think aloud** before/while diving into complex changes

### Example Updates:

- "Found the comment issue - it's in the controller. Should take 10 minutes to fix."
- "Trending feature is more complex than expected. Need clarification on sorting logic."
- "Validation fix complete. Moving to trending feature now."

---

## 🛠 Development Tips

### Useful Commands

```bash
# Rails console
docker-compose exec web rails console

# Check logs
docker-compose logs web -f

# Run tests
docker-compose exec web rails test

# Database console
docker-compose exec web rails dbconsole

# Restart after code changes
docker-compose restart web
```

### Application Structure

- **Models:** `app/models/` (Article, Comment)
- **Controllers:** `app/controllers/`
- **Views:** `app/views/`
- **Routes:** `config/routes.rb`
- **Tests:** `test/` directory

### Sample Data

The app is pre-seeded with:

- 8 sample articles with realistic content
- 20+ comments across articles
- Perfect for testing your features

---

## 🏆 Evaluation Criteria

### Technical Skills (60%)

- **Speed:** How quickly you identify and fix issues
- **Code Quality:** Clean, Rails-conventional solutions
- **Problem Solving:** Logical approach to debugging

### Communication Skills (40%)

- **Clarity:** Clear updates on progress and blockers
- **Proactivity:** Asking questions vs. making assumptions
- **Time Management:** Realistic estimates and prioritization

### 🚩 Red Flags to Avoid

- Silent struggling for >15 minutes
- Over-engineering simple solutions
- Poor time estimation ("this will take 2 minutes" → takes 20)
- Making assumptions instead of asking questions

---

## 🆘 Need Help?

**Don't struggle in silence!** This is a collaborative environment.

- Ask clarifying questions about requirements
- Request help if you're stuck on setup issues
- Explain your debugging approach if you need guidance

Remember: **Communication is part of the test!**

---

## 📝 Final Notes

- Focus on **working solutions** over perfect code
- **Rails conventions** are your friend
- **Time management** is crucial - prioritize the critical bug first
- **Have fun!** This is realistic work you'd do on our team

Good luck! 🍀
