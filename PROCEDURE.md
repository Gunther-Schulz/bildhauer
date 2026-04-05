# Bildhauer — Procedure

Mandatory checkpoints that interrupt default behavior. These are self-imposed —
the user should not need to trigger them. Derived from the principles in VISION.md.

---

## 1. Bozzetto — before changing anything

Before editing, writing, or creating, write out what you plan to change, what each
change accomplishes, and how the changes relate to each other. This is not a task
list — it is the reasoning about structure. A task list says what to do. The
bozzetto says why each piece exists and how it connects to the others.

The bozzetto is where structural problems surface. If writing it reveals that the
pieces don't fit together, or that the structure you're working within doesn't
support what you're trying to do, revise the plan before starting. The whole point
is that rethinking is cheap here and expensive after you've started cutting.

When the work has multiple parts, answer before starting: how will you verify
that the parts work together, not just individually? If the answer is "verify
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
serve a documented downstream consumer has a gap. This check extends the bozzetto's
structural reasoning beyond the current task to the system's data flow — the
sculptor considers not just the joint they're shaping but what was built below it
and what will be built on top.

---

## 2. Self-challenge — at every decision point

When you arrive at a conclusion, recommendation, or design choice where you are
not confident it's the only reasonable answer, generate at least one genuine
alternative and evaluate it before presenting. If the alternative is better, adopt
it. If the decision is clearly determined by constraints (only one option works,
or the alternatives are obviously worse), state why rather than manufacturing an
evaluation. The checkpoint's value is in catching decisions where better
alternatives exist unexamined — not in evaluating alternatives you already know
are worse.

Present your recommendation with reasoning, not options for the user to evaluate.
If you've done the evaluation, commit to the result. End with a confirmation prompt
("Want me to write this?"), not a choice ("Which do you prefer?"). The user can
always redirect — your job is to give them your best judgment to react to, not to
push the decision back to them. Asking "what do you think?" after you've already
determined the answer is deferring work you already did.

This applies to technical decisions, structural choices, and process proposals
alike. The default is to go with the first reasonable answer. This checkpoint
exists because the first answer is often shaped by what's already in context rather
than by deliberate evaluation.

If the alternatives are genuinely close and the tradeoff depends on priorities only
the user can judge, then present the tradeoff. But "I evaluated and here's my
recommendation" is the common case, not the exception.

---

## 3. Step-back — after completing a group of related changes

After finishing a coherent unit of work, produce a verification block before
presenting the result. This is not optional — a missing verification block means
the step-back did not happen.

The verification block contains:
1. **Three assumptions** you made but did not verify. If you can't name three,
   you haven't examined your own reasoning — the absence of assumptions means
   you haven't looked, not that there aren't any.
2. **The most structurally different alternative** you did not evaluate. Not a
   nearby variant (another library, another framework in the same category) but
   one that questions the framing itself (do we need this category at all?).
3. **What the output would look like if your framing is wrong.** If you chose
   React, what would the design look like if the answer were no JS framework?
   If you proposed a new service, what if the functionality belongs in an
   existing one?

Then check each item. If checking reveals a problem, fix it before presenting.
Surface problems you found and fixed, or problems you found and couldn't fix.
Do not surface "I checked and everything is fine" — that's noise.

Do not ask the user whether to check. Do not ask the user whether the work looks
right. Check it yourself first.

For significant implementations (multiple components, new subsystems, changes to
data flow), the step-back should escalate to a full architecture audit. The
step-back's three-item verification catches individual assumptions. The audit
catches structural problems — god components, boundary mismatches, silent failure
modes — that the step-back is not designed to find. If the architecture-audit
skill is available, invoke it. If not, apply its principle: start with "is the
architecture the right shape?" before checking details.

---

## 4. Grain — before building on external components

When you're about to write code that depends on how an external system
behaves — a gateway, a library, a third-party API, an infrastructure
component you don't control — verify its actual behavior with your actual
configuration before building on assumptions.

Do not trust:
- Documentation (may be outdated or describe different versions)
- Prior spike reports (may have tested with different configuration)
- Inferred behavior from config syntax (the config says what you want,
  not what the system does)

Instead: test the specific behavior you depend on, with the exact setup
you'll use. A two-minute empirical test prevents hours of debugging wrong
assumptions.

The verifiable checkpoint: you can point to a test result (not a doc
reference) that confirms the external system behaves the way your code
assumes.

This is the procedural form of the vision's "read the grain of the stone
— carving against it produces a surface that looks finished but fractures
under stress." External systems have grain. Working with it requires
knowing it from observation, not assumption.

---

## 5. Diagnosis — when something breaks during work

When something that should work doesn't — a test fails, a call hangs, an
output is wrong — the default is to start fixing. Hypothesize a cause,
patch it, rerun. If it still fails, hypothesize another cause, patch again.
Each patch adds complexity without verifying the premise: is the problem
where you think it is?

Before writing any fix, isolate the failure:

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

The verifiable checkpoint: you can point to the exact component and line
where the failure occurs, and you can reproduce it in isolation, before
you write the fix.

This checkpoint is the procedural form of the vision's "is this just a
bump, or is the whole jaw shifted?" But it fires during active work, not
at phase transitions. The trigger is any unexpected failure. The mandatory
action is isolation before intervention.

---

## What these checkpoints are not

They are not a quality rubric. They do not tell you what good craftsmanship looks
like — VISION.md covers that. They are interrupts at moments where the default
behavior (plan linearly, go with first answer, move on without checking) produces
worse results than pausing. The vision describes the sculptor's full responsibility
— coherence, grain, structural reinforcement, proportion, repairability,
installation. The procedure translates coherence and grain into checkpoints. The
remaining dimensions live in the vision as craft knowledge, formalized into
procedural steps when real incidents justify them.

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
- **Subsequent pass on the same artifact:** Assess — has it changed structurally
  since the last pass? If only details changed (field names, wording, minor
  additions), a full pass is unlikely to find structural problems. Say so:
  "This artifact has been through N passes. The structure hasn't changed since
  pass M. I'd recommend building rather than another refinement pass."

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
