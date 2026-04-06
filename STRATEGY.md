# Bildhauer — Strategy

See `VISION.md` for the guiding analogy and principles.

---

## The Problem

AI generates code in a single pass. When asked to build a component, it produces the entire file from top to bottom — struct layout, error handling, logging conventions, shutdown method, edge cases — all decided simultaneously. There is no "first I established the architecture, then I filled in the details." Every decision at every level of resolution is made at once.

This is structurally equivalent to the sculptor trying to produce a finished statue in a single pass from the raw stone. The result works — it compiles, it runs — but it lacks coherence across parts. Each fragment is reasonable in isolation. Together, they don't hold together as a whole.

The severity depends on what resolution the mistakes were made at.

If the coarse pass was skipped entirely — no investigation of the existing codebase, no deliberate architecture — the head may be too big for the body. Component boundaries in the wrong place, data flowing the wrong direction, the whole integration approach unworkable. No amount of detail work fixes that. The stone needs to go back to a block. In code, that's a redesign.

If the coarse shape is right but the medium pass was skipped — proportions are sound but internal structure wasn't checked for coherence. The shoulders are slightly uneven. One component uses one logging convention, its sibling uses another. One service shuts down gracefully, the other kills connections. Config values loaded but never wired through. Each issue is small. Together they make the whole thing feel wrong. In code, that's a significant refactor.

If coarse and medium were done properly and only the fine pass was single-shot — the issues are genuinely small. A nil check here, a log format there. Those are local fixes.

The deeper the resolution at which mistakes were made, the more costly they are to fix — and the more work has been built on top of them. Post-hoc fixing finds the problems but fights the existing shape. The ad-hoc decisions are baked into the structure. Patching one decision disturbs its neighbors. Multiple audit rounds surface more issues each time — not because the auditor gets better, but because each fix reveals new incoherence underneath. It's the sculptor sanding bumps on a shifted jaw — each bump is "fixed" but the face never looks right, because the problem is one resolution level deeper.

The fundamental issue is not that AI is careless. It's that single-pass generation cannot produce coarse-to-fine coherence. The capability is there — AI can trace data flows, recognize patterns, check consistency — but it can't do these things *during* the generation pass. It can only do them *between* passes, when re-reading its own output against the broader context.

---

## The Principle

The protocol enforces coarse-to-fine refinement. Not everything at once.

This applies to design (the shape — components, data flows, boundaries), plan (the sequence — what to build first, what depends on what), and implementation details (the decisions within each part — which patterns to follow, how to handle errors, what the consumer actually needs).

AI tends to collapse all three into a single generation pass. The protocol separates them into multiple passes at increasing resolution. Each pass covers the whole piece at its current resolution before any part moves to the next level of detail.

The protocol does not prescribe how many passes, what to look at in each pass, or what format to use. Those emerge from the work itself — the stone, the vision, what reveals itself. What the protocol enforces is the discipline: work from coarse to fine. Check coherence of the whole before detailing the parts. Don't jump resolution.

---

## What We Know Works

These are observations from experience, not prescriptions. They describe practices that produce better results when applied within the coarse-to-fine refinement process.

**Evidence over assumption.** When checking whether a pattern exists, whether code behaves a certain way, or whether a design decision holds — read the actual code. Search results show where to look, not what's there. Claims without evidence are the AI's overconfidence at work.

**Tracing over fragment-checking.** Don't evaluate code in isolation. Follow data from where it's produced to where it's consumed. Follow config from where it's loaded to where it's used. When reviewing an output, ask what the consumer actually needs. Most design-level issues are invisible at the fragment level and obvious when tracing the flow.

**Investigation before implementation.** Decisions made during active code generation are ad-hoc — driven by what's in context at that token position, not by deliberate comparison with the existing codebase. Moving decisions into a prior investigation pass — where the AI reads reference implementations and documents which patterns to follow — produces more coherent results.

**Writing things down forces diligence.** When the AI is required to list what it found, it looks more carefully than when it's allowed to summarize or move on. The act of recording creates accountability. The format matters less than the requirement to record.

**Existing code is the authority.** When building into an existing codebase, the codebase's patterns are the standard — not the AI's training data, not general best practices. Read the closest existing equivalent before writing a new component. Match its conventions.

**Challenge before building.** When presented with an approach or design direction, state at least one concern, limitation, or alternative before building on it. Reasonable-sounding proposals are where unchallenged assumptions do the most damage. This connects to the vision's "check the vision at transitions" but applies at every decision point, not just phase transitions.

**Data-flow tracing is the most reliable finding mechanism.** In every pass across a real multi-pass session, tracing "what writes this data and what reads it" found real problems — parallel write conflicts, missing resets, underspecified interfaces, format mismatches. Fragment-level review (looking at one component) consistently missed what flow-level tracing found. This reinforces observation 8 but elevates it: data-flow tracing isn't just a technique that works, it's the single most productive element of the bozzetto.

---

## Open Questions

These are the design space to explore. No premature decisions.

- How should the refinement passes be structured? Fixed phases, or emergent from the work?
- What level of accountability (recording findings, decisions, rationale) balances diligence against overhead?
- Should the loop be interactive with the user, automated (e.g., via subagents reviewing each other's work), or a combination? *Observation 15 (design-to-build transition gate) suggests "combination" — the triage and risk identification steps are autonomous, while the actual decisions on structural blockers require human judgment. The gate narrows the human decision surface rather than removing it.*
- How should reference knowledge (common blind spots, minimum quality checks) be made available without narrowing the AI's attention?
- How does the protocol adapt to different task types — a code audit needs different passes than a greenfield implementation?
- What signals indicate that a pass is complete and the next resolution level is appropriate?
- How to prevent the protocol itself from becoming the kind of rigid structure it aims to replace?
