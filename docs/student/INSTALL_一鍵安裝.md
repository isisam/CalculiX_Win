# CalculiX_Win 一鍵安裝

作者：S.Y. Su　版本：2.21-win64.2

**下載 Setup.exe → 雙擊 → 完成**

1. 到 [GitHub Releases](https://github.com/isisam/CalculiX_Win/releases) 下載 `CalculiX_Win_Setup_2.21.exe`。
2. 雙擊，按「下一步」→「安裝」→「完成」。不需管理員密碼。
3. 預設裝到 `%LOCALAPPDATA%\Programs\CalculiX_Win`。
4. 重新開啟終端機。把 `examples\spring1.inp` 複製到自己的工作資料夾，在該處執行 `ccx -i spring1`。

若 SmartScreen 顯示未知發行者：本包未以商業憑證簽章，因此可能顯示「未知發行者」。確認檔案來自上述 GitHub release，並比對 SHA256SUMS 後，在 SmartScreen 按「其他資訊」→「仍要執行」。若學校政策不允許，請聯絡學校 IT；不必關閉防毒或安全設定。

完成後：重新開啟終端機。把安裝資料夾 `examples` 的 `spring1.inp` 複製到自己的工作資料夾，在該資料夾執行 `ccx -i spring1`。成功後會產生 `spring1.dat`，節點 2 的 X 位移應為 0.1。

需要圖形介面時，可另裝 PrePoMax-RCM。下圖是該介面 RC1g8 候選包既有的疊層畫面截圖，獨立 CalculiX 安裝包本身沒有 GUI，也不含此功能。

![搭配使用的 PrePoMax-RCM 圖形介面](screenshots/layup-rc1g8.png)

解除安裝：在 Windows「設定 → 應用程式 → 已安裝的應用程式」選擇本程式並解除安裝，或執行安裝資料夾的 `Uninstall.exe`。會移除本包檔案、捷徑與登錄項目。僅移除由本包新增的使用者 PATH 項目，保留原有 PATH。請將自己修改的範例另存到工作資料夾；解除安裝會移除本包附的範例，另存的模型與計算結果會保留。

詳細功能與需求見 [繁中功能說明](FEATURES_zh-TW.md)／[English features](FEATURES_en.md)。
