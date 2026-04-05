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

A related pattern: when a hypothesis or approach is rejected, the assumptions underneath it often carry forward into the next attempt unexamined. The approach changes but the same wrong assumptions drive the new one. Explicitly listing what was assumed — and testing shared assumptions before the next attempt — prevents repeating the same wrong turn at a deeper level.

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

A related technique: when you find a problem, search for siblings. If a pattern exists once — a bug, an inconsistency, a smell — it likely exists elsewhere. Fixing one instance without searching for others leaves the systemic issue in place.

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

---

## 13. First step-back feels sufficient but isn't

When prompted to step back and reconsider an approach, the AI produces a first reframing and settles on it. The answer feels complete. But a second pass from the same coarser level consistently produces deeper insight. The refinement loop applies to design thinking, not just code.

In a real incident: the AI was about to design a context server schema (detail work) when prompted to step back and question the product framing. First pass produced: "these might be two separate products — governance and knowledge management." This felt like a complete insight. When pushed to do another pass, the second reframing was deeper and contradicted the first: "no, these are one product — the knowledge informs the governance and the governance enforces the knowledge. Neither is complete alone." The second pass found the brain-and-muscle relationship that the first pass had split apart.

Had the AI acted on the first step-back without a second pass, it would have designed two separate products — a governance tool and a knowledge base — missing the core integration that makes the product coherent.

This mirrors observation 6 (each audit pass surfaces more) but for design thinking. The AI's first reframing is a rough pass. It needs at least one more to reach the actual insight.

---

## 14. Agreement without challenge

AI defaults to agreeing with proposals, especially reasonable-sounding ones. It builds on what's presented rather than questioning it. But reasonable proposals are exactly where unchallenged assumptions do the most damage — they sound right, so nobody checks.

Before building on any approach, design direction, or assumption, stating at least one concern, limitation, or alternative catches problems early. If after genuine evaluation none exist, that's fine — but the evaluation must happen visibly, not be skipped because the proposal sounds good.

---

## 15. Design-to-build transition gate

When a design doc exists and a build phase is about to start, there's a repeatable pattern that catches structural problems before they're baked into code:

