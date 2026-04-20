# Tasks

## 1. Setup and Baseline
- [x] 1.1 Confirm tool versions: Maven, Gradle, JDK 21, Spring Boot 3.5.x, CI platform, OS.
- [x] 1.2 Ensure both Maven and Gradle samples use the same Java 21 and Spring Boot 3.5 dependency set.
- [x] 1.3 Select project samples: Sample A (1-3 modules), Sample B (5-20 modules).
- [x] 1.4 Freeze comparable test inputs (branch/commit/test set/runner spec).

## 2. Local Build Measurements
- [x] 2.0 Resolve local tool execution prerequisites (Gradle startup currently fails with native library initialization error).
- [x] 2.1 Execute cold build scenario 3 times for each tool.
- [x] 2.2 Execute warm build scenario 3 times for each tool.
- [ ] 2.3 Execute incremental change scenario 3 times for each change type.
- [ ] 2.4 Execute multi-module dependency-chain scenario 3 times.

## 3. CI Measurements (Deferred)
- [x] 3.1 Keep CI validation out of current phase.
- [ ] 3.2 Re-open CI cache on/off validation as Phase 2 backlog.

## 4. Evaluation and Decision
- [ ] 4.1 Compute local-build KPI summaries and compare thresholds.
- [ ] 4.2 Complete maintainability and governance scoring.
- [ ] 4.3 Produce Phase 1 conclusion: Maven, Gradle, or dual-track (local evidence based).
- [ ] 4.4 Prepare deliverables bundle and decision report.
