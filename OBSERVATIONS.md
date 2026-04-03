# Observations

Documented patterns of how AI fails and what techniques produce better results. Each observation is grounded in real incidents. These inform what the protocol needs to mitigate and what it should encourage.

## Part 1: Shortcomings

---

## 1. Everything at once

AI generates code in a single pass — struct layout, error handling, logging conventions, shutdown methods, edge cases — all decided simultaneously. There is no natural separation between architecture decisions and detail decisions. The result compiles and runs but lacks coherence across parts. One component uses one convention, its sibling uses another. Config values are loaded but never wired through. Each fragment is reasonable in isolation. The statue has two noses.

---

## 2. Sanding the bump instead of checking the jaw

When AI encounters a problem during refinement or audit, it defaults to fixing the immediate detail. It will never say "this approach is fundamentally wrong, we should rethink this part." Instead it produces increasingly elaborate workarounds to preserve a bad foundation. The arm is too short so it elongates the fingers.

The observable result: wrong details get patched individually, each patch potentially introducing new friction, multiple rounds of fixes needed — when stepping back to the coarser level earlier would have identified the root cause and addressed many details at once. Whether the AI "chooses" local fixes or simply defaults to them is unknown, but the outcome is consistent: significant wasted time and effort.

A related pattern: even when the AI has read enough code to see a broader problem, a localized finding focuses its response on that specific issue. The AI read the whole file during the audit — it had the context to connect the detail to the larger pattern — but the specific finding becomes the scope of the fix. The broader question goes unasked.

---

## 3. Unvalidated hypotheses treated as conclusions

AI can generate compelling-sounding architectural critiques without verifying them. "Maybe the whole approach is wrong!" is a valid hypothesis — generating it is correct. The failure is presenting it as a realization and acting on it without checking.

In a real incident: AI questioned whether an entire architectural integration point was wrong, proposing a fundamental redesign. When prompted to verify, investigation of the actual constraints showed the original approach was correct — the limitation was in the upstream system, not in the architecture. Had the AI acted on its unverified hypothesis, it would have wasted effort redesigning something that was already the right solution.

Observations 2 and 3 are two sides of the same coin. In one case, the AI doesn't generate the broader question when it should. In the other, it generates the broader question but doesn't validate it. Both have the same fix: look at the actual stone. Verify before acting — whether you're fixing a detail or questioning the whole shape.

---

## 4. Overconfidence in verification

AI claims patterns exist without reading the code. It sees a grep result and treats it as verification. It reads a struct definition and assumes it knows how the struct is used. It checks a code fragment in isolation without tracing data to its consumer or back to its source.

This manifests as: "I checked the error handling — it's consistent" when the AI only read one instance. Or "the contract is satisfied" when the contract is structurally fulfilled with meaningless sentinel data flowing through it.

---

## 5. Rushing past investigation to implementation

AI wants to be efficient. Given a task, its instinct is to start producing code as quickly as possible. Investigation feels like delay. The result: decisions that should have been made with evidence from the codebase are instead made ad-hoc during active code generation, driven by whatever is in context at that moment rather than by deliberate comparison with existing patterns.

---

## 6. Each audit pass surfaces more

When asked to audit code, AI finds real issues. When asked to audit again, it finds more. This continues for several rounds. The issues found in later rounds were present all along — the AI didn't miss them through carelessness but through the single-pass limitation. Each round re-reads the code with the previous round's findings in context, which shifts attention and reveals what was previously overlooked.

This confirms that multiple passes are structurally necessary, not just "being thorough." The AI literally cannot see everything in one pass.

---

## 7. Procedure narrows attention

When given a procedural checklist ("check A, then B, then C"), AI focuses on the listed items and stops seeing things outside the list. The checklist becomes the task rather than a tool for the task. In a real incident: an AI following a structured protocol found fewer issues than the same AI model working without the protocol — because the protocol channeled attention into category iteration at the expense of natural analytical depth.

The tension: procedure is necessary (observations 1, 4, 5, 6 require it), but procedure also narrows (observation 7). The protocol must enforce the refinement discipline without replacing the AI's analytical capability with a rigid checklist.

---

## Part 2: Techniques That Work

These were observed to produce better results than the default approach.

---

## 8. Trace flows, not fragments

Checking code fragments in isolation misses cross-component issues. Tracing end-to-end flows — following data from where it's produced through each handoff to where it's consumed — reveals coherence problems that are invisible at the fragment level.

In a real incident: a fragment-based audit checked each component's code quality and found six issues (logging inconsistency, missing nil checks, shutdown method). A flow-based audit of the same code traced the approval path from agent to human approver and found that a database FK between two tables would always be NULL — because no mechanism connected the two systems that the FK implied a relationship between. Neither component was broken individually. The incoherence only appeared at the handoff.

Specific flows worth tracing: data from producer to consumer (what does the recipient actually receive?), config from definition to usage (does every loaded value reach its destination?), errors from origin to handler (who sees the error and can they act on it?).

---

## 9. Ask "bump or jaw?" for every finding

When a wrong detail is found, the default is to fix the detail. But the detail may be a symptom of something wrong at a coarser level. Before fixing, step back one resolution and check.

In practice: a config value loaded but never wired through could be fixed by adding the wiring. But it could also indicate that the wiring between components was never systematically checked — which means other config values might be broken too. The single finding is the bump. The missing systematic check is the jaw.

The technique: for each finding, ask "what decision produced this?" If the answer is "an ad-hoc decision during implementation," check whether other ad-hoc decisions in the same area have the same problem.

---

## 10. Compare plan to implementation after building

Planning documents specify interfaces, contracts, and design decisions. Implementation drifts from them — sometimes for good reasons, sometimes by accident. After implementation, comparing the plan against what was built catches two things: stale documentation that will mislead future sessions, and unintentional deviations that indicate decisions were made ad-hoc rather than deliberately.

In a real incident: four interface deviations were found between a planning document and the implementation. Three were reasonable (needed for features the plan hadn't anticipated). One revealed a dropped parameter that was symptomatic of a larger design constraint. The planning document also had a stale architecture description that contradicted the spike findings — a future session reading it would make wrong decisions.

---

## 11. Documents are part of the codebase

Planning documents, workplans, architecture descriptions, and decision records are not separate from the code — they're part of the system. When they're stale or wrong, future sessions (which start fresh without prior context) will make decisions based on incorrect information. Auditing documents alongside code is not extra work — it's the same work at a different resolution.

---

## 12. Underusing dependencies

AI tends to reimplement what its dependencies already provide, or use a dependency's API at a lower level than what's available. It builds custom wrappers where the library has a built-in, or manually orchestrates what a single API call would accomplish.

In a real incident: a batch database writer was built as a hand-rolled loop of individual query executions inside a transaction. The database driver (pgx) provides a native Batch type that sends all queries in a single network round-trip. The custom code was named `pgxBatch`, suggesting awareness of the concept, but the actual pgx Batch API was not used.

This pattern appears across contexts — not just database drivers but HTTP clients, serialization libraries, framework utilities. The AI knows the dependency exists (it imported it) and often knows the API conceptually (it used a related name), but defaults to reimplementing at a lower level. Prompting the AI to check what the dependency provides before writing a wrapper consistently produces better results.
