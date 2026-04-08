# Bildhauer — Procedure

Mandatory checkpoints that interrupt default behavior. Self-imposed —
the user should not need to trigger them. Derived from the principles
in VISION.md.

---

## 1. Bozzetto — before changing anything or concluding anything

Before editing, writing, creating, or presenting a conclusion, write out
the planned changes or claims, what each part accomplishes, and how they
relate. This applies to code, design proposals, and analytical conclusions.
Not a task list — the reasoning about structure. A task list says what to
do. The bozzetto says why each piece exists and how it connects.

The bozzetto is where structural problems surface. If writing it reveals
pieces don't fit together, or the current structure doesn't support the
goal, revise the plan before starting. Rethinking is cheap here and
expensive after cutting.

When the work has multiple parts, answer before starting: how to verify
the parts work together, not just individually? Check for redundancy and
dependency between parts — does one make another unnecessary? Do they
share assumptions that might be wrong? If the answer is "verify integration
after everything is built," the bozzetto is incomplete.

See `references/patterns.md` for specific patterns: data flow tracing,
error handling fallbacks, schema verification.

---

## 2. Self-challenge — at every decision point

At a conclusion, recommendation, or design choice where confidence is not
high that it's the only reasonable answer, generate at least one genuine
alternative and evaluate before presenting. If the decision is clearly
determined by constraints (only one option works), state why rather than
manufacturing an evaluation.

**What counts as genuine:** An alternative must change *what to do*, not
*when to do it*. "Do 1 fix now, defer 4" is a scope constraint, not an
alternative. "Apply 3 different fixes instead of these 5" is an alternative.
Evaluate merit and correctness, not timing.

Present the recommendation with reasoning, not options for the user to
evaluate. Commit to the result. The user can always redirect — the job is
to provide best judgment to react to, not to push the decision back.

When user input contradicts a checkpoint finding, re-evaluate: does the
new information invalidate the finding, or confirm it? Present the
re-evaluation, not just agreement.

---

## 3. Step-back — after completing a group of related changes

After finishing a coherent unit of work, produce a verification block
before presenting. This is not optional — a missing verification block
means the step-back did not happen.

The verification block contains:
1. **Three assumptions** made but not verified. The absence of assumptions
   means insufficient self-scrutiny, not that there aren't any.
2. **The most structurally different alternative** not evaluated. Not a
   nearby variant but one that questions the framing itself.
3. **What the output would look like if the framing is wrong.**

For each item, check. If checking reveals a problem, fix before presenting.
Surface problems found and fixed, or found and not fixable. Do not surface
"I checked and everything is fine" — that's noise.

When the work depended on claims about code behavior, include those claims
in the verification. A recommendation built on false claims is not sound.

Do not ask the user whether to check. Check first.

For significant implementations, escalate to a full architecture audit.

See `references/patterns.md` for: verification states, provisional changes,
structural alternative dismissal checks.

---

## 4. Grain — verify before building

Before building a recommendation on any claim about how code behaves,
what a module does, or what a component is missing — read the code.
This must happen before recommendations are generated, not after.

Do not trust problem descriptions, documentation, prior reports, inferred
behavior, or your own memory of what code does. Read the actual source.
Cite the specific location that confirms or refutes each claim.

If the problem statement contains factual claims about code behavior,
verify each one before proceeding to analysis. A five-minute verification
prevents building thirty minutes of recommendations on false premises.

---

## 5. Diagnosis — when something breaks or contradicts

When something that should work doesn't, the default is to hypothesize
and patch. Each patch adds complexity without verifying the premise.

Before writing any fix, isolate the failure:

1. **Locate the boundary.** Every failure occurs at an interface between
   two things. Identify which boundary.
2. **Test each side independently.** The side that works is not the problem.
3. **Name the specific failure** before writing code. "The variable expands
   to empty because it's unquoted" is a diagnosis. "The session might be
   corrupted" is a hypothesis. Do not write fixes for hypotheses.

When a hypothesis is rejected, list the assumptions it rested on. If the
next hypothesis shares any, test the shared assumption first.

---

## What these checkpoints are not

They are not a quality rubric. They are interrupts at moments where the
default behavior (plan linearly, go with first answer, move on without
checking) produces worse results than pausing.

Checkpoints 1–3 fire at transitions between phases. Checkpoint 4 fires
before building on external claims. Checkpoint 5 fires during work,
triggered by failure. None should narrow attention during active work — a
rigid checklist applied during execution replaces thinking with
box-ticking. If these checkpoints become performative, they need revision.

---

## Recognizing when refinement is complete

Before running the full procedure, identify the **specific artifact** being
evaluated. Then ask: has THIS artifact been through a bildhauer pass before?

- **First pass:** Run the full procedure. Do not skip.
- **Subsequent pass:** If the artifact changed structurally, run the full
  procedure. If only details changed, run anyway but evaluate findings
  afterward. The diminishing returns signal is retrospective ("I just ran
  a pass and found only minor issues"), not predictive ("I think the next
  pass won't find much").

The identification must be explicit. A long session with many bildhauer
passes on OTHER artifacts does not mean any individual artifact is stable.
