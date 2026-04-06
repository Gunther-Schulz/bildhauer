---
name: bildhauer
description: This skill should be used when the user says "bildhauer", "step back", "refine", "check the vision", "audit adherence", or asks to evaluate whether the current approach is right before continuing. Also use when starting significant work — implementation, design, analysis, or investigation — to establish the coarse-to-fine mindset. Applies to code, discussions, proposals, and analytical conclusions alike.
version: 0.5.0
license: MIT
---

# Bildhauer — Coarse-to-Fine Refinement

## Load this now

Read `PROCEDURE.md` from this skill's directory. Follow it.

## Refining bildhauer

This framework improves through use, not through theory.

**When the user asks to audit adherence**, compare actual behavior against
PROCEDURE.md checkpoints. For each checkpoint, identify specific moments
in the conversation where it should have fired. For each moment, assess:
did it fire? Did it produce a different outcome than the default, or was
it performative? Rate impact honestly — the question is whether
checkpoints changed behavior, not whether they were performed.

**When a gap is noticed during use** — a checkpoint that should have
fired but didn't, a failure the procedure doesn't cover, a pattern worth
capturing — persist it:

1. Write the observation to the improvement journal (OBSERVATIONS.md)
2. Assess if PROCEDURE.md needs updating based on the observation
3. Propose the change with reasoning. Do not change without permission.

Do not wait for the user to ask. Surface gaps proactively.

**Five documents, with dependencies.** This table guides maintenance
updates. Category 2 files (VISION, OBSERVATIONS, STRATEGY, ROADMAP) are
NOT loaded during skill use — read only when updating the skill itself:

| Document | Purpose | Derived from | When changed, also check |
|---|---|---|---|
| `VISION.md` | The philosophy of good craftsmanship — what quality means and when each dimension is attended to | First principles | `PROCEDURE.md` (checkpoints are derived from vision principles) |
| `PROCEDURE.md` | Actionable checkpoints — applies to code, design, analysis, and discussion | `VISION.md` | Nothing — it's a leaf |
| `OBSERVATIONS.md` | Documented patterns (failures and techniques) grounded in real incidents | Real usage | `STRATEGY.md` (observations inform strategic direction) |
| `STRATEGY.md` | The problem being solved, what works, and open design questions for the protocol | `OBSERVATIONS.md` + `VISION.md` | Nothing — it's a leaf |
| `ROADMAP.md` | Concrete work items for improving the framework, grounded in observed failures | `OBSERVATIONS.md` + adherence audits | Nothing — it's a leaf |

When proposing updates:
- Procedural checkpoint change → `PROCEDURE.md`
- Insight about the analogy itself → `VISION.md`
- New shortcoming or technique observed → `OBSERVATIONS.md`
- Strategic learning about the approach → `STRATEGY.md`
- Concrete improvement work item → `ROADMAP.md`

**Maintenance rule:** When updating a parent doc, re-read its dependents
and check consistency. PROCEDURE.md derived from a VISION.md that no
longer says what it used to is a stale procedure.

**After updating bildhauer files**, check the whole document for
coherence — incremental additions create seams. Rewrite affected sections
to flow naturally before committing.

Then run `~/dev/Gunther-Schulz/bildhauer/update-plugin.sh` to reinstall,
and remind the user to run `/reload-plugins`.
