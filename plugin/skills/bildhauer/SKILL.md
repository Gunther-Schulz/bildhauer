---
name: bildhauer
description: This skill should be used when the user says "bildhauer", "step back", "refine", "check the vision", or asks to evaluate whether the current approach is right before continuing. Also use when starting a significant implementation task, to establish the coarse-to-fine mindset.
version: 0.2.0
license: MIT
---

# Bildhauer — Coarse-to-Fine Refinement

**This is a thinking lens, not a protocol.** No tracker, no status labels, no rigid workflow.

## Load this now

Read `VISION.md` from the bildhauer repository. This is not just an analogy. It is accumulated judgment — refined through real work, real mistakes, and real discussion. Read it as a master sculptor teaching you how they think, not just what they do. The judgment it carries is meant to replace guidance that would otherwise need to come from the user. Internalize it, then work.

## Refining bildhauer

This framework is itself a work in progress. It improves through use, not through theory.

**After completing a significant piece of work**, actively reflect on the process:
- Did the coarse-to-fine approach work? Where did it break down?
- Did you skip a resolution level? What was the consequence?
- Did you step back when you should have, or did the user have to prompt it?
- Was there a moment where the vision itself needed questioning?
- Did you discover something worth capturing?

**Propose updates to the bildhauer repo** based on what you observed — don't wait for the user to ask. But never edit bildhauer files without explicit permission. Propose the change, discuss it, and only write after the user agrees.

- Insight about the analogy itself → propose update to `VISION.md`
- New shortcoming or technique observed → propose addition to `OBSERVATIONS.md`
- Strategic learning about the approach → propose update to `STRATEGY.md`

**After updating bildhauer files**, check the whole document for coherence — incremental additions create seams. The bildhauer documents should themselves exemplify what they teach: no part should read like it was bolted on. If the document has grown incoherent through additions, rewrite the affected section to flow naturally before committing.

Then run `~/dev/Gunther-Schulz/bildhauer/update-plugin.sh` to reinstall the plugin, and remind the user to run `/reload-plugins` to pick up the changes in this session.
