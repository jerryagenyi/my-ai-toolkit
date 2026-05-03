# Philosophy & Tool Selection Criteria

> How we decide what goes into the toolkit and what stays out.

---

## Tool Selection Criteria

A tool must meet ALL of these:

1. **Essential** — Can't work without it OR it delivers massive time savings
2. **Well-maintained** — Active development, regular updates, responsive maintainers
3. **Standardized** — Uses standard protocols (MCP over custom plugins)
4. **Stack-agnostic** — Works across typical projects, not locked to one framework

---

## Red Flags

- Overlapping functionality — keep the best one, drop the rest
- Abandoned projects — no commits in 6+ months is a warning sign
- Custom protocols when a standard exists — prefer MCP, LSP, REST
- Narrow use case unless it's critical (security tools get a pass)

---

## Tool Bloat Prevention

**3-Project Rule:** If a tool hasn't been used in the last 3 projects, remove it from the toolkit.

**Exceptions:**
- Security tools (rare but critical)
- Emergency/incident response tools
- Tools used specifically for periodic maintenance (scanning, auditing)

---

## Quarterly Review Process

Every quarter:

1. Review what tools were actually used
2. Remove anything not used in 3 projects
3. Add new tools that have been adopted
4. Update stack preferences if they've shifted
5. Check for deprecated/abandoned tools in the toolkit

---

## Preference Hierarchy

When two tools solve the same problem:

1. **MCP server** over Claude plugin (standardized protocol, better maintained)
2. **CLI tool** over GUI tool (scriptable, automatable)
3. **Active community** over solo project (longevity)
4. **Composable** over monolithic (flexible, replaceable)
