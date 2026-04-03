---
name: bildhauer
description: This skill should be used when the user says "bildhauer", "step back", "refine", "check the vision", or asks to evaluate whether the current approach is right before continuing. Also use when starting a significant implementation task, to establish the coarse-to-fine mindset.
version: 0.1.0
license: MIT
---

# Bildhauer — Coarse-to-Fine Refinement

**This is a thinking lens, not a protocol.** Load the vision and observations, adopt the mindset, then work naturally. No tracker, no status labels, no rigid workflow.

## Load these now

Read these files from the plugin's repository to understand the framework:

1. `VISION.md` — the Bildhauer analogy. How a sculptor works from rough to detailed, always checking coherence. The Bozzetto (clay model) before the marble. This is how we approach design and implementation.

2. `OBSERVATIONS.md` — documented AI shortcomings and techniques that work. Grounded in real incidents. Know what to watch for in yourself.

3. `STRATEGY.md` — the problem (single-pass generation), the principle (coarse-to-fine), what we know works.

## Core mindset

**Work from coarse to fine.** Don't detail one part while the rest is still rough. Each pass should refine the whole piece one level, not finish one section.

**Step back and check.** After working, re-read what you produced against the broader context. This is how you catch incoherence between parts. You can't see it during generation — only between passes.

**Bump or jaw?** When you find something wrong, ask whether it's a local detail or a symptom of something wrong at a coarser level. Check before fixing.

**Check the vision at transitions.** When a section of work is complete and the next is about to begin, pause and ask: are we building the right thing? Not just building it correctly.

**Bozzetto before marble.** Refine design, plan, and implementation details before writing code. Clay is cheap to reshape. Code is expensive to rework.

## When to apply

- Starting a significant implementation task — establish what resolution we're at
- When something feels off during implementation — step back, check proportions
- When asked to audit or review — trace flows across the whole system, not fragments
- At transitions between phases of work — validate the vision before continuing
- When refining bildhauer itself — update OBSERVATIONS.md or VISION.md with what we learned

## Refining bildhauer

This framework is itself a work in progress. It improves through use, not through theory.

**After completing a significant piece of work**, actively reflect on the process:
- Did the coarse-to-fine approach work? Where did it break down?
- Did you skip a resolution level? What was the consequence?
- Did you step back when you should have, or did the user have to prompt it?
- Was there a moment where the vision itself needed questioning?
- Did you discover a new shortcoming or technique worth documenting?

**Propose updates to the bildhauer repo** based on what you observed — don't wait for the user to ask. But never edit bildhauer files without explicit permission. Propose the change, discuss it, and only write after the user agrees. Offer specific additions or amendments:

- New shortcoming pattern → propose addition to OBSERVATIONS.md Part 1
- New technique that works → propose addition to OBSERVATIONS.md Part 2
- Insight about the analogy → propose update to VISION.md
- Strategic learning → propose update to STRATEGY.md
