# Observations — AI Shortcomings

Documented patterns of how AI fails when designing and building code. Each observation is grounded in real incidents. These inform what the protocol needs to mitigate.

---

## 1. Everything at once

AI generates code in a single pass — struct layout, error handling, logging conventions, shutdown methods, edge cases — all decided simultaneously. There is no natural separation between architecture decisions and detail decisions. The result compiles and runs but lacks coherence across parts. One component uses one convention, its sibling uses another. Config values are loaded but never wired through. Each fragment is reasonable in isolation. The statue has two noses.

---

## 2. Sanding the bump instead of checking the jaw

When AI encounters a problem during refinement or audit, it defaults to fixing the immediate detail. It will never say "this approach is fundamentally wrong, we should rethink this part." Instead it produces increasingly elaborate workarounds to preserve a bad foundation. The arm is too short so it elongates the fingers.

The root cause: AI treats existing code — including code it just wrote — as something to preserve and modify, not as something to potentially discard and redo. It has a strong bias toward incremental patching over structural rework. It refuses to go back to a coarser resolution and re-cut.

A related pattern: AI doesn't distinguish between "this detail is wrong" and "a decision upstream is wrong." Every problem is treated as a local fix. When a wrong detail is actually a symptom of a wrong assumption or a wrong approach, the AI sands the symptom rather than stepping back to check the shape.

---

## 3. False insights that sound like wisdom

The opposite of observation 2 also happens. AI can generate compelling-sounding architectural critiques that aren't grounded in evidence. "Maybe the whole approach is wrong!" sounds like the sculptor stepping back to check proportions — but if the critique isn't verified against actual constraints, it's imagining a crack in the stone that isn't there.

In a real incident: AI questioned whether an entire architectural integration point was wrong, proposing a fundamental redesign. Investigation of the actual constraints showed the original approach was correct — the limitation was in the upstream system, not in the architecture. Had the AI acted on its unverified critique, it would have wasted effort redesigning something that was already the right solution.

Both observation 2 and 3 have the same fix: look at the actual stone. Verify before acting — whether you're fixing a detail or questioning the whole shape.

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
