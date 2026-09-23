# Explainable Engineering Method in This Project

## Purpose and provenance

This project adapts the Explainable Engineering Method (EEM) v0.1 draft to a small Godot game. EEM connects the intended result, the implementation boundary, verification evidence, and the understanding needed to maintain the feature.

Source: [Explainable Engineering Method](https://github.com/kartorhys-ship-it/explainable-engineering-method), version 0.1 draft for trial. This is a practical workflow proposal, not a proven standard or a claim of production readiness.

## Working principles

- Keep intended behavior, implementation, and observed results distinct.
- Support completion claims with evidence that matches the claim.
- Record a feature's owner nodes, inputs, outputs, dependencies, side effects, and relevant failure cases when they matter.
- Link the requirement to the feature spec, implementation paths, and the check that supports it.
- Keep each fact in one authoritative place; avoid duplicate status lists.
- Choose documentation and verification effort according to risk and uncertainty.
- Reassess evidence when code, configuration, assets, engine version, or assumptions change.
- State unknowns and failed or unrun checks plainly.

## Workflow

1. Frame the outcome, current behavior, boundaries, non-goals, and assumptions.
2. Define observable acceptance criteria before implementation.
3. Choose lightweight, standard, or heightened rigor and give a short reason.
4. Inspect affected scenes, scripts, callers, and project settings.
5. Implement one bounded feature slice.
6. Verify the criteria with suitable checks and record actual results, environment, and change snapshot.
7. Explain the relevant scene/script path, design choices, evidence, and first debugging step. For this learning project, leave the explanation check pending until the user has had a chance to walk through it.
8. Update affected records and report implementation, verification, explanation, work disposition, and release statuses separately.

## Rigor guide

- **Lightweight:** local, reversible changes with familiar behavior. Keep a short Work Record, criteria, suitable check, and source links.
- **Standard:** user-visible gameplay behavior, several interacting nodes, changed interfaces, or meaningful uncertainty. Record boundaries, failure cases, relevant design rationale, and neighboring behavior checks.
- **Heightened:** possible data loss, security/access problems, irreversible changes, physical effects, or difficult recovery. Add explicit failure analysis, recovery planning, and any necessary specialist or independent evidence.

The level describes documentation and evidence needs; it does not create new permission or release authority.

## Status vocabulary

Keep these independent:

- Implementation: not started / in progress / complete
- Verification: pending / passed / failed / inconclusive
- Human explanation: pending / completed / not required (with a reason)
- Work disposition: open / closed / closed with exception
- Release: not requested / pending / released / rolled back

A criterion is not passed merely because it is written or implemented. A test definition is not a test result. An assistant explanation does not complete a human explanation check.

## Project records

- `features/<feature>/SPEC.md` is authoritative for expected behavior and boundaries.
- `features/<feature>/ACCEPTANCE.md` is the list of observable criteria, not a record of test results.
- `features/<feature>/WORK_RECORD.md` links outcome, scope, implementation, evidence, limits, and statuses. Use the template in `features/WORK_RECORD_TEMPLATE.md` when creating a feature record.
- Existing docs remain authoritative for game design, architecture, and roadmap; Work Records link to them rather than copying them.
