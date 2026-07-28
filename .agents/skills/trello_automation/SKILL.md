---
name: trello-automation
description: Remote mobile feature development framework connecting Trello board management with Google Antigravity AGY AI Agents and GitHub Pull Requests.
---

# Trello Remote AI Agent Automation Framework

This skill connects **Trello** with **Google Antigravity / AGY AI Agents** and **GitHub** for mobile-first, remote feature development.

---

## 🛠️ Column Architecture

1. **`Progress`**: User moves card here from mobile to trigger AI development.
2. **`AI in progress`**: Agent moves card here while actively executing the 6-step pipeline.
3. **`AI open questions`**: Agent moves card here if clarifying questions are required. User replies on mobile and moves card back to `Progress`.
4. **`Testing`**: Agent moves card here when all tests pass green and GitHub PR is opened.
5. **`Done` / `In Prod`**: User merges PR on GitHub and moves card to Done.

---

## 🚀 Execution Commands

```bash
# Verify connection & status
make trello-check

# Run continuous watcher (poll every 30s)
make trello
```

---

## 🔑 Environment Variables (.env)

```env
TRELLO_API_KEY=your_key
TRELLO_TOKEN=your_token
TRELLO_BOARD_ID=your_board_id
TRELLO_SOURCE_LIST=Progress
TRELLO_WORKING_LIST=AI in progress
TRELLO_QUESTIONS_LIST=AI open questions
TRELLO_TARGET_LIST=Testing
```
