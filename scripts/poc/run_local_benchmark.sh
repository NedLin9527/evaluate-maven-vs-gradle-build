#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  run_local_benchmark.sh --tool <maven|gradle> --project <name> --project-dir <path> --scenario <cold|warm|incremental|multi-module> [--runs 3]

Example:
  scripts/poc/run_local_benchmark.sh --tool maven --project sample-a --project-dir poc/samples/sample-a/maven --scenario cold --runs 3
USAGE
}

TOOL=""
PROJECT=""
PROJECT_DIR=""
SCENARIO=""
RUNS=3
WORKSPACE_ROOT="$(pwd)"
JAVA21_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

if [[ -d "$JAVA21_HOME" ]]; then
  export JAVA_HOME="$JAVA21_HOME"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool) TOOL="$2"; shift 2 ;;
    --project) PROJECT="$2"; shift 2 ;;
    --project-dir) PROJECT_DIR="$2"; shift 2 ;;
    --scenario) SCENARIO="$2"; shift 2 ;;
    --runs) RUNS="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1"; usage; exit 1 ;;
  esac
done

if [[ -z "$TOOL" || -z "$PROJECT" || -z "$PROJECT_DIR" || -z "$SCENARIO" ]]; then
  usage
  exit 1
fi

if [[ "$TOOL" != "maven" && "$TOOL" != "gradle" ]]; then
  echo "--tool must be maven or gradle"
  exit 1
fi

if [[ ! -d "$PROJECT_DIR" ]]; then
  echo "Project dir not found: $PROJECT_DIR"
  exit 1
fi

mkdir -p poc/results/local

build_cmd() {
  if [[ "$TOOL" == "maven" ]]; then
    local maven_cmd="./mvnw"
    if [[ ! -x "$PROJECT_DIR/$maven_cmd" ]]; then
      maven_cmd="mvn"
    fi
    case "$SCENARIO" in
      cold) echo "$maven_cmd -B -Dmaven.repo.local=\"$WORKSPACE_ROOT/.m2/repository\" clean test" ;;
      warm|incremental|multi-module) echo "$maven_cmd -B -Dmaven.repo.local=\"$WORKSPACE_ROOT/.m2/repository\" test" ;;
      *) echo "Unsupported scenario: $SCENARIO"; exit 1 ;;
    esac
  else
    local gradle_cmd="./gradlew"
    if [[ ! -x "$PROJECT_DIR/$gradle_cmd" ]]; then
      gradle_cmd="gradle"
    fi
    case "$SCENARIO" in
      cold) echo "$gradle_cmd --no-daemon --project-cache-dir \"$WORKSPACE_ROOT/.gradle-project-cache\" -g \"$WORKSPACE_ROOT/.gradle-home\" clean test" ;;
      warm|incremental|multi-module) echo "$gradle_cmd --no-daemon --project-cache-dir \"$WORKSPACE_ROOT/.gradle-project-cache\" -g \"$WORKSPACE_ROOT/.gradle-home\" test" ;;
      *) echo "Unsupported scenario: $SCENARIO"; exit 1 ;;
    esac
  fi
}

CMD="$(build_cmd)"
if ! (
  cd "$PROJECT_DIR"
  command -v "$(echo "$CMD" | awk '{print $1}' | sed 's#^\./##')" >/dev/null 2>&1 || [[ -x "$(echo "$CMD" | awk '{print $1}')" ]]
); then
  echo "No executable build command found for $TOOL."
  echo "Expected wrapper (./mvnw or ./gradlew) or installed tool in PATH."
  exit 1
fi

for ((i=1; i<=RUNS; i++)); do
  TS="$(date '+%Y%m%d-%H%M%S')"
  LOG="poc/results/local/${PROJECT}_${TOOL}_${SCENARIO}_run${i}_${TS}.log"

  echo "[run $i/$RUNS] $PROJECT $TOOL $SCENARIO"

  START="$(date +%s)"
  (
    cd "$PROJECT_DIR"
    mkdir -p "$WORKSPACE_ROOT/.m2/repository" "$WORKSPACE_ROOT/.gradle-home" "$WORKSPACE_ROOT/.gradle-project-cache"
    if [[ "$TOOL" == "gradle" ]]; then
      export GRADLE_USER_HOME="$WORKSPACE_ROOT/.gradle-home"
    fi
    eval "$CMD"
  ) 2>&1 | tee "$LOG"
  END="$(date +%s)"

  DURATION=$((END - START))
  TODAY="$(date '+%Y-%m-%d')"

  echo "$TODAY,$PROJECT,$TOOL,$SCENARIO,$i,$DURATION,,,,,,,,,,,autofilled_total_seconds_only" >> poc/metrics/local-build-metrics.csv
  echo "  duration=${DURATION}s log=$LOG"
done

cat <<DONE
Completed.
- Raw logs: poc/results/local/
- Metrics row appended to: poc/metrics/local-build-metrics.csv
DONE
