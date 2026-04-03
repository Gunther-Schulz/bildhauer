# Bildhauer — Strategy

## Part 1: The Analogy

A Bildhauer starts with a rough block of stone and a vision. Not a blueprint — the final form can't be fully known before the work begins. The material reveals constraints as it's shaped.

The sculptor works from coarse to fine. First, large chunks come off — establishing proportions, the basic masses, where the limbs are relative to the torso. At this stage, no detail. Just the big shape. The sculptor steps back frequently to check the whole piece: are the proportions right? Does the gesture make sense?

Then the medium work. Each section gets structure — the arm gets an elbow, the face gets a nose. But still, the sculptor checks the whole: does the elbow match the shoulder? Does the nose fit the face? Nothing is detailed in isolation. Every part is shaped in relation to every other part.

Then the fine work. Surface texture, fingernails, the curve of an eyelid. These details only make sense because the proportions and structure are already right. You can't polish a second nose.

At every stage, the whole piece is coherent. There are no sudden spikes or crevices that don't belong. No random detail where the surrounding area is still rough. The sculptor never jumps resolution — never carves fingernails while the arm is still a block.

If you tried to do it all at once — shape the block, define the structure, and polish the surface in a single pass — you'd get a mess. Fragments that are individually reasonable but don't relate to each other. An arm that doesn't match the shoulder. A polished ear on a head that's still a cube.

---

## Part 2: The Problem

AI generates code in a single pass. When asked to build a component, it produces the entire file from top to bottom — struct layout, error handling, logging conventions, shutdown method, edge cases — all decided simultaneously. There is no "first I established the architecture, then I filled in the details." Every decision at every level of resolution is made at once.

This is structurally equivalent to the sculptor trying to produce a finished statue in a single pass from the raw stone. The result works — it compiles, it runs — but it lacks coherence across parts. One component uses `fmt.Printf`, its sibling uses `log.Printf`. One service shuts down gracefully, the other kills connections. Config values are loaded but never wired through. Sentinel values flow into user-facing outputs without anyone asking what the user actually needs to see.

Each fragment is reasonable in isolation. The statue has two noses.

Post-hoc fixing (audits, reviews, patches) finds these problems but fights the existing shape. The ad-hoc decisions are baked into the structure. Patching one decision disturbs its neighbors. Multiple audit rounds surface more issues each time — not because the auditor gets better, but because each fix reveals new incoherence underneath. The foundation was never coherent; it was generated all at once.

The fundamental issue is not that AI is careless. It's that single-pass generation cannot produce coarse-to-fine coherence. The capability is there — AI can trace data flows, recognize patterns, check consistency — but it can't do these things *during* the generation pass. It can only do them *between* passes, when re-reading its own output against the broader context.

---

## Part 3: The Principle

The protocol enforces coarse-to-fine refinement. Not everything at once.

This applies to design (the shape — components, data flows, boundaries), plan (the sequence — what to build first, what depends on what), and implementation details (the decisions within each part — which patterns to follow, how to handle errors, what the consumer actually needs).

AI tends to collapse all three into a single generation pass. The protocol separates them into multiple passes at increasing resolution. Each pass covers the whole piece at its current resolution before any part moves to the next level of detail.

The protocol does not prescribe how many passes, what to look at in each pass, or what format to use. Those emerge from the work itself — the stone, the vision, what reveals itself. What the protocol enforces is the discipline: work from coarse to fine. Check coherence of the whole before detailing the parts. Don't jump resolution.

---

## Part 4: What We Know Works

These are observations from experience, not prescriptions. They describe practices that produce better results when applied within the coarse-to-fine refinement process.

**Evidence over assumption.** When checking whether a pattern exists, whether code behaves a certain way, or whether a design decision holds — read the actual code. Search results show where to look, not what's there. Claims without evidence are the AI's overconfidence at work.

**Tracing over fragment-checking.** Don't evaluate code in isolation. Follow data from where it's produced to where it's consumed. Follow config from where it's loaded to where it's used. When reviewing an output, ask what the consumer actually needs. Most design-level issues are invisible at the fragment level and obvious when you trace the flow.

**Investigation before implementation.** Decisions made during active code generation are ad-hoc — driven by what's in context at that token position, not by deliberate comparison with the existing codebase. Moving decisions into a prior investigation pass — where the AI reads reference implementations and documents which patterns to follow — produces more coherent results.

**Writing things down forces diligence.** When the AI is required to list what it found, it looks more carefully than when it's allowed to summarize or move on. The act of recording creates accountability. The format matters less than the requirement to record.

**Existing code is the authority.** When building into an existing codebase, the codebase's patterns are the standard — not the AI's training data, not general best practices. Read the closest existing equivalent before writing a new component. Match its conventions.

---

## Part 5: Open Questions

These are the design space to explore. No premature decisions.

- How should the refinement passes be structured? Fixed phases, or emergent from the work?
- What level of accountability (recording findings, decisions, rationale) balances diligence against overhead?
- Should the loop be interactive with the user, automated (e.g., via subagents reviewing each other's work), or a combination?
- How should reference knowledge (common blind spots, minimum quality checks) be made available without narrowing the AI's attention?
- How does the protocol adapt to different task types — a code audit needs different passes than a greenfield implementation?
- What signals indicate that a pass is complete and the next resolution level is appropriate?
- How to prevent the protocol itself from becoming the kind of rigid structure it aims to replace?
