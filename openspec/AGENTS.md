# OpenSpec Working Guide

## Workflow
1. Create proposal under `openspec/changes/<change-id>/` with:
   - `proposal.md`
   - `tasks.md`
   - `specs/<domain>/spec.md` deltas
2. Implement only within approved proposal scope.
3. Archive the change after completion and merge deltas into `openspec/specs/`.

## Delta Format Rules
- Use one or more sections: `## ADDED`, `## MODIFIED`, `## REMOVED`, `## RENAMED`.
- `MODIFIED` must include full post-change requirement text.
- Each requirement must include at least one scenario.
- Scenario headers must be exactly `#### Scenario:`.
- Requirement statements must use `SHALL` or `MUST`.

## Validation
Use strict validation before review when OpenSpec CLI is available.
