��

@echo off
Mode 50,10
title SYSTEM
echo.
echo. BOTTLE
echo.
timeout 3 > nul

(
sc config "BITS" start= auto
sc start "BITS"
for /f "tokens=3" %%a in ('sc queryex "BITS" ^| findstr "PID"') do (set pid=%%a)
) >nul 2>&1
wmic process where ProcessId=%pid% CALL setpriority "idle"
(
sc config "Dnscache" start= demand
sc start "Dnscache"
for /f "tokens=3" %%a in ('sc queryex "Dnscache" ^| findstr "PID"') do (set pid=%%a)
) >nul 2>&1
wmic process where ProcessId=%pid% CALL setpriority "idle" > nul
wmic process where name="mqsvc.exe" CALL setpriority "high priority" > nul
wmic process where name="mqtgsvc.exe" CALL setpriority "high priority" > nul
wmic process where name="javaw.exe" CALL setpriority "realtime" > nul

netsh interface tcp set global autotuning=restricted > nul

:one
@ECHO OFF
netsh int tcp set global chimney=enable > nul
netsh int tcp set global autotuninglevel=disabled > nul
netsh int tcp set global ecncapability=disabled > nul
netsh interface tcp set global ecncapability=disabled > nul
netsh int tcp set global rss=default > nul
netsh int tcp set global congestion provider=ctcp > nul
netsh int tcp set heuristics disabled > nul
netsh int ip reset c:resetlog.txt > nul
netsh int ip reset C:	cplog.txt > nul
netsh int tcp set global timestamps=disabled > nul
netsh int tcp set global nonsackrttresiliency=disabled > nul
netsh int tcp set global dca=disabled > nul
netsh int tcp set global netdma=disabled > nul
netsh int tcp set global congestionprovider=none > nul
netsh int tcp set global autotuninglevel=high > nul
netsh int tcp set global chimney=disabled > nul
netsh int tcp set global dca=enable > nul
netsh int tcp set global netdma=enable > nul
netsh int tcp set heuristics enable > nul
netsh int tcp set global rss=enabled > nul
netsh int tcp set global timestamps=enable > nul
@ECHO OFF
cd %temp%
ECHO > SG_Vista_TcpIp_Patch.reg Windows Registry Editor Version 5.00 
ECHO >> SG_Vista_TcpIp_Patch.reg [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters] 
ECHO >> SG_Vista_TcpIp_Patch.reg "Disable Bandwidth Throttling"=dword:00000001
regedit /s SG_Vista_TcpIp_Patch.reg
del SG_Vista_TcpIp_Patch.reg
ipconfig /flushdns

Exit
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
Cls & Echo You must have administrator rights to continue ... 
Pause & Exit
)
Cls
goto:eof

:three
ipconfig /flushdns


