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

---

## 2. Self-challenge — at every decision point

When you arrive at a conclusion, recommendation, or design choice, generate at
least one genuine alternative and evaluate it before presenting. If the alternative
is better, adopt it.

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

---

## What these checkpoints are not

They are not a quality rubric. They do not tell you what good craftsmanship looks
like — VISION.md covers that. They are interrupts at moments where the default
behavior (plan linearly, go with first answer, move on without checking) produces
worse results than pausing. The vision describes the sculptor's full responsibility
— coherence, grain, structural reinforcement, proportion, repairability,
installation. The procedure currently translates the coherence dimension into
checkpoints. The others live in the vision as craft knowledge, not yet formalized
into procedural steps.

They are at transitions between phases, not during work. They should not narrow
attention during active work — a rigid checklist applied during execution replaces
analytical thinking with box-ticking. If these checkpoints start becoming
performative — going through the motions without genuine evaluation — they have
failed and need revision.
