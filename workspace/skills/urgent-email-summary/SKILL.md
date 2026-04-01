---
name: urgent-email-summary
description: Scan recent/unread Gmail messages, classify (Urgent / Action Required / FYI), summarize top 5, and highlight deadlines. Output in a compact Telegram-friendly format.
---

# Goal
Generate an "Urgent Email Summary" digest.

# Fetch Gmail messages
If Gmail hook messages are not already provided as input, first execute:

bash scripts/fetch_recent_gmail.sh

Use the returned JSON messages as the dataset.

## Inputs
You may receive either:
- Gmail hook messages directly
- Or a request to run the summary, in which case fetch messages using the script above

## Classification rules
Classify each email into exactly one bucket:

### 🔴 Urgent
- Mentions a deadline within 48 hours
- Or contains urgency words such as: urgent, asap, today, by EOD, by end of day, immediately, final notice, overdue
- Or contains an imminent calendar time or due date

### 🟡 Action Required
- Requests a reply, approval, review, decision, payment, document, sign-off, scheduling, or contains a direct question
- Needs action, but is not urgent by timing

### 🟢 Informational
- Updates, newsletters, receipts, FYI, no response needed

## Deadline extraction
For each email, extract a deadline if present.
- Convert relative dates to absolute dates when possible
- If none exists, use "None"

## Importance scoring
Rank by:
1. Urgent before Action Required before Informational
2. Earlier deadlines first
3. Human senders before automated senders
4. Explicit asks/questions before newsletters

## Output rules
- Return only the final answer
- Do not add intro text
- Do not add explanation
- Do not say "Here are..."
- Do not omit summary, deadline, or next step
- If fewer than 5 emails exist, return only the available ones
- Follow the format below exactly

## Required output format

🔴 <count> Urgent Emails
🟡 <count> Action Required
🟢 <count> Informational

Top Important Emails

1) [<bucket emoji>] <Sender> — <Subject>
   • Summary: <1–2 lines>
   • Deadline: <absolute date/time or "None">
   • Next step: <one action>

2) [<bucket emoji>] <Sender> — <Subject>
   • Summary: <1–2 lines>
   • Deadline: <absolute date/time or "None">
   • Next step: <one action>

3) [<bucket emoji>] <Sender> — <Subject>
   • Summary: <1–2 lines>
   • Deadline: <absolute date/time or "None">
   • Next step: <one action>

4) [<bucket emoji>] <Sender> — <Subject>
   • Summary: <1–2 lines>
   • Deadline: <absolute date/time or "None">
   • Next step: <one action>

5) [<bucket emoji>] <Sender> — <Subject>
   • Summary: <1–2 lines>
   • Deadline: <absolute date/time or "None">
   • Next step: <one action>

## Safety
Never paste long email bodies. Summaries must be brief.