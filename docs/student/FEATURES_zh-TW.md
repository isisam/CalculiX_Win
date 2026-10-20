# CalculiX_Win 功能說明

版本：2.21-win64.2　作者：S.Y. Su（保留原始上游作者及授權聲明）

## 能做什麼

- 用命令列執行 CalculiX 2.21 支援的有限元素分析，例如靜力、模態及熱傳。
- 將 `.inp` 輸入檔算成 `.dat`、`.frd` 等結果；輸出種類依輸入檔的要求決定。
- 附彈簧與樑範例，方便先確認電腦能計算。
- 安裝後會加入目前使用者的 PATH；請重新開啟終端機，再執行 `ccx -i spring1`。

## 跟原版的差別

與 v2.21-win64.1 公開 zip 使用完全相同的 ccx.exe，沒有修改數值核心。新增每位使用者的安裝、PATH 設定、開始選單說明與解除安裝程式。

## 不能做什麼

這是命令列求解器，沒有繪圖介面、CAD 編輯器或前後處理 GUI；可搭配 PrePoMax-RCM。 本包不提供私人疲勞與客製材料求解功能。不是商用軟體的完整替代品；支援範圍依 CalculiX 2.21 與模型設定而定。範例只是教學，不能當成工程設計認證。

## 系統需求

Windows 10/11 64 位元。建議至少 4 GB RAM、200 MB 可用磁碟空間；大型模型需要更多。無須另外安裝 Fortran runtime。 安裝在目前使用者的可寫入資料夾，不需管理員權限。為了讓舊有原生工具正常運作，工作資料夾建議使用簡單英文字母與數字；安裝程式支援空白和中文路徑。

## 怎麼安裝

1. 到 [GitHub Releases](https://github.com/isisam/CalculiX_Win/releases) 下載 `CalculiX_Win_Setup_2.21.exe`。
2. 雙擊，按「下一步」→「安裝」→「完成」。不需管理員密碼。
3. 預設裝到 `%LOCALAPPDATA%\Programs\CalculiX_Win`。
4. 重新開啟終端機。把 `examples\spring1.inp` 複製到自己的工作資料夾，在該處執行 `ccx -i spring1`。

教室批次安裝可用 `CalculiX_Win_Setup_2.21.exe /S`。自訂資料夾時，`/D=完整路徑` 必須放最後；不用加引號，例如 `/S /D=C:\Student Apps\CalculiX_Win`。

## 怎麼解除安裝

在 Windows「設定 → 應用程式 → 已安裝的應用程式」選擇本程式並解除安裝，或執行安裝資料夾的 `Uninstall.exe`。會移除本包檔案、捷徑與登錄項目。僅移除由本包新增的使用者 PATH 項目，保留原有 PATH。請將自己修改的範例另存到工作資料夾；解除安裝會移除本包附的範例，另存的模型與計算結果會保留。 靜默解除安裝：`Uninstall.exe /S`。

## SmartScreen 顯示未知發行者

本包未以商業憑證簽章，因此可能顯示「未知發行者」。確認檔案來自上述 GitHub release，並比對 SHA256SUMS 後，在 SmartScreen 按「其他資訊」→「仍要執行」。若學校政策不允許，請聯絡學校 IT；不必關閉防毒或安全設定。
