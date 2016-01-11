## Install Cmder
* https://github.com/cmderdev/cmder#installation

## Install Chocolatey
Chocolatey for managing Windows applications and packages. (Somewhat similar to "apt-get")

Open `powershell` and run the following commands:
```
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
```
If necessary, run `Set-ExecutionPolicy Bypass`

* https://chocolatey.org/

## Install applications with Chocolatey

Run 'powershell` as Administrator
```
choco feature Enable -n=allowGlobalConfirmation

choco install 7zip.install
choco install ccleaner
choco install deluge
choco install git.install
choco install putty.install
choco install python
choco install virtualbox
```

## Install PsGet 
PsGet for installaing and updating modules.

Open `powershell` and run the following commands:
```
(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
import-module PsGet
install-module PsUrl
```
If necessary, run `Set-ExecutionPolicy RemoteSigned`

* http://psget.net/

## Persist History of Commands
From Power Shell or open `C:\Users\<username>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
replacing `<username>` with your user name.
```
 notepad++.exe $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
```

Add the following to the file:
```
$HistoryFilePath = Join-Path ([Environment]::GetFolderPath('UserProfile')) .ps_history
Register-EngineEvent PowerShell.Exiting -Action { Get-History | Export-Clixml $HistoryFilePath } | out-null
if (Test-path $HistoryFilePath) { Import-Clixml $HistoryFilePath | Add-History }
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
```

Create `C:\Users\<username>\.ps_history` with current history if it doesn't exists.
```
Get-History | Export-Clixml $HOME\.ps_history
notepad++.exe $HOME\.ps_history
```

* https://software.intel.com/en-us/blogs/2014/06/17/giving-powershell-a-persistent-history-of-commands