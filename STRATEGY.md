# Bildhauer — Strategy

## Part 1: The Analogy

A Bildhauer starts with a rough block of stone and a vision. Not a blueprint — the final form can't be fully known before the work begins. The material reveals constraints as it's shaped.

The sculptor works from coarse to fine. First, large chunks come off — establishing proportions, the basic masses, where the limbs are relative to the torso. At this stage, no detail. Just the big shape. The sculptor steps back frequently to check the whole piece: are the proportions right? Does the gesture make sense?

Then the medium work. Each section gets structure — the arm gets an elbow, the face gets a nose. But still, the sculptor checks the whole: does the elbow match the shoulder? Does the nose fit the face? Nothing is detailed in isolation. Every part is shaped in relation to every other part.

Then the fine work. Surface texture, fingernails, the curve of an eyelid. These details only make sense because the proportions and structure are already right.

At every stage, the sculptor steps back and looks. Not just at what they're working on — at the whole piece. They don't trust their hands; they verify with their eyes. They look from multiple angles. They measure and compare. This checking is not separate from the work — it is the work. Chisel, step back, look. Chisel, step back, look.

Sometimes during fine work, something feels off. A bump on the cheekbone. The sculptor could sand it down — a quick local fix. But instead they step back. The whole jaw is shifted. The bump is a symptom, not the problem. The right move is to go back to a coarser resolution and re-cut the jaw before continuing any detail on the face. This costs time — detail work already done on that area may need reworking. But it's less costly than building more detail on wrong proportions, where every addition inherits and amplifies the error.

How does the sculptor know whether to sand the bump or re-cut the jaw? They check. They step back, compare both sides, look at the whole face. Sometimes the bump is just a bump. Sometimes it reveals a proportion problem underneath. The sculptor doesn't assume either way — they look at the actual stone and decide based on what they see.

At every stage, the whole piece is coherent. There are no sudden spikes or crevices that don't belong. No random detail where the surrounding area is still rough. The sculptor never jumps resolution — never carves fingernails while the arm is still a block.

If you tried to do it all at once — shape the block, define the structure, and polish the surface in a single pass — you'd get a mess. Fragments that are individually reasonable but don't relate to each other. The shoulders slightly uneven, and every detail built on them inherits the error. The further you go before catching it, the more work you lose when you finally have to go back.

---

## Part 2: The Problem

AI generates code in a single pass. When asked to build a component, it produces the entire file from top to bottom — struct layout, error handling, logging conventions, shutdown method, edge cases — all decided simultaneously. There is no "first I established the architecture, then I filled in the details." Every decision at every level of resolution is made at once.

This is structurally equivalent to the sculptor trying to produce a finished statue in a single pass from the raw stone. The result works — it compiles, it runs — but it lacks coherence across parts. Each fragment is reasonable in isolation. Together, they don't hold together as a whole.

The severity depends on what resolution the mistakes were made at.

If the coarse pass was skipped entirely — no investigation of the existing codebase, no deliberate architecture — the head may be too big for the body. Component boundaries in the wrong place, data flowing the wrong direction, the whole integration approach unworkable. No amount of detail work fixes that. The stone needs to go back to a block. In code, that's a redesign.

If the coarse shape is right but the medium pass was skipped — proportions are sound but internal structure wasn't checked for coherence. The shoulders are slightly uneven. One component uses one logging convention, its sibling uses another. One service shuts down gracefully, the other kills connections. Config values loaded but never wired through. Each issue is small. Together they make the whole thing feel wrong. In code, that's a significant refactor.

If coarse and medium were done properly and only the fine pass was single-shot — the issues are genuinely small. A nil check here, a log format there. Those are local fixes.

The deeper the resolution at which mistakes were made, the more costly they are to fix — and the more work has been built on top of them. Post-hoc fixing finds the problems but fights the existing shape. The ad-hoc decisions are baked into the structure. Patching one decision disturbs its neighbors. Multiple audit rounds surface more issues each time — not because the auditor gets better, but because each fix reveals new incoherence underneath. It's the sculptor sanding bumps on a shifted jaw — each bump is "fixed" but the face never looks right, because the problem is one resolution level deeper.

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
