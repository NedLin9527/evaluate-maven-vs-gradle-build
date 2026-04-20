# Evaluate Maven vs Gradle Build

以 OpenSpec 驅動的 Maven vs Gradle 建置效能評估 POC，目標是在相同技術基準下（Java 21 + Spring Boot 3.5.x），用可重複的流程產生選型證據。

## 專案目標

- 建立 Maven 與 Gradle 的公平比較框架
- 先完成本地端（Phase 1）量測，再擴展到 CI（Phase 2）
- 以量化 KPI 與維運評估作為決策依據

## 目錄結構

```text
.
├── openspec/                 # 規格與變更流程
│   ├── project.md
│   ├── AGENTS.md
│   └── changes/
├── poc/                      # POC 資料與輸出
│   ├── baseline/             # 版本與執行基準
│   ├── metrics/              # 指標 CSV
│   ├── results/local/        # 本地測試結果與報告
│   └── samples/              # sample-a / sample-b (maven + gradle)
└── scripts/poc/              # 量測腳本
```

## OpenSpec 工作方式

本專案採用 OpenSpec 三步驟：

1. `proposal`：定義變更原因、範圍與影響
2. `apply`：依 `tasks.md` 實作與勾選進度
3. `archive`：完成後歸檔並合併回正式 specs

目前主要變更位於：

- `openspec/changes/evaluate-maven-vs-gradle-build/`

## 快速開始

### 1) 確認環境

- JDK 21
- Maven 3.9.x
- Gradle 9.x

### 2) 檢查 OpenSpec

```bash
openspec validate --changes --strict
```

### 3) 執行本地 benchmark

```bash
scripts/poc/run_local_benchmark.sh \
  --tool maven \
  --project sample-a \
  --project-dir poc/samples/sample-a/maven \
  --scenario cold \
  --runs 3
```

`--scenario` 支援：`cold`、`warm`、`incremental`、`multi-module`

## 目前結果（Phase 1）

已完成：

- 冷啟動建置（cold）3-run 比較
- 暖啟動建置（warm）3-run 比較
- 基準版本與執行條件定義

主要結論（2026-04-20 報告）：

- Cold build：Gradle 平均快約 66.26%
- Warm build：Gradle 平均快約 77.62%

參考文件：

- `poc/results/local/phase1-cold-warm-summary.md`
- `poc/results/local/phase1-stakeholder-report-2026-04-20.md`

## 待完成項目

- Incremental change 場景（task 2.3）
- Multi-module dependency-chain 場景（task 2.4）
- 維運/治理評分（task 4.2）
- CI cache on/off 對照（Phase 2）

## 授權

本專案採用 [MIT License](./LICENSE)。
