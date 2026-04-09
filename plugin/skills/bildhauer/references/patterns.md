# Patterns — Specialized Guidance

Specific patterns extracted from the procedure to keep the main checkpoints
lean. Load when the work matches a pattern below.

---

## Bozzetto patterns

### Data flow tracing

When the work involves a data model, interface, or schema, trace the data
flow in both directions before finalizing. Upstream: what produces the
data and can it populate every field? Downstream: what consumes the data
and does the schema serve it? A field no upstream can populate is dead.
A schema that doesn't serve a documented consumer has a gap.

### Error handling and fallbacks

When the work involves error handling, fallbacks, or default values, trace
the fallback value through downstream consumers. If any consumer treats
the fallback as valid data (passes it to a write, uses it in a computation,
returns it to a caller), the error must be handled explicitly — not
suppressed.

### Integration verification

The first part should include enough wiring to test the simplest possible
end-to-end path. Each subsequent part extends that path. Integration
problems discovered after all parts are built mean every part may need
rework — the sculptor who carved two arms separately finds they don't
attach to the same shoulder.

---

## Step-back patterns

### Verification states

When a checkpoint surfaces a finding, it has a verification state:
verified (evidence exists), refuted (evidence contradicts), or unverified
(no evidence either way). Only verified findings update the artifact.
Unverified findings are surfaced as pending — what would confirm or refute
them. For each pending finding, recommend whether to verify now or defer,
based on cost and whether the design depends on the answer.

### Provisional changes

Changes to checkpoints that cannot be verified without use go in as
provisional — labeled, with a specific observation to confirm or refute
on first real application. If the first use confirms, the change becomes
permanent. If not, revise or remove.

### Structural alternative dismissal

Before dismissing an alternative, verify that the dismissal reason applies
to the SPECIFIC proposal, not to a different framing of a similar idea.
A constraint that applies to version A may not apply to version B. "This
doesn't work because X" requires checking that X actually constrains
what's proposed. See observation 23.

---

## Grain patterns

### Feature inventory vs. robustness assessment

A feature inventory answers "what does this do?" — it maps capabilities,
data flows, and structure. A robustness assessment answers "does this
work reliably?" — it checks failure modes, edge cases, and integrity
under adverse conditions (interrupts, partial failures, invalid input,
concurrent access).

When the task is to improve something existing, both are needed. The
feature inventory tells you what to build on. The robustness assessment
tells you whether it can bear the weight. An exploration that returns
a feature inventory looks thorough — it answered many questions — but
it answered the wrong question if the foundation is fragile.

The distinction applies beyond code: a process description ("here's how
onboarding works") is not a process assessment ("does onboarding
actually work when two people start on the same day?"). A design summary
("the schema has these fields") is not a design evaluation ("can any
upstream path actually populate this field?").

---

## Self-challenge patterns

### Framing vs. choice

Before comparing options, state what all options have in common and ask
whether that shared assumption is necessary. The structural alternative
isn't in the comparison table — the column headers may be wrong. See
ROADMAP → self-challenge depth.