1. Read the design doc and all its context (roadmap, supporting docs, prior decisions)
2. Identify all open questions and unresolved decisions
3. Triage each by structural impact: does it affect everything built on top (coarse-level, like schema semantics or query behavior), or is it a refinement that can be added later without redesign (fine-level, like whether an entity type is separate or tagged)?
4. For structural blockers: evaluate alternatives, recommend a decision
5. For refinements: explicitly defer with rationale — document them as conscious deferrals, not open questions
6. Identify unstated dependencies (decisions the design doc assumes are made but hasn't flagged)
7. Define the first buildable vertical slice — the smallest unit that's deployable and testable
8. Flag risks that the design didn't surface

In a real incident: a design doc listed four open questions as equal blockers before build could start. The transition gate triaged them: two were structural (conflicting rules resolution, structured data support — both affect schema and query semantics), two were refinements (SOP entity types, multi-dimensional query filtering — both deferrable without redesign). It also surfaced an unstated dependency the doc had deferred but the build couldn't start without (embedding model choice). Without the gate, the team would have either stalled resolving all four equally, or started building and hit the structural ones mid-implementation.

The key property: the triage itself (structural vs. surface) is assessable from the design doc alone. Human judgment is only needed for the actual decisions on blocking items. This makes the gate a strong candidate for autonomous execution — it narrows the human decision surface rather than expanding it.

This is a concrete instance of the bildhauer principle "at transitions, check the vision" — but at a resolution where it can be formalized. The sculptor doesn't question the pose every five minutes, but they do at transitions. This gate fires at the design-to-build transition specifically.

---

## 16. Plans don't survive single-pass execution

A correct build sequence — steps ordered by dependency, each independently testable — produces no benefit if all steps are executed as a single generation pass. The sequence defines verification points. Skipping verification turns a multi-pass build into a single-pass build wearing a multi-pass plan as a costume.

In a real incident: a 7-step build sequence was defined with explicit dependency ordering (schema → scaffold → embedding provider → MCP tools → Docker Compose wiring). Each step was described as "testable independently." Then all 7 steps were implemented in one pass — 15 files written without testing any intermediate step. When the end-to-end test failed (pgvector query returning empty results), the failure could have been in the vector literal format, the pgx named args casting, the embedding provider output, or the MCP protocol layer. Nothing had been verified independently, so isolation was impossible.

The fix was obvious in hindsight: test the store layer query against Postgres directly before wrapping it in an MCP tool handler. But the single-pass execution skipped that verification point even though the plan explicitly included it.

The pattern: the AI can produce a correct build plan with the right granularity and verification points, then collapse it into a single generation pass because generating code is what it defaults to. The plan exists but doesn't interrupt the generation. This is observation 1 (everything at once) applied to a build sequence rather than a single file — the scope is larger but the failure mode is identical.

---

## 17. Structured output suppresses step-backs

When the AI produces output in a structured format — tables, numbered sections, labelled decisions, explicit tradeoff evaluations — the result reads as thorough even when the content within that structure hasn't been checked. The format signals completeness. The step-back checkpoint doesn't fire because there's no feeling of incompleteness to trigger it.

In a real incident: a design transition gate for a management UI produced a structured analysis — decision table, triage of structural vs. refinement, self-challenge per decision, first vertical slice, risk flags. The output looked comprehensive. The step-back checkpoint did not fire. When the user manually triggered a second pass, it found three significant problems: a missed structural alternative (HTMX + Go templates vs. any JS framework), a deployment model that contradicted the project's single-binary pattern (embed.FS), and a proposed service that duplicated an existing service's store layer. All three were catchable by asking "what did I not consider?" — the basic step-back question. But the structured format had already created the sense that everything was considered.

The self-challenge checkpoint has a related failure mode in this context: it generates *nearby* alternatives (another JS framework) rather than *structural* alternatives (do we need a JS framework at all?). The structure encourages evaluation within the framing rather than questioning the framing itself. A table comparing React vs. Svelte feels like a thorough evaluation, but the column headers are already wrong — the real alternative isn't in the table.

This is distinct from observation 7 (procedure narrows attention). Observation 7 is about checklists constraining what the AI looks at during work. This is about structured output constraining what the AI checks after work — the format substitutes for the verification.

---

## 18. Schema designed for current task, not data flow

When designing a data model, AI optimizes for the immediate task — the current component's read or write needs. It does not check whether documented upstream producers can populate the schema, or whether documented downstream consumers can use it. The schema is correct for its first use case but incomplete for the system.

In a real incident: a `BusinessRule` entity schema was designed for the context server's query layer (semantic search by agents). The schema included an `applies_to` field scoped as "which agent this rule is relevant to" — correct for search filtering. Seven implementation steps later, when designing policy derivation (generating CEL gateway rules from approved BusinessRules), the schema had no field mapping rules to specific MCP tool names. The gateway needs `mcp.tool.name == "process_refund"` but the schema only had `applies_to: "pricing-agent"`. The downstream consumer (policy derivation) was documented in the roadmap as depending on the context server schema. The gap was discoverable at schema design time.

The same pattern applies upstream: a field added to a schema is only useful if something can populate it. Adding `governed_tools` to BusinessRule raises the question: can the LLM extraction pipeline infer tool names from document text? Can a human entering a rule manually select from available tools? If neither upstream path can populate the field reliably, it's dead schema.

This is related to observation 8 (trace flows, not fragments) but operates at design time rather than audit time. Observation 8 catches flow problems in existing code. This observation catches flow problems in schemas before code is written — the data model is designed for a component, not for the flow through the system.

---

## 19. Diminishing returns on stable artifacts

Multiple refinement passes on the same artifact show a consistent pattern: early passes find structural problems, later passes find increasingly minor issues, and eventually a pass produces only confirmatory findings. The artifact has stabilized — its structure is coherent and further passes don't change it.

In a real session: five Bildhauer passes on an evolving architecture spec. Passes 1-3 found structural gaps (parallel write conflicts, underspecified interfaces, missing validation). Pass 4 found real issues on newly added content (packaging, user journey). Pass 5, run on content that had already been through passes 1-4 with only minor updates, found one data-flow bug (a counter never reset) and three implementation-level notes.

The AI does not naturally recognize this transition. It runs the full procedure because the procedure was invoked, not because the artifact needs it. The sculptor can feel when the clay has settled and further manipulation risks overworking. The AI lacks this sense.

Signal: if a pass finds only detail-level issues on content that was already structurally validated in a prior pass, the bozzetto is refined enough. Say so rather than running another full pass. The exception: if significant new information arrived (an investigation result, a changed constraint, new content added) that could invalidate prior conclusions — then re-run on the affected parts, not the whole thing.

This connects to the vision's "When the Bozzetto is refined enough, the sculptor commits to the marble" — but makes the recognition of "refined enough" an explicit skill rather than an assumed judgment.
