Import-Module ./PowerShellJsonObject.psd1 -Force

Clear-Host
''
psjo p=$(psjo x=10 y=20)
''
psjo name=jo n=17 parser=$false
''
psjo dir=$pshome
''
psjo name=JP object=$(psjo fruit=Orange point=$(psjo x=10 y=20) number=17) sunday=$false
''
psjo -a summer spring winter
''
psjo -a -c (1..10)
''
psjo date=$((Get-Date).ToString('MMM dd, yyyy')) time=$((Get-Date).ToShortTimeString()) 
