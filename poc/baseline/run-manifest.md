# Run Manifest (Phase 1: Local Build)

## Baseline
- JDK target: 21
- Framework: Spring Boot 3.5.0
- Maven baseline: 3.9.15
- Gradle baseline: 9.4.1

## Comparable Inputs
- Source reference: local workspace snapshot (no git metadata available)
- Sample A Maven path: `poc/samples/sample-a/maven`
- Sample A Gradle path: `poc/samples/sample-a/gradle`
- Sample B Maven path: `poc/samples/sample-b/maven`
- Sample B Gradle path: `poc/samples/sample-b/gradle`
- Test scope: module default unit tests (`test` task/goal)

## Runtime Notes
- Current machine Java runtime detected: OpenJDK 25.0.2
- Benchmark runs use JAVA_HOME `/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home` where applicable.
- Gradle startup issue was resolved by forcing workspace-local Gradle home/cache (`GRADLE_USER_HOME` and `-g` under workspace).
- In this sandboxed environment, Gradle benchmark execution required unrestricted mode because file-lock contention uses local socket binding.
- Phase 1 benchmark MUST run with Java 21 runtime/toolchain for valid comparison.
