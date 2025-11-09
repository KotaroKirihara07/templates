# extensions
## エクスポート  
<code>code --list-extensions > extensions.txt </code>  


## インポート
### Windowsの場合  
<code>@echo off </code>  
<code>for /F "tokens=*" %%A in (extensions.txt) do (code --install-extension %%A)</code>  

### Mac/Linuxの場合  
<code>#!/bin/bash </code>  
<code>cat extensions.txt | xargs -L 1 code --install-extension</code>  

## 拡張機能リスト
| 種別 | 名称 | Identifier | 概要 |
| ---- | ---- | ---- | ---- |
| Python | Python | ms-python.python  | Python |
| Python | Jupyter | ms-toolsai.jupyter | Jupyter notebook |
| Python | Ruff | charliermarsh.ruff | Ruff linter and formatter |
| Java | Extension Pack for Java | vscjava.vscode-java-pack | Java |
| VSCode | Japanese Language Pack for Visual Studio Code | ms-ceintl.vscode-language-pack-ja | VSCodeの日本語化 |
| VSCode | IntelliCode | visualstudioexptteam.vscodeintellicode | コード補完 |
| VSCode | vscode-icons | vscode-icons-team.vscode-icons | アイコン |
| Latex | LaTeX Workshop | james-yu.latex-workshop | Latex |
| その他ツール | Draw.io Integration | hediet.vscode-drawio | 図の作成 |
| その他ツール | Markdown All in One | yzhang.markdown-all-in-one | マークダウン補完機能 |
|  |  |  |
|  |  |  |
|  |  |  |