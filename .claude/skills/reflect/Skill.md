---
name: Reflect
description: Analyze the conversation for corrections, approvals, and patterns. Update project skills with learned preferences. Use this when the user says "reflect" or after sessions with explicit feedback/corrections. Automatically extracts learning signals and updates skill files.
---

# Reflect - Self-Improving Memory

Analyze sessions to extract corrections and patterns, then update project skills automatically.

## When to Use

- Triggered by `/reflect` command
- After sessions with explicit corrections or approvals
- When user provides feedback like "always do X" or "never do Y"
- Automatically via hooks at session end (if enabled)

## What This Skill Does

1. **Scans the conversation** for learning signals:
   - Corrections: User said "don't do X" or "use Y instead"
   - Approvals: User accepted a suggestion enthusiastically
   - Patterns: Approaches that worked well repeatedly

2. **Categorizes by confidence:**
   - **HIGH** - Never do X (explicit prohibitions)
   - **MEDIUM** - Patterns that work well (successful approaches)
   - **LOW** - Observations to review later

3. **Updates relevant skills:**
   - `ui-conventions/Skill.md` - UI/UX patterns
   - `code-style/Skill.md` - Coding conventions
   - `api-design/Skill.md` - API design patterns
   - `security-practices/Skill.md` - Security learnings

4. **Commits to Git:**
   - Auto-generates descriptive commit message
   - Shows diff for review before applying
   - Allows natural language edits to proposals

## How to Analyze a Session

### Step 1: Identify Learning Signals

Look for patterns like:

| Signal Pattern | Example | Confidence |
|----------------|---------|------------|
| "Never use X" | "Never use alert() in this project" | HIGH |
| "Always use Y" | "Always use Quasar's Notify plugin" | HIGH |
| "Don't do X, use Y" | "Don't use var, use const/let" | HIGH |
| "That's perfect/great" | User accepted suggestion | MEDIUM |
| "I prefer Y" | "I prefer composition API" | MEDIUM |
| "Seems like..." | "User seems to prefer TypeScript" | LOW |

### Step 2: Map to Skills

| Learning | Skill to Update | Section |
|----------|-----------------|---------|
| UI components, notifications, styling | `ui-conventions/` | Relevant section |
| Code patterns, naming, async/await | `code-style/` | Relevant section |
| API responses, status codes, endpoints | `api-design/` | Relevant section |
| Security, validation, secrets | `security-practices/` | Relevant section |

### Step 3: Propose Changes

For each learning, propose:

```markdown
## Proposed Change

**Signal:** HIGH/MEDIUM/LOW
**Source:** User correction on [date]
**Learning:** [What was learned]

**Before:**
[Current content in skill]

**After:**
[Updated content with learning]
```

### Step 4: Generate Commit Message

Format: `feat(skill-name): learning description`

Examples:
- `feat(ui-conventions): learn to use Quasar Notify instead of alert()`
- `feat(code-style): learn to prefer async/await over Promise chains`
- `feat(api-design): learn to return 204 for DELETE endpoints`

## Example Session Analysis

```
User: Create a submit button
Claude: [Creates with inline alert()]

User: Don't use alert(). Use Quasar's $q.notify instead.
Claude: [Updates to use $q.notify]

---

/reflect triggers this skill:

Signals Detected:
1. HIGH: Never use alert() in this project
2. MEDIUM: Use Quasar's $q.notify for notifications

Skill to Update: ui-conventions

Proposed Change:
Add to "Notifications" section:
- **CRITICAL:** Never use browser alert()
- Always use: $q.notify({ type: 'positive', message: '...' })

Commit: feat(ui-conventions): learn to use Quasar Notify instead of alert()
```

## Guidelines for Good Learning

### DO:
- Be specific about what changed
- Include context (what was wrong, why it was corrected)
- Use consistent language ("never" for HIGH, "prefer" for MEDIUM)
- Link to original conversation if possible

### DON'T:
- Record vague observations without context
- Store LOW confidence items that aren't useful
- Update skills without user confirmation
- Add contradictory rules

## Toggle Controls

User can control this skill:

```bash
/reflect         # Trigger manual reflection
/reflect on      # Enable auto-reflection on session end
/reflect off     # Disable auto-reflection
/reflect status  # Check if auto-reflection is enabled
```

## Files This Skill Updates

- `.claude/skills/ui-conventions/Skill.md`
- `.claude/skills/code-style/Skill.md`
- `.claude/skills/api-design/Skill.md`
- `.claude/skills/security-practices/Skill.md`

## Hook Integration

When enabled via `stop-hook`, this skill runs automatically at session end:

1. Session ends
2. Hook triggers this skill
3. Conversation is analyzed
4. Learning signals extracted
5. Proposals generated and shown
6. User confirms/edits
7. Skills updated
8. Git commit created

## References

- Video: https://youtu.be/-4nUCaMNBR8
- Skills spec: https://agentskills.io
