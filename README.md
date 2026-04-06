# Bildhauer

Coarse-to-fine refinement framework for AI-assisted development. Named after
the German word for sculptor — the discipline of working from rough form to
fine detail, checking the shape before committing to cuts.

## Installation

```
claude plugin marketplace add Gunther-Schulz/bildhauer
claude plugin install bildhauer@bildhauer-marketplace
/reload-plugins
```

## Usage

Triggers on: "bildhauer", "step back", "refine", "check the vision",
"audit adherence", or when starting significant implementations.

## Five Checkpoints

1. **Bozzetto** — before changing anything, write out the plan
2. **Self-challenge** — at decisions, evaluate genuine alternatives
3. **Step-back** — after completing a unit, verify assumptions
4. **Grain** — before building on external systems, test empirically
5. **Diagnosis** — when something breaks, isolate before patching

## Files

| File | Role | Loaded |
|------|------|--------|
| `SKILL.md` | Entry point, trigger conditions, maintenance guide | At invocation |
| `PROCEDURE.md` | The five checkpoints (self-contained) | At invocation |
| `OBSERVATIONS.md` | Failure patterns from real incidents | Only when improving bildhauer |
| `VISION.md` | Philosophical foundation | Only when improving bildhauer |
| `STRATEGY.md` | Connects observations to principle | Only when improving bildhauer |
| `ROADMAP.md` | Concrete improvement work items | Only when improving bildhauer |
