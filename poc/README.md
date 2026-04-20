# POC Execution Assets

This folder contains execution assets for Maven vs Gradle build evaluation.

## Scope
- Baseline lock for Java 21 + Spring Boot 3.5.x
- Sample project definitions for Sample A and Sample B
- Metrics templates for local measurements (CI reserved for Phase 2)
- Local benchmark helper script

## Quick Start
1. Fill `poc/baseline/versions.env` with exact Maven/Gradle/JDK/Spring Boot versions.
2. Place or link your actual codebases under `poc/samples/sample-a` and `poc/samples/sample-b`.
3. Run `scripts/poc/run_local_benchmark.sh` for cold/warm/incremental/multi-module scenarios.
4. Consolidate outputs into files under `poc/metrics/`.

## Current Phase
- Phase 1: local build evaluation only
- Phase 2: CI cache on/off comparison (deferred)
