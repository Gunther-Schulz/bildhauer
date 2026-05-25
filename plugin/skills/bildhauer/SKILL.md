---
name: bildhauer
description: This skill should be used when the user says "bildhauer", "step back", "refine", "check the vision", "audit behavior change", or asks to evaluate whether the current approach is right before continuing. Use proactively at decision moments — before drafting rule-corpus content (specs, memories, CLAUDE.md, skill files), before building on the state of a loaded artifact (verify it matches source-of-truth), before presenting options (test: would each be defended on merit?), before declaring work complete or skipping a verification step. Threshold is the decision moment, not the scale of the work; applies to single-paragraph edits and multi-step implementations alike, across code, discussions, proposals, and analytical conclusions.
version: 0.7.0
license: MIT
---

# Bildhauer — Coarse-to-Fine Refinement

## Load this now

Read `PROCEDURE.md` from this skill's directory. Follow it.

## Refining bildhauer

This framework improves through use, not through theory.

**When the user asks to audit behavior change**, compare actual behavior against
PROCEDURE.md checkpoints. For each checkpoint, identify specific moments
in the conversation where it should have fired. For each moment, assess:
did it shift behavior, or was it performative? Did it produce a different
outcome than the default? Rate impact honestly — the question is whether
checkpoints changed behavior, not whether they were performed.

**When a gap is noticed during use** — a checkpoint that should have
fired but didn't, a failure the procedure doesn't cover, a pattern worth
capturing — persist it:

1. Write the observation to the improvement journal (`dev-notes/OBSERVATIONS.md`)
2. Assess if PROCEDURE.md needs updating based on the observation
3. Propose the change with reasoning. Do not change without permission.

Do not wait for the user to ask. Surface gaps proactively.

**Documents and dependencies.** This table guides maintenance updates.
Category 2 files (under `dev-notes/`) are NOT loaded during skill use —
read only when updating the skill itself:

| Document | Purpose | Derived from | When changed, also check |
|---|---|---|---|
| `dev-notes/VISION.md` | The philosophy of good craftsmanship — what quality means and when each dimension is attended to | First principles | `PROCEDURE.md` (checkpoints are derived from vision principles) |
| `PROCEDURE.md` | Actionable checkpoints — applies to code, design, analysis, and discussion | `dev-notes/VISION.md` | `references/patterns.md` (specialized patterns referenced from checkpoints) |
| `references/patterns.md` | Specialized guidance for specific work types (data flow, error handling, verification states) | `PROCEDURE.md` + `dev-notes/OBSERVATIONS.md` | Nothing — it's a leaf |
| `dev-notes/OBSERVATIONS.md` | Documented patterns (failures and techniques) grounded in real incidents | Real usage | Nothing — it's a leaf |
| `dev-notes/ROADMAP.md` | Concrete work items for improving the framework, grounded in observed failures | `dev-notes/OBSERVATIONS.md` + behavior-change audits | Nothing — it's a leaf |

When proposing updates:
- Procedural checkpoint change → `PROCEDURE.md`
- Insight about the analogy itself → `dev-notes/VISION.md`
- New shortcoming or technique observed → `dev-notes/OBSERVATIONS.md`
- Concrete improvement work item → `dev-notes/ROADMAP.md`

**Maintenance rule:** When updating a parent doc, re-read its dependents
and check consistency. PROCEDURE.md derived from a `dev-notes/VISION.md`
that no longer says what it used to is a stale procedure.

**After updating bildhauer files**, check the whole document for
coherence — incremental additions create seams. Rewrite affected sections
to flow naturally before committing.

Then push to origin and run `claude plugin marketplace update` so the
marketplace clone refreshes; remind the user to run `/reload-plugins`.
