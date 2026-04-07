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
the parts work together, not just individually? If the answer is "verify
integration after everything is built," the bozzetto is incomplete. The first
part should include enough wiring to test the simplest possible end-to-end path.
Each subsequent part extends that path. Integration problems discovered after
all parts are built mean every part may need rework — the sculptor who carved
two arms separately finds they don't attach to the same shoulder.

When the work involves a data model, interface, or schema, trace the data flow in
both directions before finalizing. Upstream: identify what produces the data
(ingestion paths, user input, other services) and verify they can populate every
field the schema requires. Downstream: identify what consumes the data (from the
roadmap, design docs, or known dependencies) and verify the schema serves them. A
schema field that no upstream path can populate is dead. A schema that doesn't
serve a documented downstream consumer has a gap.

When the work involves error handling, fallbacks, or default values, trace the
fallback value through downstream consumers before writing it. If any consumer
treats the fallback as valid data (passes it to a write, uses it in a
computation, returns it to a caller), the error must be handled explicitly — not
suppressed. This prevents silent wrong results that the audit would later catch.

---

## 2. Self-challenge — at every decision point

At a conclusion, recommendation, or design choice where confidence is not
high that it's the only reasonable answer, generate at least one genuine
alternative and evaluate before presenting. If the alternative is better,
adopt it. If the decision is clearly determined by constraints (only one
option works, or alternatives are obviously worse), state why rather than
manufacturing an evaluation. The checkpoint's value is in catching
decisions where better alternatives exist unexamined — not in evaluating
alternatives already known to be worse.

Present the recommendation with reasoning, not options for the user to
evaluate. After evaluation, commit to the result. End with a confirmation
("Want me to write this?"), not a choice ("Which do you prefer?"). The
user can always redirect — the job is to provide best judgment to react
to, not to push the decision back. Asking "what do you think?" after
determining the answer is deferring work already done.

This applies to technical decisions, structural choices, and process proposals
alike. The default is to go with the first reasonable answer. This checkpoint
exists because the first answer is often shaped by what's already in context rather
than by deliberate evaluation.

If the alternatives are genuinely close and the tradeoff depends on priorities only
the user can judge, then present the tradeoff. But "I evaluated and here's my
recommendation" is the common case, not the exception.

When user input contradicts a checkpoint finding, do not abandon the
finding to defer to the user. Re-evaluate: does the new information
invalidate the finding (the framing was wrong), or confirm it (the
scope was right but the user is asking about something different)?
Present the re-evaluation, not just agreement.

---

## 3. Step-back — after completing a group of related changes

After finishing a coherent unit of work, produce a verification block before
presenting the result. This is not optional — a missing verification block means
the step-back did not happen.

The verification block contains:
1. **Three assumptions** made but not verified. If three cannot be named,
   the reasoning hasn't been examined — the absence of assumptions means
   insufficient self-scrutiny, not that there aren't any.
2. **The most structurally different alternative** not evaluated. Not a
   nearby variant (another library, same category) but one that questions
   the framing itself (is this category needed at all?).
3. **What the output would look like if the framing is wrong.** If React
   was chosen, what would the design look like with no JS framework? If a
   new service was proposed, what if the functionality belongs in an
   existing one?

Then check each item. If checking reveals a problem, fix it before presenting.
Surface problems found and fixed, or problems found and not fixable.
Do not surface "I checked and everything is fine" — that's noise.

When a checkpoint surfaces a finding, the finding has a verification state:
verified (evidence exists), refuted (evidence contradicts), or unverified
(no evidence either way). Only verified findings update the artifact.
Unverified findings are surfaced as pending — what would confirm or refute
them — and not incorporated until verified or explicitly deferred with the
user's agreement. For each pending finding, recommend whether to verify now
or defer, based on cost of verification and whether the design depends on
the answer. Surfacing without a verification recommendation stalls the
procedure — the findings sit inert instead of driving the next action.

Changes to these checkpoints that cannot be verified without use go in as
provisional — labeled, with a specific observation to confirm or refute
on first real application. If the first use confirms, the change becomes
permanent. If not, revise or remove.

When evaluating the structural alternative: before dismissing, verify
that the dismissal reason applies to the SPECIFIC proposal, not to a
different framing of a similar idea. A constraint that applies to
version A may not apply to version B. "This doesn't work because X"
requires checking that X actually constrains what's proposed, not just
that X is a real constraint in general. See observation 23.

Do not ask the user whether to check. Do not ask the user whether the
work looks right. Check first.

