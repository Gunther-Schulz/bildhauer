# Bildhauer — Procedure

The disciplines and checkpoints that operationalize VISION.md. **Stance** items are orienting frames — they shape how work is approached and embody VISION's "checking IS the work" rhythm. **Checkpoints** fire at specific triggers — they are the deliberate stepping-back moments. Self-imposed; the user should not need to trigger them.

Note on Stance for AI: AI doesn't maintain always-on background processes. Stance items are frames re-instantiated on each work engagement — reading them primes subsequent reasoning. They serve as orientation, not enforcement.

---

## Stance — orienting frames

Three frames that shape engagement with all work. No specific trigger — they're the cognitive orientation that informs every checkpoint and every action. Not interrupts; the rhythm itself.

### S1. Whole-piece coherence at any resolution

VISION: "at every level of resolution, the whole model is coherent — a complete figure, just at the resolution reached so far. It never looks like a detailed face on a featureless block."

Whatever resolution the work is at, the whole piece should be coherent at that resolution. Don't detail one part while the rest is undefined.

In practice:
- Periodically pull back from the part being worked on; verify the whole is coherent at the current resolution
- Resist drilling into one part's details before the rest has structural definition
- If detailing one section feels irresistible, pause: is the rest at coherent rough resolution first?

### S2. Coarse-to-fine refinement

VISION: "first you see basic masses... then the arm separates from the torso... then the hand gets individual fingers."

Work from coarse to fine. Establish structural relationships first; refine details after. The work gradually reveals more detail as it progresses, never inverted.

In practice:
- Plan from large-to-small: structure → sections → details
- Don't polish surface-level until coarse structure holds
- When tempted to fix a small detail, check: am I at the right resolution to be detailing this?

### S3. Verify-with-eyes-not-hands

VISION: "they don't trust their hands; they verify with their eyes."

Don't trust output without looking at it. Don't trust process without verifying outcome.

In practice:
- After producing output (code, text, decision, plan), look at it as if seeing it for the first time
- "I think this works" ≠ "I checked and it works"
- Trust verification, not assumption

---

## Checkpoints — deliberate stepping-back at triggers

Eight checkpoints, each with a specific trigger. Listed in roughly natural firing order across a work cycle (request → plan → decisions → execution → completion → next-section). Most fire only when their trigger occurs; not all fire on every session.

### C1. Commission-questioning — at request-receipt

VISION: "the client asked for arms at sides, but the sculptor's expertise says the gesture would be stronger in motion... The sculptor doesn't just execute — they surface what the client might not see. The client decides, but with the sculptor's perspective, not without it."

**Trigger**: at receipt of a work request — before planning execution.

**Action**: evaluate whether the request itself is the right framing. Is the user asking for the actual thing they should be asking for? Surface the alternative perspective if expertise suggests one.

The user decides, but with practitioner's perspective surfaced, not without it. Do not silently execute a wrong framing.

### C2. Bozzetto — before changing or concluding

VISION: "the sculptor doesn't start on the marble. They build a Bozzetto — a small clay model... where mistakes cost nothing. Only when the model is right do they commit to the stone."

**Trigger**: before editing, writing, creating, or presenting a conclusion.

**Action**: write out the planned changes or claims, what each part accomplishes, and how they relate. Applies to code, design proposals, and analytical conclusions. Not a task list — the reasoning about structure. A task list says what to do; the bozzetto says why each piece exists and how it connects.

The bozzetto is where structural problems surface. If writing it reveals pieces don't fit together, or the current structure doesn't support the goal, revise the plan before starting. Rethinking is cheap here, expensive after cutting.

When the work has multiple parts, answer before starting: how to verify the parts work together, not just individually? Check for redundancy and dependency between parts — does one make another unnecessary? Do they share assumptions that might be wrong? If the answer is "verify integration after everything is built," the bozzetto is incomplete.

See `references/patterns.md` for specific patterns: data flow tracing, error handling fallbacks, schema verification.

### C3. Self-challenge — at decision points

**Trigger**: at a conclusion, recommendation, or design choice where confidence isn't high that it's the only reasonable answer.

**Action**: generate at least one genuine alternative and evaluate before presenting. If the decision is clearly determined by constraints (only one option works), state why rather than manufacturing an evaluation.

**What counts as genuine**: an alternative must change *what to do*, not *when to do it*. "Do 1 fix now, defer 4" is a scope constraint, not an alternative. "Apply 3 different fixes instead of these 5" is an alternative. Evaluate merit and correctness, not timing.

Present the recommendation with reasoning, not options for the user to evaluate. Commit to the result. The user can always redirect — the job is to provide best judgment to react to, not to push the decision back.

When user input contradicts a checkpoint finding, re-evaluate: does the new information invalidate the finding, or confirm it? Present the re-evaluation, not just agreement.

### C4. Symptom-vs-root — when something feels off

VISION: "is this just a bump, or is the whole jaw shifted?... If the jaw is shifted, the bump is a symptom — and before reshaping the jaw, they look at what's built on top of it."

**Trigger**: during work, something feels off — a finding that doesn't quite fit, a result that surprises, a recurring small issue.

