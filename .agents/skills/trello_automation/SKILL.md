---
name: trello-automation
description: Remote mobile feature development framework connecting Trello board management with Google Antigravity AGY AI Agents and GitHub Pull Requests.
---

# Trello Remote AI Agent Automation Framework

This skill connects **Trello** with **Google Antigravity / AGY AI Agents** and **GitHub** for mobile-first, remote feature development, strictly executing the [6-step feature development pipeline](https://github.com/FrancoRodriguez/feature-development-pipeline-skill).

---

## 🛠️ Column Architecture & 6-Step Pipeline

The agent automatically executes the 6-step pipeline ([feature-development-pipeline-skill](https://github.com/FrancoRodriguez/feature-development-pipeline-skill)) across your Trello columns:

1. **`Progress`**: User moves card here from mobile to trigger AI development.
2. **`AI in progress`**: Agent moves card here while actively executing the 6-step pipeline:
   - **Step 1**: Feature Spec & Q&A Gate Review.
   - **Step 2**: Feature Implementation (UI, Backend, DB).
   - **Step 3**: Automated Unit Testing (`rspec` / `rails test`).
   - **Step 4**: Security & Code Quality Audit (`rubocop`, `brakeman`).
   - **Step 5**: Git Push & GitHub PR Creation.
   - **Step 6**: Codebase Documentation Update.
3. **`AI open questions`**: Agent moves card here if clarifying questions are required. User replies on mobile and moves card back to `Progress`.
4. **`Testing`**: Agent moves card here when all tests pass green and GitHub PR is opened.
5. **`Done` / `In Prod`**: User merges PR on GitHub and moves card to Done.

---

## 🔔 Mobile Push Notifications Guide (ntfy.sh)

The agent natively supports instant mobile push notifications via **[ntfy.sh](https://ntfy.sh)**:

- **App Setup**: Install the free **ntfy** app on iOS / Android and subscribe to your custom `NTFY_TOPIC`.
- **Environment Variable**: Set `NTFY_TOPIC=your_topic_name` in `.env`.
- **Alerts**: Sends push notifications when clarifying questions are posted or when a PR is ready for review.

---

## 🌐 Strict English Output Policy

All git commit messages, branch names, pull request descriptions, documentation, code comments, and unit test descriptions **MUST ALWAYS** be generated in English — even if the user's Trello card title, description, or comment is in Spanish or another language.

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
NTFY_TOPIC=your_ntfy_topic
```
