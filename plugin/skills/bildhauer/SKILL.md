---
name: bildhauer
description: This skill should be used when the user says "bildhauer", "step back", "refine", "check the vision", "audit adherence", or asks to evaluate whether the current approach is right before continuing. Also use when starting a significant implementation task, to establish the coarse-to-fine mindset.
version: 0.4.0
license: MIT
---

# Bildhauer — Coarse-to-Fine Refinement

## Load this now

Read `PROCEDURE.md` from the bildhauer repository. Follow it.

## Refining bildhauer

This framework is itself a work in progress. It improves through use, not through theory.

**After completing a significant piece of work**, actively reflect on the process:
- Did you follow the checkpoints, or skip them?
- Did the checkpoints catch a real problem, or were they performative?
- Did the user have to prompt a step-back or self-challenge that you should have done yourself?
- Did you discover something worth capturing?

**When the user asks to audit adherence**, compare actual behavior against PROCEDURE.md checkpoints. For each checkpoint, identify specific moments in the conversation where it should have fired. For each moment, assess: did it fire? If it fired, did it produce a different outcome than the default would have, or was it performative? Rate overall impact honestly — the question is whether the checkpoints changed behavior, not whether they were performed.

**Propose updates to the bildhauer repo** based on what you observed — don't wait for the user to ask. But never edit bildhauer files without explicit permission. Propose the change, discuss it, and only write after the user agrees.

**Four documents, with dependencies:**

| Document | Purpose | Derived from | When changed, also check |
|---|---|---|---|
| `VISION.md` | The philosophy of good craftsmanship — what quality means and when each dimension is attended to | First principles | `PROCEDURE.md` (checkpoints are derived from vision principles) |
| `PROCEDURE.md` | Actionable steps translating the philosophy into practice for technical work | `VISION.md` | Nothing — it's a leaf |
| `OBSERVATIONS.md` | Documented patterns (failures and techniques) grounded in real incidents | Real usage | `STRATEGY.md` (observations inform strategic direction) |
| `STRATEGY.md` | The problem being solved, what works, and open design questions for the protocol | `OBSERVATIONS.md` + `VISION.md` | Nothing — it's a leaf |

When proposing updates:
- Procedural checkpoint change → `PROCEDURE.md`
- Insight about the analogy itself → `VISION.md`
- New shortcoming or technique observed → `OBSERVATIONS.md`
- Strategic learning about the approach → `STRATEGY.md`

**Maintenance rule:** When updating a parent doc, re-read its dependents and check whether they still follow from the updated parent. PROCEDURE.md derived from a VISION.md that no longer says what it used to is a stale procedure.

**After updating bildhauer files**, check the whole document for coherence — incremental additions create seams. The bildhauer documents should themselves exemplify what they teach: no part should read like it was bolted on. If the document has grown incoherent through additions, rewrite the affected section to flow naturally before committing.

Then run `~/dev/Gunther-Schulz/bildhauer/update-plugin.sh` to reinstall the plugin, and remind the user to run `/reload-plugins` to pick up the changes in this session.
