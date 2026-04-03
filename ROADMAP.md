# Bildhauer — Roadmap

Concrete work items for improving the framework. Each item is grounded in observed failures, not theory.

---

## The checkpoint reliability problem

**The core issue:** The procedure defines checkpoints that should interrupt default behavior, but they don't reliably interrupt. They fire when the moment is obvious (start of work → bozzetto) and fail when the moment is subtle (output feels complete → step-back should fire but doesn't). The procedure is text read once and then gradually lost to the momentum of generation.

This is not a wording problem. The AI knows it should step back. But the "I'm done" signal from producing structured output overrides the procedural instruction. The procedure competes with generation momentum, and momentum wins.

**Why it matters:** In a real adherence audit (observation 17), the step-back checkpoint scored 0/10 — it didn't fire at all. The three most valuable corrections in the design phase (a missed structural alternative, a deployment model contradiction, a service duplication) were all found only because the user manually triggered a second pass. The procedure's most important checkpoint is its least reliable.

**Root cause:** The checkpoints are read once (when PROCEDURE.md loads) and must survive as behavioral constraints across the entire conversation. The AI's attention is driven by what's immediately in context. By the time a structured output is complete, the step-back instruction is competing with the detailed analysis just produced — and losing.

This is fundamentally different from how a sculptor steps back. The sculptor's step-back is a physical action — they walk away from the work and look from a distance. The physical movement interrupts the flow. The AI "steps back" by generating more text in the same stream, which is the opposite of interrupting.

### What's been done

**Structural forcing (implemented)** — The step-back checkpoint in PROCEDURE.md now requires a verification block artifact (three unchecked assumptions, the most structurally different alternative not evaluated, what the output looks like if the framing is wrong). A missing verification block is visible; a skipped step-back is not. This converts the behavioral instruction into a structural requirement.

### Still to explore

**Adversarial pass** — After producing design or implementation output, a separate agent (subagent) reviews it with the explicit mandate to find problems. The review is structural — it happens because the process requires it, not because the AI judges it should. This mirrors real creative practice: sculptors have other sculptors critique their bozzetti. Connects to STRATEGY.md open question: "Should the loop be interactive with the user, automated (e.g., via subagents reviewing each other's work), or a combination?"

**External triggers (scaffolding)** — Hooks or tools that fire after specific events (large output generated, design phase completing). The interrupt comes from outside, not from the AI deciding to interrupt itself. Mechanical — doesn't improve craft, but useful as scaffolding while the adversarial pass matures.

---

## Self-challenge depth

**The problem:** Self-challenge generates *nearby* alternatives (another JS framework) rather than *structural* alternatives (do we need a JS framework at all?). A table comparing React vs. Svelte feels thorough, but the real alternative isn't in the table — the column headers are already wrong.

**Observed in:** Management UI design transition gate (observation 17). The self-challenge fired but was shallow. The structural alternative (HTMX + Go templates, leading to the embed.FS approach) was only found on a user-prompted second pass.

**To explore:** Can the self-challenge be made to generate at least one alternative that questions the framing, not just the choice within the framing? E.g., "before comparing options, state what all options have in common and ask whether that shared assumption is necessary."
