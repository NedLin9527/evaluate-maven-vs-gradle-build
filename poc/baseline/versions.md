# Version Lock Sheet

## Mandatory Baseline
- JDK: 21
- Spring Boot: 3.5.x

## Tool Versions
- Maven: [fill exact version]
- Gradle: [fill exact version]

## Runtime Metadata
- CI Platform: [GitHub Actions / GitLab CI / Jenkins / Other]
- OS: [Linux / macOS / Windows]
- Runner Spec: [CPU, memory, image details]

## Consistency Rules
- Maven and Gradle samples MUST use the same application code and dependency set.
- Wrapper versions (`mvnw`, `gradlew`) MUST match this sheet.
- Any version change requires re-running all scenarios for fair comparison.
