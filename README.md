# LINE Bot Expense Slip Recorder

A ready-to-deploy sample LINE bot that records expenses from receipt images.

Tech stack:
- Node.js + Express
- PostgreSQL (SQL schema and migrations)
- LINE Messaging API (Webhook, reply/push)
- OpenAI Vision (OCR + information extraction from receipts)

Features:
- Users send a receipt image to the LINE bot; the bot extracts key fields via OpenAI Vision and stores a normalized expense record in Postgres.
- Fields parsed: amount, currency, merchant, purchase datetime, category (heuristic), and optional notes.
- Text messages supported: help, list recent, total this month, health check.
- Admin-only endpoint to re-run OCR for a message image by ID.
- Minimal, production-friendly structure with logging, env validation, and graceful shutdown.

Quick start
1) Prerequisites
- Node.js 18+
- PostgreSQL 13+
- LINE account and Messaging API channel
- OpenAI API key with access to a Vision-capable model (e.g., gpt-4o-mini)

2) Clone and install
```
git clone https://github.com/benyasit007/line-bot-expense-slip-recorder.git
cd line-bot-expense-slip-recorder
npm install
```

3) Configure environment
Copy .env.example to .env and fill values.
```
cp .env.example .env
```
Required variables:
- PORT
- DATABASE_URL
- LINE_CHANNEL_SECRET
- LINE_CHANNEL_ACCESS_TOKEN
- OPENAI_API_KEY
- OPENAI_MODEL (default gpt-4o-mini)
- APP_BASE_URL (public https URL for webhook)

4) Database
Create database and apply schema:
```
psql "$DATABASE_URL" -f db/schema.sql
```

5) Run locally
```
npm run dev
```
Expose webhook with a tunnel (e.g., ngrok) and set webhook URL in LINE Console to:
```
https://YOUR_PUBLIC_HOST/webhook
```
Verify health:
```
curl http://localhost:3000/healthz
```

6) Deploy
You can deploy to Render, Fly.io, Heroku, Railway, etc. Ensure DATABASE_URL and other envs are set. Remember to allow inbound HTTPS and set the webhook URL to https://YOUR_APP/webhook.

LINE setup
- Create a Messaging API channel
- Set Webhook URL to your /webhook
- Issue a Channel access token
- Copy Channel secret and access token into .env

OpenAI Vision
- Ensure your model supports image inputs (e.g., gpt-4o-mini)
- Billing must be enabled for OCR to work reliably

API endpoints
- POST /webhook: LINE webhook handler
- GET /healthz: health check

Directory structure
```
.
├─ README.md
├─ package.json
├─ .gitignore
├─ .env.example
├─ src/
│  └─ index.js
└─ db/
   └─ schema.sql
```

License
MIT
