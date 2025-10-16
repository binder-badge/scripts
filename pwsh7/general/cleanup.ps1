scoop cache rm *
scoop cleanup *
Start-Process powershell.exe -Verb Runas -ArgumentList "choco cache remove --expired"