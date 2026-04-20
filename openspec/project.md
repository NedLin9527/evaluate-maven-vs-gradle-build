# Project Context

## Purpose
This repository hosts a Proof of Concept (POC) for evaluating Maven vs Gradle as the enterprise-standard Java build tool.

## Scope Baseline
- Compare Maven and Gradle under equivalent project code, JDK, hardware, and CI conditions.
- Current POC baseline stack is Java 21 with Spring Boot 3.5.x.
- Focus on measurable build behavior and governance maintainability.
- Produce repeatable evidence for architecture decision-making.

## Evaluation Principles
- Same codebase logic MUST produce equivalent functional output between tools.
- Measurements MUST be repeatable and collected from at least 3 runs per scenario.
- Cold and warm builds MUST be recorded separately.
- CI runs MUST preserve full logs and explicit cache on/off status.

## Operating Conventions
- Keep active proposals in `openspec/changes/`.
- Keep accepted system truth in `openspec/specs/`.
- Archive completed proposals under `openspec/changes/archive/`.
- Use requirement language with SHALL or MUST and at least one `Scenario` per requirement.