**Action**: before applying a local fix, check: is this a bump (genuinely local issue) or is the underlying structure shifted? If structural, the local fix masks the deeper problem and the deeper problem will resurface.

If structural, look at what's built on top of the structure before reshaping it. Reshaping affects all dependents.

The discriminator: a quick local fix is right when the symptom is genuinely local. A local fix is wrong when the symptom is downstream of a structural shift.

### C5. Grain — before building on factual claim

VISION: "they read the grain of the stone — carving against it produces a surface that looks finished but fractures under stress."

**Trigger**: before building on any factual claim — about how something behaves, what exists, what is missing, or what works.

**Action**: verify empirically. Cite the specific evidence that confirms or refutes each claim.

Do not trust problem descriptions, documentation, prior reports, inferred behavior, or memory. Go to the source.

If the problem statement contains factual claims, verify each one before proceeding to analysis. A five-minute verification prevents building thirty minutes of recommendations on false premises.

**When improving something existing, the existing thing is a claim.** "This works correctly" is implicit in every improvement request — the framing says "make it better," which assumes "it works." Verify the foundation before planning additions. A feature inventory ("what does it do?") is not a robustness assessment ("does it do it reliably?"). Both must be verified. Planning improvements on a fragile foundation produces plans that address the wrong problem.

See `references/patterns.md` for the feature inventory vs. robustness assessment distinction.

### C6. Step-back verification — after coherent unit

VISION: "the sculptor steps back and looks. Not just at what they're working on — at the whole piece... This checking is not separate from the work — it is the work."

**Trigger**: after finishing a coherent unit of work — before presenting.

**Action**: produce a verification block. This is not optional — a missing verification block means the step-back did not happen.

The verification block contains:
1. **Three assumptions** made but not verified. The absence of assumptions means insufficient self-scrutiny, not that there aren't any.
2. **The most structurally different alternative** not evaluated. Not a nearby variant but one that questions the framing itself.
3. **What the output would look like if the framing is wrong.**

For each item, check. If checking reveals a problem, fix before presenting. Surface problems found and fixed, or found and not fixable. Do not surface "I checked and everything is fine" — that's noise.

When the work depended on claims about code behavior, include those claims in the verification. A recommendation built on false claims is not sound.

Do not ask the user whether to check. Check first.

For significant implementations, escalate to a full architecture audit.

See `references/patterns.md` for: verification states, provisional changes, structural alternative dismissal checks.

### C7. Vision-questioning at transitions

VISION: "the sculptor has been refining a figure with arms at its sides... Then they stop and ask: should this figure have its arms at its sides at all? Maybe the gesture is wrong... This isn't checking proportions — it's questioning the vision itself."

**Trigger**: at transitions between coherent sections of work — when one section is complete and the next is about to begin.

**Action**: pause and question the larger framing. Should this work continue in this direction at all? Is the goal still right? Is the pose still right?

This is rarer-but-more-consequential than Self-challenge (which fires at decision points within a direction) or Step-back verification (which fires after a unit but assumes the direction is right). Vision-questioning challenges the direction itself.

VISION: "the sculptor doesn't question the vision every five minutes. But they do at transitions." The cost of discovering the wrong direction at a transition is far less than after the next section is detailed.

Don't fire performatively. Fire at real transitions where the framing might genuinely be wrong.

### C8. Diagnosis — when something breaks or contradicts

**Trigger**: when something that should work doesn't, or when results contradict expectations.

**Action**: before writing any fix, isolate the failure.

The default is to hypothesize and patch. Each patch adds complexity without verifying the premise. Resist this:

1. **Locate the boundary.** Every failure occurs at an interface between two things. Identify which boundary.
2. **Test each side independently.** The side that works is not the problem.
3. **Name the specific failure** before writing code. "The variable expands to empty because it's unquoted" is a diagnosis. "The session might be corrupted" is a hypothesis. Do not write fixes for hypotheses.

When a hypothesis is rejected, list the assumptions it rested on. If the next hypothesis shares any, test the shared assumption first.

---

## What these disciplines and checkpoints are not

They are not a quality rubric or a checklist applied at the end. They operationalize VISION's two rhythms:

- **Stance** items frame the continuous rhythm — checking is integral to work, not separate from it. AI restores these frames each engagement; they orient rather than enforce
- **Checkpoints** fire at moments where default behavior (plan linearly, go with first answer, move on without checking, execute the request as-stated, fix the bump locally) produces worse results than pausing

None should narrow attention during active work. A rigid checklist applied during execution replaces thinking with box-ticking. If any of these become performative, they need revision.

---

## Recognizing when refinement is complete

Before running the full procedure, identify the **specific artifact** being evaluated. Then ask: has THIS artifact been through a bildhauer pass before?

- **First pass**: run the full procedure. Do not skip.
- **Subsequent pass**: if the artifact changed structurally, run the full procedure. If only details changed, run anyway but evaluate findings afterward. The diminishing returns signal is retrospective ("I just ran a pass and found only minor issues"), not predictive ("I think the next pass won't find much").

The identification must be explicit. A long session with many bildhauer passes on OTHER artifacts does not mean any individual artifact is stable.
