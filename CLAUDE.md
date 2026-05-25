# Repository housekeeping for the bildhauer plugin

Rules for maintaining the Bildhauer plugin itself — separate from
the skill's runtime behavior (governed by `plugin/skills/bildhauer/`).

## Description sync (single source of truth)

These three texts must match each other and reflect the current
top-level `README.md` framing:

- `.claude-plugin/marketplace.json` → `plugins[0].description`
- `plugin/.claude-plugin/plugin.json` → `description`
- `README.md` → opening paragraph

When one changes, all three change. The marketplace.json tagline is
what plugin directories surface — staleness here = stale public
representation regardless of how good the README is.

## Files inventory

Bildhauer ships a single skill (`plugin/skills/bildhauer/`). When
files are added, renamed, or removed under this directory, update
`README.md`'s Files table + `SKILL.md`'s Documents-and-dependencies
table in the same commit.

Category 2 maintenance files live under `dev-notes/` (`VISION.md`,
`OBSERVATIONS.md`, `ROADMAP.md`) — outside the plugin payload per
the skill-craft Layer 1 boundary rule. When one is renamed or moved,
update both tables.

## Version discipline

Bump `plugin/.claude-plugin/plugin.json` → `version` before pushing a
release. The marketplace caches by version — a push without a version
bump won't propagate via `claude plugin marketplace update`.

`SKILL.md`'s frontmatter `version` field is independent tracking; the
`plugin.json` version is the canonical number for marketplace caching.
If they drift, `plugin.json` wins as the authoritative.

## No specific model names in user-facing text

`README.md`, `marketplace.json`, and `plugin.json` descriptions must
not name Claude models (Sonnet, Opus, Haiku). Model assignments
change; baking them into prose creates maintenance drift.

## Release flow (push-based)

After committing changes locally:

```
git push
claude plugin marketplace update bildhauer-marketplace
```

Then ask the operator to run `/reload-plugins`. No uninstall/reinstall
step needed — the marketplace clone refreshes from origin on update.

## Pre-push checklist

Before pushing a release commit:

- [ ] `plugin.json` `version` bumped
- [ ] `marketplace.json` plugin description matches `plugin.json` description
- [ ] Both descriptions reflect current `README.md` opening
- [ ] `README.md` Files table matches `plugin/skills/bildhauer/` + `dev-notes/` contents
- [ ] `SKILL.md` Documents-and-dependencies table matches actual layout
- [ ] No specific model names in any of the above
