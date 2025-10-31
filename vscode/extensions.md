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