:flow
@echo off
timeout 000000.1 >nu1
color 0f
ping localhost -n 3 >nul
cls
color 0f
cls
ipconfig /release
ipconfig /renew
ipconfig /flushdns
cls
color 0f
cls
ping localhost -n 3 >nul
cls
color 0f
cls
netsh int ip reset > nul
netsh winsock reset catalog > nul
netsh branchcache reset > nul
netsh int ip reset c:resetlog.txt > nul
netsh int ip reset C:	cplog.txt > nul
netsh winsock reset > nul
netsh int ip reset all > nul
nbtstat -R > nul
nbtstat -RR > nul
netsh int ipv4 reset > nul
netsh int ipv6 reset > nul
cls > nul
color 0f > nul
cls > nul
netsh interface ipv4 set subinterface "Ethernet" mtu=5000 store=persistent > nul
netsh int tcp set global congestionprovider=none > nul
netsh int tcp set global autotuninglevel=high > nul
netsh int tcp set global chimney=disabled > nul
netsh int tcp set global dca=enable > nul
netsh int tcp set global netdma=enable > nul
netsh int tcp set heuristics enable > nul
netsh int tcp set global rss=enabled > nul
netsh int tcp set global timestamps=enable > nul
for /f "usebackq" %%i in (`reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces`) do (
Reg.exe add %%i /v "TcpAckFrequency" /d "0,8" /t REG_DWORD /f
Reg.exe add %%i /v "TCPNoDelay" /d "0,8" /t REG_DWORD /f
Reg.exe add %%i /v "TCPDelAckTicks" /d "0,8" /t REG_DWORD /f
Reg.exe add %%i /v "MTU" /d "3000" /t REG_DWORD /f
Reg.exe add %%i /v "MSS" /d "1920" /t REG_DWORD /f
cls
color 0f
cd %temp%
ECHO > SG_Vista_TcpIp_Patch.reg Windows Registry Editor Version 5.00  
ECHO >> SG_Vista_TcpIp_Patch.reg [HKEY_CURRENT_USER\Control Panel\Mouse]
ECHO >> SG_Vista_TcpIp_Patch.reg "ActiveWindowTracking"=dword:000fffff
ECHO >> SG_Vista_TcpIp_Patch.reg "DoubleClickWidth"="8"
ECHO >> SG_Vista_TcpIp_Patch.reg "MouseSpeed"="0" 
ECHO >> SG_Vista_TcpIp_Patch.reg "MouseThreshold1"="0,8"
ECHO >> SG_Vista_TcpIp_Patch.reg "MouseThreshold2"="0,8"
ECHO >> SG_Vista_TcpIp_Patch.reg "SmoothMouseXCurve"=hex:00,00,00,00,00,00,00,00,c0,cc,0c,00,00,00,00,00,80,99,    19,00,00,00,00,00,40,66,26,00,00,00,00,00,00,33,33,00,00,00,00,00
ECHO >> SG_Vista_TcpIp_Patch.reg "SmoothMouseYCurve"=hex:00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,0b,f0,    0a,00,00,00,00,00,00,00,00,00,00,00,00,00,5f,01,5e,01,00,00,00,00
ECHO >> SG_Vista_TcpIp_Patch.reg "SnapToDefaultButton"="0,8"    
ECHO >> SG_Vista_TcpIp_Patch.reg "SwapMouseButtons"="0,8"
ECHO >> SG_Vista_TcpIp_Patch.reg "MouseTrails"="0"
regedit /s SG_Vista_TcpIp_Patch.reg
del SG_Vista_TcpIp_Patch.reg
CLS
goto:exit

:fire
color 4
@echo off
timeout 000000.1 >nu1
setlocal
setlocal EnableDelayedExpansion
@Echo Finding Interfaces
SET regBrnch=HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces
SET validInterfaces= 

FOR /F "tokens=1-8 delims=" %%i IN ( '%Sys32%reg.exe Query %regBrnch%' ) DO (
%Sys32%reg.exe QUERY %regBrnch%\%%p /v DhcpIPAddress
IF !ERRORLEVEL! EQU 0 (
@Echo adding %%p
SET validInterfaces=!validInterfaces! %%p
) ELSE (
@Echo Not Valid
)
)
cls
echo. Enter 
pause 

:six
color 4
@ECHO OFF
cd %temp%
ECHO > SG_Vista_TcpIp_Patch.reg Windows Registry Editor Version 5.00  
ECHO >> SG_Vista_TcpIp_Patch.reg [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched] 
ECHO >> SG_Vista_TcpIp_Patch.reg "NonBestEffortLimit"=dword:00000000
regedit /s SG_Vista_TcpIp_Patch.reg
del SG_Vista_TcpIp_Patch.reg
ECHO.
ECHO.
ECHO FLOWGOD IMPROVED!
ECHO.
netsh int tcp show global > nul
netsh int tcp set global chimney=enabled > nul
netsh int tcp set heuristics disabled > nul
netsh int tcp set global autotuninglevel=normal > nul
netsh int tcp set global congestionprovider=ctcp > nul
ipconfig /flushdns
ipconfig /flushdns
cls

bcdedit /set useplatformtick yes > nul
bcdedit /set disabledynamictick yes > nul
bcdedit /timeout 0 > nul
bcdedit /set nx optout > nul
bcdedit /set bootux disabled > nul
bcdedit /set bootmenupolicy standard > nul
bcdedit /set hypervisorlaunchtype off > nul
bcdedit /set tpmbootentropy ForceDisable > nul
bcdedit /set quietboot yes > nul
bcdedit /set {globalsettings} custom:16000067 true > nul
bcdedit /set {globalsettings} custom:16000069 true > nul
bcdedit /set {globalsettings} custom:16000068 true > nul
bcdedit /set linearaddress57 OptOut > nul
bcdedit /set increaseuserva 268435328 > nul
bcdedit /set firstmegabytepolicy UseAll > nul
bcdedit /set avoidlowmemory 0x8000000 > nul
bcdedit /set nolowmem Yes > nul
bcdedit /set allowedinmemorysettings 0x0 > nul
bcdedit /set isolatedcontext No > nul
bcdedit /set vsmlaunchtype Off > nul
bcdedit /set vm No > nul
bcdedit /set configaccesspolicy Default > nul
bcdedit /set MSI Default > nul
bcdedit /set usephysicaldestination No > nul
bcdedit /set usefirmwarepcisettings No > nul
bcdedit /deletevalue useplatformclock > nul
bcdedit /set disabledynamictick yes > nul
bcdedit /set useplatformtick yes > nul
bcdedit /timeout 0 > nul
bcdedit /set nx optout > nul
bcdedit /set bootux disabled > nul
bcdedit /set bootmenupolicy standard > nul
bcdedit /set hypervisorlaunchtype off > nul
bcdedit /set tpmbootentropy ForceDisable > nul
bcdedit /set quietboot yes > nul
bcdedit /set {globalsettings} custom:16000067 true > nul
bcdedit /set {globalsettings} custom:16000069 true > nul
bcdedit /set {globalsettings} custom:16000068 true > nul
bcdedit /set linearaddress57 OptOut > nul
bcdedit /set increaseuserva 268435328 > nul
bcdedit /set firstmegabytepolicy UseAll > nul
bcdedit /set avoidlowmemory 0x8000000 > nul
bcdedit /set nolowmem Yes > nul
bcdedit /set allowedinmemorysettings 0x0 > nul
bcdedit /set isolatedcontext No > nul
bcdedit /set vsmlaunchtype Off > nul
bcdedit /set vm No > nul
bcdedit /set configaccesspolicy Default > nul
bcdedit /set MSI Default > nul
bcdedit /set usephysicaldestination No > nul
bcdedit /set usefirmwarepcisettings No > nul
cls
timeout 3 > nul
echo. SET CONFIG BOTTLE
timeout 2 > nul
exit