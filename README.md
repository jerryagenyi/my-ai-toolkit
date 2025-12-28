# My AI Toolkit

> A portable, opinionated toolkit for AI-assisted software development. Works with Claude, GPT, Cursor, Copilot, and any AI assistant.

---

## 🚀 Quick Start

1. **Copy this file** to your project:
   ```bash
   cp MY_AI_TOOLKIT.md ./
   ```

2. **Share with AI assistant:**
   ```
   "Check MY_AI_TOOLKIT.md for my tools and preferences.
   I'm using [your stack here].
   Help me with [your task]."
   ```

3. **Done!** The AI now knows your entire development approach.

---

## 📁 What's Included

| File | Purpose |
|------|---------|
| **MY_AI_TOOLKIT.md** | Main toolkit - all tools, plugins, stack recommendations |
| **PROJECT_INIT_TEMPLATE.md** | Project initialization checklist |
| **CLAUDE_EXAMPLE.md** | Example CLAUDE.md from real project |

---

## 🎯 Who This Is For

- Developers who work with AI assistants regularly
- Teams wanting consistent AI configuration
- Anyone who wants to document their tooling choices
- People who switch between multiple projects/stacks

---

## 🛠️ What's In The Toolkit

### Core Framework
- **BMAD Method** - Enterprise development workflow (Product → PRD → Architecture → Stories → Implementation)

### Plugins (Claude Code)
- **security-guidance** - Security vulnerability detection
- **php-lsp** - PHP/Laravel support
- **typescript-lsp** - TypeScript support
- **feature-dev** - Architecture help
- **frontend-design** - UI/UX assistance
- **ralph-wiggum** - Fun easter egg 🧋

### MCP Servers
- **Docker MCP Gateway** - 100+ tools via single connection (GitHub, NPM, Brave, Context7, Playwright, etc.)

### Tech Stack Coverage
- Laravel + Vue/Quasar
- Next.js
- React + Node.js
- Python + FastAPI/Django
- Rust
- Java + Spring Boot
- Ruby + Rails
- Flutter
- And more...

---

## 💡 How to Use

### For New Projects
```bash
# Copy toolkit
cp MY_AI_TOOLKIT.md /path/to/new-project/

# Initialize BMAD (optional)
npx bmad-method@alpha install

# Share with AI
"Check MY_AI_TOOLKIT.md. I'm building a [describe project]
 with [stack]. Help me set up [feature]."
```

### For Existing Projects
```bash
# Copy toolkit
cp MY_AI_TOOLKIT.md ./

# Share with AI
"I've added MY_AI_TOOLKIT.md to explain my approach.
Check it and help me with [current task]."
```

### For Team Onboarding
```
1. Share this repo with team
2. Have them customize MY_AI_TOOLKIT.md for their needs
3. Use it as reference for tooling discussions
4. Keep it updated as team evolves
```

---

## 🎓 Philosophy

**"Simple tools, well-documented, consistently applied."**

This toolkit is intentionally **NOT**:
- ❌ An automated installer
- ❌ Tied to specific AI platform
- ❌ A permanent commitment
- ❌ Prescriptive for everyone

It **IS**:
- ✅ A reference for what I use
- ✅ Shareable with any AI assistant
- ✅ A living document that evolves
- ✅ A template for others to customize

---

## 📊 My Stack

I primarily use:
- **Backend:** Laravel 10 + PostgreSQL + Redis
- **Frontend:** Vue 3 + Quasar OR Next.js 14
- **Testing:** PHPUnit, Vitest, Playwright
- **DevOps:** Docker, Dokploy

But the toolkit covers 8+ other stacks too!

---

## 🎓 Philosophy & Commitment

### Core Principle

**"Simple tools, well-documented, consistently applied."**

This toolkit follows a **strict "need-to-have" philosophy:**

- ✅ **Essential tools only** - If I can't work without it, it's in
- ✅ **Well-maintained** - Active development, regular updates
- ✅ **Standardized** - Uses standard protocols (MCP over custom plugins)
- ✅ **Stack-agnostic** - Works across my typical projects
- ❌ **Nice-to-haves** - Removed to avoid bloat

### The "3-Project Rule"

