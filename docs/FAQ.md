# FAQ

- 找不到輸入檔：切換到含 `.inp` 的工作目錄，`-i` 不加副檔名。
- 視窗一閃即逝：從 PowerShell 執行，保存 console，檢查 `.sta` 及錯誤訊息。
- PrePoMax 求解失敗：檢查 executable／工作目錄與步驟 solver，採 Default／Spooles。PaStiX／Pardiso 未包含。
- 大模型記憶體不足：減小網格，先跑小範例，保留完整錯誤訊息。結果需依模型物理與收斂獨立核對。
