# Maven vs Gradle POC Phase 1 回報（給架構師/顧問/專案負責人）

文件日期：2026-04-20  
文件版本：v0.1-phase1  
文件範圍：Phase 1（Local Build Only，CI 暫緩）

## 1. 執行摘要
本次 Phase 1 以 Java 21 + Spring Boot 3.5.0 為統一基準，完成本地端 cold/warm build 對照測試（Sample A、Sample B；Maven 與 Gradle 各 3 次）。

關鍵結論：
- 在目前樣本與條件下，Gradle 在 cold 與 warm build 皆明顯快於 Maven。
- 以兩個樣本平均來看：
  - Cold build：Gradle 較 Maven 快 **66.26%**
  - Warm build：Gradle 較 Maven 快 **77.62%**
- 已達成「warm build 改善 >=20%」的建議門檻。
- 但本次尚未完成 incremental 與 dependency-chain 變更場景，故目前結論屬 **Phase 1 暫定結論**，非最終選型定案。

## 2. 驗證範圍與狀態
已完成：
- Local cold build（每組合 3 次）
- Local warm build（每組合 3 次）

尚未完成：
- Incremental build（2.3）
- Multi-module dependency-chain change（2.4）
- CI 驗證（Phase 2，已暫緩）

## 3. 基準與測試條件
- JDK：21
- Spring Boot：3.5.0
- Maven：3.9.15
- Gradle：9.4.1
- OS：macOS
- Sample A：單體/小型（1-3 模組）
- Sample B：中型多模組（5 模組）
- 每個 tool x sample x scenario 皆執行 3 次

資料納入原則：
- 僅納入 **修正後且符合 Java 21 基準** 的最新 3 次量測。
- 早期不符合基準（如 Java 25）或排障過程數據不納入正式結論。

## 4. 量測結果（最新 3 次平均）
| Project | Tool | Scenario | Runs | Avg(s) | Min(s) | Max(s) |
|---|---|---|---:|---:|---:|---:|
| sample-a | maven  | cold | 3 | 12.67 | 12 | 13 |
| sample-a | gradle | cold | 3 | 4.00 | 4 | 4 |
| sample-a | maven  | warm | 3 | 12.33 | 12 | 13 |
| sample-a | gradle | warm | 3 | 2.67 | 2 | 3 |
| sample-b | maven  | cold | 3 | 13.00 | 13 | 13 |
| sample-b | gradle | cold | 3 | 4.33 | 4 | 5 |
| sample-b | maven  | warm | 3 | 13.00 | 13 | 13 |
| sample-b | gradle | warm | 3 | 3.00 | 3 | 3 |

跨樣本平均比較：
- Cold：Maven 12.835s vs Gradle 4.330s（Gradle 快 66.26%）
- Warm：Maven 12.665s vs Gradle 2.835s（Gradle 快 77.62%）

## 5. 觀察與初步判讀
1. Gradle 在兩類樣本（單體與多模組）皆呈現顯著速度優勢。  
2. Warm build 改善幅度高，符合「頻繁重複建置」情境下的優勢假設。  
3. Multi-module 在 cold/warm 指標上也顯示一致趨勢，但尚缺「局部改動影響面」證據，無法完成對 incremental 命題的完整驗證。  
4. 本次流程已解決工具執行前置問題，具備可重跑能力。

## 6. 風險與限制
1. 本報告僅為 Phase 1，本地端結果尚未含 CI pipeline 效果。  
2. 尚未完成 incremental 與 dependency-chain change 場景，無法完整覆蓋所有原 POC 命題。  
3. 測試環境為單一機器條件，尚未進行跨機器重現性比對。  
4. 維運面（可讀性、onboarding、治理成本）尚未以訪談/評分法完成量化。

## 7. 對利害關係人的建議
1. 可先將目前結果視為「效能面強烈傾向 Gradle」的階段性訊號。  
2. 在做最終標準化決策前，建議補齊：
   - Incremental 變更三類場景（service/test/shared module）
   - Multi-module dependency-chain 局部變更場景
   - 維運治理評分（架構師 + 開發代表）
3. 若近期需先行試點，可採「有限範圍 Gradle 試點」並維持決策閘門，待 Phase 1 全部量測完成後定案。

## 8. 交付附件與路徑
- OpenSpec 任務清單：
  - `openspec/changes/evaluate-maven-vs-gradle-build/tasks.md`
- 原始量測資料：
  - `poc/metrics/local-build-metrics.csv`
- 本次摘要表：
  - `poc/results/local/phase1-cold-warm-summary.md`
- 本回報文件：
  - `poc/results/local/phase1-stakeholder-report-2026-04-20.md`