**Every tool must prove itself in 3 projects, or it gets removed.**

This prevents tool bloat and ensures everything in the toolkit is battle-tested.

### My Commitment

**I will update this repository when:**
- ✅ I discover a new tool that becomes essential
- ✅ A tool becomes unmaintained and needs replacement
- ✅ My tech stack changes significantly
- ✅ Quarterly review reveals needed updates

**I will NOT add:**
- ❌ Tools just because they're interesting
- ❌ Overlapping functionality (keep the best one)
- ❌ Custom protocols when standard exists
- ❌ Narrow-use case tools unless critical

### Evolution Strategy

```
Lean → Use → Evaluate → Keep or Remove
  ↓       ↓          ↓           ↓
Start  3 projects   Does it    Yes → Keep
Lean                 add value?
                                 ↓
                            No → Remove
```

**This means:**
- The toolkit gets MORE useful over time, not larger
- Every tool has proven value
- You can trust everything listed is essential
- Updates are intentional, not habitual

### What This Means For You

If you fork this toolkit:
1. **Start lean** - Only add what you absolutely need
2. **Test thoroughly** - Use tools in 3+ projects before documenting them
3. **Remove ruthlessly** - If you haven't used it in 3 projects, remove it
4. **Update intentionally** - Don't add just because something is new/popular

The goal isn't to have every tool - it's to have the **right tools**.

---

## 🔄 Maintenance

### Quarterly Review Checklist

**For Me:**
- [ ] List all tools used in past 3 months
- [ ] Remove any tool not used in 3+ projects
- [ ] Add new tools that have proven essential
- [ ] Update stack preferences if changed
- [ ] Document why tools were added/removed

**Before Adding Anything, Ask:**
1. Is this essential? Can I work without it?
2. Does this overlap with existing tools?
3. Have I used this in 3+ projects?
4. Is this well-maintained and standardized?
5. Would I recommend this to others?

**If answer is NO to any:** Don't add it.

### Lean Toolkit Indicators

**🟢 Healthy Toolkit:**
- Total tools: < 20
- All tools used in last 3 projects
- No overlapping functionality
- Everything has clear purpose

**🟡 Warning Signs:**
- Total tools: 20-30
- Some tools not used recently
- Minor overlap in functionality
- Questionable purpose for some items

**🔴 Time to Trim:**
- Total tools: 30+
- Many tools not used in 3+ projects
- Significant overlap
- Can't explain why some tools exist

**Goal:** Stay 🟢 Green.

### Update Frequency

| Action | Frequency |
|--------|------------|
| Add new tool | Only when essential (proven in 3 projects) |
| Remove tool | Quarterly review OR if unmaintained |
| Update docs | When stack changes |
| Full review | Quarterly |

**Remember:** The toolkit gets BETTER by getting smaller and more focused, not larger.

---

## 📏 Size Guidelines

**Target size:**
- Essential plugins: 3-7
- MCP servers: 1-3 (Docker Gateway covers 90%)
- LSP plugins: 1-2 (your languages only)
- Utility tools: 1-3 (Repomix, etc.)

**Total tool count: Aim for < 20 items maximum.**

If you're at 30+ tools, you're not being selective enough.

---

## 📝 Customization

**This is MY toolkit. You should build YOURS:**

1. Fork this repo
2. Edit MY_AI_TOOLKIT.md
3. Add YOUR tools, stack, preferences
4. Remove what doesn't apply
5. Use it consistently

The value isn't in the specific tools - it's in **having documented what you use**.

---

## 🤝 Contributing

Feel free to:
- Fork for your own use
- Customize to your needs
- Share with your team
- Open PRs for improvements

But remember: **The best toolkit is one you actually use.**

---

## 📄 License

MIT - Do whatever you want with this. Make it your own.

---

## 🙏 Acknowledgments

Built from lessons learned across dozens of AI-assisted projects.

Inspired by:
- [BMAD Method](https://github.com/aicodeking/bmad-method)
- [Claude Code](https://claude.ai/code)
- [KingMode](https://github.com/aicodeking/yt-tutorial)
- The broader AI-assisted development community

---

**Last Updated:** 2025-12-28
**Version:** 1.0.0