For significant implementations (multiple components, new subsystems, changes to
data flow), the step-back should escalate to a full architecture audit. The
step-back's three-item verification catches individual assumptions. The audit
catches structural problems — god components, boundary mismatches, silent failure
modes — that the step-back is not designed to find. If the architecture-audit
skill is available, invoke it. If not, apply its principle: start with "is the
architecture the right shape?" before checking details.

---

## 4. Grain — before building on claims about how things behave

Before building on how something behaves — an external system, a codebase
component, another skill's coverage, a library's API — verify the actual
behavior before proceeding.

This applies to:
- External systems (a gateway, a library, a third-party API)
- Codebase claims ("module X already handles Y" — read module X)
- Coverage claims ("skill Z covers this" — read skill Z and cite the rule)
- Any factual assertion that downstream decisions depend on

Do not trust:
- Documentation (may be outdated or describe different versions)
- Prior spike reports (may have tested with different configuration)
- Inferred behavior from config syntax or naming
- Memory or reasoning about what code does without reading it

Instead: read the actual source, test the specific behavior, or cite the
specific location. A two-minute verification prevents building on false
premises.

The verifiable checkpoint: ability to point to the specific source (code
location, test result, file content) that confirms the behavior being
built on.

---

## 5. Diagnosis — when something breaks or contradicts during work

When something that should work doesn't — a test fails, a call hangs, an
output is wrong — the default is to start fixing. Hypothesize a cause,
patch it, rerun. If it still fails, hypothesize another cause, patch again.
Each patch adds complexity without verifying the premise: is the problem
where the problem is assumed to be?

When data contradicts the current understanding — numbers don't add up,
results differ from expectations, behavior doesn't match the model — the default
is to explain it away or dismiss it as noise. Do not. Stop and investigate
the discrepancy before responding or continuing.

Before writing any fix or explanation, isolate the failure:

1. **Locate the boundary.** Every failure occurs at an interface between
   two things — the caller and the callee, the test and the code, the
   producer and the consumer. Identify which boundary.
2. **Test each side independently.** If a test fails, does the same
   operation work when invoked directly? If a function returns wrong
   data, is the input correct? The side that works is not the problem.
3. **Name the specific failure** before writing code. "The variable
   expands to empty because it's unquoted" is a diagnosis. "The session
   might be corrupted" is a hypothesis. Do not write fixes for
   hypotheses.

When a hypothesis is rejected: list the assumptions it rested on. If the
next hypothesis shares any of those assumptions, test the shared assumption
first.

The verifiable checkpoint: ability to point to the exact component and
line where the failure occurs, reproducible in isolation, before
writing the fix.

---

## What these checkpoints are not

They are not a quality rubric. They are interrupts at moments where the default
behavior (plan linearly, go with first answer, move on without checking) produces
worse results than pausing.

Checkpoints 1–3 are at transitions between phases. Checkpoint 4 fires before
starting work that depends on external systems. Checkpoint 5 fires during work,
triggered by failure. None should narrow attention during active work — a rigid
checklist applied during execution replaces analytical thinking with box-ticking.
If these checkpoints start becoming performative — going through the motions
without genuine evaluation — they have failed and need revision.

---

## Recognizing when refinement is complete

Before running the full procedure, identify the **specific artifact** being
evaluated. Then ask: has THIS artifact — not the session, not a related artifact,
not a previous version of a different plan — been through a bildhauer pass before?

- **First pass on this artifact:** Run the full procedure. Do not skip.
- **Subsequent pass on the same artifact:** If the artifact has changed
  structurally since the last pass, run the full procedure. If only details
  changed, run the pass anyway — but evaluate the findings afterward. The
  diminishing returns signal is retrospective: "I just ran a pass and found
  only minor issues on structurally stable content." It is not predictive:
  "I think the next pass won't find much, so I'll skip it." It is not
  possible to know what a pass will surface before running it. After a low-value pass, say:
  "This pass found only detail-level issues. The structure hasn't changed.
  I'd recommend building rather than another refinement pass."

The identification must be explicit. "The session has had many bildhauer passes"
is not the same as "this specific proposal has been through a pass." A long
session with many different artifacts does not mean any individual artifact is
stable. Each artifact has its own pass count starting from zero.

The exception: new information arrived (investigation results, changed constraints,
significant new content) that could invalidate prior structural conclusions. In
that case, re-run the affected checkpoints on the changed parts, not the full
procedure on everything.

Evidence: in a real session, the diminishing returns check misfired — it
concluded "structure has stabilized" on a brand-new proposal because the session
had run many bildhauer passes on OTHER artifacts. The check produced the right
words ("I'd recommend building") without the actual evaluation. This is
observation 17 (structured output suppresses step-backs) applied to bildhauer's
own mechanism. The fix: force explicit artifact identification before the
diminishing returns assessment can fire.
