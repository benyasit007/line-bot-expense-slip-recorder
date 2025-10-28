-- PostgreSQL schema for line-bot-expense-slip-recorder
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  line_user_id TEXT UNIQUE NOT NULL,
  display_name TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS expenses (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  amount NUMERIC(12,2) NOT NULL,
  currency TEXT DEFAULT 'THB',
  merchant TEXT,
  purchased_at TIMESTAMPTZ,
  category TEXT,
  notes TEXT,
  image_url TEXT,
  ocr_json JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_expenses_user_id ON expenses(user_id);
CREATE INDEX IF NOT EXISTS idx_expenses_purchased_at ON expenses(purchased_at);
