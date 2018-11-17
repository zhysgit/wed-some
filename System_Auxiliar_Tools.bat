@Echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
Setlocal enabledelayedexpansion
Color 3F
call :Permission_Check
call :OS_Check
rem System Auxiliar Tools By Bluewing009

cd /d %~dp0
pushd %~dp0



:Welcome
Mode con cols=70 lines=25
Title 系统辅助工具
cls
echo;
echo   ★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
echo   ☆                                                              ☆
echo   ★               系 统 辅 助 工 具                              ★
echo   ☆                                                              ☆
echo   ★             System  Auxiliar  Tools                   V5.11  ★
echo   ☆                                                              ☆
echo   ★                                                              ★
echo   ☆                               Author ：    九影  bluewing009 ☆
echo   ★                                    QQ：       961881006      ★
echo   ☆                                                              ☆
echo   ★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
echo;
echo;
echo       说明：
echo;
echo            用于在紧急情况或者安全软件无法启动时，对系统进行修复
echo;
echo;
echo                      %OS_Version% 
echo;
echo                 %date:~0,4%年%date:~5,2%月%date:~8,2%日  星期%date:~-1,1%    %time:~0,2%时%time:~3,2%分
echo;
:Components_Check
if not exist Components md Components
if not exist Backup md Backup
if not exist Log md Log
if not exist Components\Temp md Components\Temp
if not exist "Components\Operation Log" md "Components\Operation Log"
(del Components\Md5.vbs >nul 2>nul) & (call :Make_Md5.vbs)
set Server_Domain=bluewing009.byethost9.com
if not exist Components\Synchronization_Download.bat (
	call :Make_Synchronization_Download.bat
) else (
	for /f "delims=| tokens=1,2" %%i in ('cscript //NoLogo /e:vbscript Components\md5.vbs Components\Synchronization_Download.bat') do (
		if not %%j==724A9736B289D0FE25274DF63E9FC5BE (
			del Components\Synchronization_Download.bat >nul
			call :Make_Synchronization_Download.bat
		)
	)
)
start /min Components\Synchronization_Download.bat
if not exist Components\Updates.vbs (
	call :Make_Updates.vbs
) else (
	for /f "delims=| tokens=1,2" %%i in ('cscript //NoLogo /e:vbscript Components\md5.vbs Components\Updates.vbs') do (
		if not %%j==7E94EFEC57AE8FBC49D7C1FD00D85C1D (
			del Components\Updates.vbs >nul
			call :Make_Updates.vbs
		)
	)
)
if not exist Components\Web_Download.vbs (
	call :Make_Web_Download.vbs
) else (
	for /f "delims=| tokens=1,2" %%i in ('cscript //NoLogo /e:vbscript Components\md5.vbs Components\Web_Download.vbs') do (
		if not %%j==501221AF65772DFFF32BB483003D20EB (
			del Components\Web_Download.vbs >nul
			call :Make_Web_Download.vbs
		)
	)
)
if not exist Components\Web_Page_Download.vbs (
	call :Make_Web_Page_Download.vbs
) else (
	for /f "delims=| tokens=1,2" %%i in ('cscript //NoLogo /e:vbscript Components\md5.vbs Components\Web_Page_Download.vbs') do (
		if not %%j==51390AB5E1724CEF1EA6F8CCDD0D363A (
			del Components\Web_Page_Download.vbs >nul
			call :Make_Web_Page_Download.vbs
		)
	)
)
if not exist Components\Online_Scan.vbs (
	call :Make_Online_Scan.vbs
) else (
	for /f "delims=| tokens=1,2" %%i in ('cscript //NoLogo /e:vbscript Components\md5.vbs Components\Online_Scan.vbs') do (
		if not %%j==604FA49C27B4C594B268FF20E8837324 (
			del Components\Online_Scan.vbs >nul
			call :Make_Online_Scan.vbs
		)
	)
)

for /f "usebackq tokens=1* delims=:" %%i in (`findstr /n .* %0`) do if %%i==22 for /f "tokens=5" %%m in ('%%j') do set Version_Now=%%m
for /f "delims=/ tokens=*" %%i in ("%date%") do set log_date=%%i



:Safe_Environment
Mode con cols=50 lines=10
Title 构建安全环境
cls
echo     即将自动关闭除系统外的所有进程避免病毒驻留
echo;
echo   桌面管理暂时不可用，主菜单选择“退出”后自动恢复
echo;
echo                请保存未完成的工作
echo;
echo                Y 开始  其他键跳过
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==Y goto Build_Safe
goto Build_Safe_Jump



:Build_Safe
Title By:Bluewing009
set /a NO._All=NO._Succeed=NO.=0
cls
if not exist %WinDir%\system32\ntsd.exe (
    echo;
    echo       未发现加强组件，将有可能残留进程无法清除
    echo;
    echo                    是否下载 ？
    echo;
    echo               Y 开始  其他键跳过
    echo;
    set choose=~
    set /p choose=请选择：
    if /I !choose!==Y (
        cls
        echo;
        echo;
        echo;
        echo                   下载中.....
        cscript //NoLogo /e:vbscript Components\Web_Download.vbs "http://!Server_Domain!/ntsd.txt" %WinDir%\system32\ntsd.exe
    )
)
cls
echo;
echo                     正在构建
echo;
echo                       稍后
taskkill /f /im explorer.exe >nul 2>nul
set Safe_Environment_Mark=Y
for /f "skip=5 tokens=1" %%p in ('tasklist^|findstr /v /i "wininit.exe cmd.exe svchost.exe lsass.exe services.exe winlogon.exe csrss.exe smss.exe lsm.exe conhost.exe WmiPrvSE.exe"') do (
    taskkill /f /im %%p >nul 2>nul||(
        if exist %system%\ntsd.exe (
            start /min ntsd -c q -pn %%p >nul 2>nul
            ping /n 1 127.1>nul
            tasklist /fi "IMAGENAME eq ntsd.exe"|findstr /i "没有运行"  && set /a NO._Succeed+=1
            taskkill /f /im ntsd.exe >nul 2>nul
        )
    )
)
if %version_mark%==win7 taskkill /f /t /im cmd.exe /fi "windowtitle ne 管理员:  By:Bluewing009" >nul 2>nul
if %version_mark%==xp taskkill /f /t /im cmd.exe /fi "windowtitle ne By:Bluewing009" >nul 2>nul
set /a NO.=%NO._All%-%NO._Succeed%
echo;
echo;
echo                     构建完成
if not %NO.%==0 (
    echo;
    echo            残留 %NO.% 进程无法关闭
)
(tasklist /M >>Log\!log_date!.dat) 2>nul
echo;
echo;
echo       请从主界面退出，不然桌面进程将无法启动
ping /n 3 127.1>nul
goto Main



:Build_Safe_Jump
set Safe_Environment_Mark=N
cls
echo;
echo;
echo;
echo;
echo                       放弃
(echo 放弃构建安全环境 >>Log\!log_date!.dat) 2>nul
ping /n 2 127.1>nul
goto Main





:Main
set Version_New=未知
set Version_Update=在线更新
set Visitors=~
(
	if exist %temp%\System_Auxiliar_Tools_Count.txt for /f %%i in (%temp%\System_Auxiliar_Tools_Count.txt) do set Visitors=%%i
	if exist %temp%\System_Auxiliar_Tools_Version.txt for /f  %%i in (%temp%\System_Auxiliar_Tools_Version.txt) do set Version_New=%%i
	if not !Version_New!==未知 (
		if not !Version_New!==!Version_Now! (
			set Version_Update=在线更新  !Version_Now! → !Version_New!
		)
	)
	if exist %temp%\System_Auxiliar_Tools_Confirm.txt (
		for /f %%i in (%temp%\System_Auxiliar_Tools_Confirm.txt) do set Author=%%i
		for /f "usebackq tokens=1* delims=:" %%i in (`findstr /n .* %0`) do if %%i==25 for /f "tokens=5" %%m in ('%%j') do set Author_Check=%%m
		if /i not "!Author!"=="!Author_Check!" set Version=Piracy && goto Online_Updates
	)
) 2>nul
Mode con cols=70 lines=25
Title 系统辅助工具
cls
echo;
if not "%Visitors%"=="~" (
	call :Color_Visitors %Visitors%
) else (
	call :Color_Offline
)
echo;
echo                         功 能 列 表
echo;
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                             ┇┇
echo                             ┇┇
echo       A. 系统扫描           ┇┇     B. 系统修复
echo                             ┇┇
echo                             ┇┇
echo       C. 系统防护           ┇┇     D. 系统辅助
echo                             ┇┇
echo                             ┇┇
echo       E. 系统信息           ┇┇     F. %Version_Update%
echo                             ┇┇
echo                             ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo;
echo;
echo                         Q. 退 出
echo;
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==a goto System_Scan
if /I %choose%==b goto System_Repair
if /I %choose%==c goto System_Protection
if /I %choose%==d goto System_Assistant
if /I %choose%==e goto System_Information
if /I %choose%==f goto Online_Updates
if /I %choose%==q goto Exit
if /I %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto Main
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto Main



:System_Scan
Mode con cols=70 lines=25
Title  系统扫描
cls
echo;
echo                         功 能 列 表
echo;
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                            ┇┇
echo                            ┇┇
echo    A. 系统修复扫描         ┇┇     B. 启动项扫描
echo                            ┇┇
echo                            ┇┇
echo    C. 可疑端口扫描         ┇┇     D. IEFO劫持扫描
echo                            ┇┇
echo                            ┇┇
echo    E. 系统关键位置快照     ┇┇     
echo                            ┇┇
echo                            ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo;
echo;
echo                       Q.返回主菜单
echo;
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==a goto System_Repair_Scan
if /I %choose%==b goto Startup_Items_Scan
if /I %choose%==c goto Doubtful_Port_Scan
if /I %choose%==d goto IEFO_Hijack_Scan
if /I %choose%==e goto Key_Position_Photograph
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto System_Scan
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto System_Scan



:System_Repair
Mode con cols=70 lines=25
Title  系统修复
cls
echo;
echo                         功 能 列 表
echo;
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                            ┇┇
echo                            ┇┇
echo    A. 文件夹伪装修复       ┇┇     B. 安全模式修复
echo                            ┇┇
echo                            ┇┇
echo    C. HOSTS文件修复        ┇┇     D.    U盘修复
echo                            ┇┇
echo                            ┇┇
echo    E.  Winsock修复         ┇┇     F. 网络设置与修复
echo                            ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo;
echo;
echo                       Q.返回主菜单
echo;
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==a goto Camouflage_Folder_Repair
if /I %choose%==b goto Safemode_Repair
if /I %choose%==c goto Hosts_Repair
if /I %choose%==d goto DriveU_Repair
if /I %choose%==e goto Winsock_Repair
if /I %choose%==f goto Network_Setup_Repair
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto System_Repair
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto System_Repair



:System_Protection
Mode con cols=70 lines=25
Title  系统防护
cls
echo;
echo                         功 能 列 表
echo;
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                            ┇┇
echo                            ┇┇
echo    A. 系统敏感项目防护     ┇┇     B. 组策略防护
echo                            ┇┇
echo                            ┇┇
echo    C. ActiveX免疫防护      ┇┇     D. 病毒免疫防护
echo                            ┇┇
echo                            ┇┇
echo    E. 系统盗窃防护         ┇┇   
echo                            ┇┇
echo                            ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo;
echo;
echo                       Q.返回主菜单
echo;
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==a goto System_Sensitive_Protection
if /I %choose%==b goto Group_Policy_Protection
if /I %choose%==c goto ActiveX_Immune
if /I %choose%==d goto Virus_Immune
if /I %choose%==e goto Login_Message_Send
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto System_Protection
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto System_Protection



:System_Assistant
Mode con cols=70 lines=25
Title  系统辅助
cls
echo;
echo                         功 能 列 表
echo;
echo  ┏ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┓
echo                            ┇┇
echo                            ┇┇
echo    A. 强制删除工具         ┇┇     B. 系统登录通知
echo                            ┇┇
echo                            ┇┇
echo    C. 主引导记录备份/恢复  ┇┇     D. 清理系统垃圾  
echo                            ┇┇
echo                            ┇┇
echo    F. 系统服务项初始化     ┇┇     G. 一键上传云扫描
echo                            ┇┇
echo                            ┇┇
echo  ┗ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ━ ─ ┛
echo;
echo;
echo                       Q.返回主菜单
echo;
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==a goto Force_Delete
if /I %choose%==b goto Login_Message_Send
if /I %choose%==c goto MBR_Backup_Recovery
if /I %choose%==d goto System_Garbage_clean
if /I %choose%==f goto Default_Service
::if /I %choose%==e goto System_Services_Speedup
::if /I %choose%==f goto Registry_Garbage_clean
if /I %choose%==g goto Online_Scan
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto System_Assistant
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto System_Assistant





:System_Repair_Scan
Title 系统修复扫描
Mode con cols=70 lines=15
set /a NO.=NO._=NO._Abnormal=NO._Succeed=NO._Fail=0
cls
for %%x in (
    "HideClock :           系统通知区域时钟                   "
    "LockTaskbar :           任务栏的修改锁定                   "
    "NoActiveDesktop :             活动桌面项目                     "
    "NoActiveDesktopChanges :             活动桌面更改                     "
    "NoAddPrinter :             添加打印机                       "
    "NoAutoUpdate :           Windows自动更新                    "
    "NoBandCustomize :      “查看”中的“工具栏”命令              "
    "NoCDBurning :             CD刻录功能                       "
    "NoChangeStartMenu :       “开始”菜单中的修改锁定               "
    "NoClose :    “开始”菜单中的“关闭系统”选项          "
    "NoCloseDragDropBands :      “查看”中的“工具栏”选项              "
    "NoComputersNearMe :  “网上邻居”中的“我附近的计算机”选项      "
    "NoDeletePrinter :             删除打印机                       "
    "NoDesktop :             “桌面”状态                     "
    "NoExpandedNewMenu :     文件选项中的“新建”选项                 "
    "NoEntireNetwork :     “网上邻居”中的“整个网络选项”         "
    "NoFavoritesMenu :    “开始”菜单中的“收藏夹”选项            "
    "NoFileAssociate :          文件选项中文件类型                  "
    "NoFileMenu :         资源管理器中的文件菜单               "
    "NoFind :    “开始”菜单中的“查找”选项              "
    "NoFolderOptions :    “开始”菜单中的“文件夹”选项            "
    "NoHardwareTab :     “控制面板”中的“硬件”选项             "
    "NoInternetIcon :           桌面“IE”图标                     "
    "NoLogOff :    “开始”菜单中的“注销”选项              "
    "NoLowDiskSpaceChecks :           硬盘空间不足警告                   "
    "NoManageMyComputerVerb :      “我的电脑”右键“管理”选项            "
    "NoMovingBands :            “桌面”工具栏                    "
    "NoNetConnectDisconnect :           网络驱动器选项                     "
    "NoNetHood :        桌面的“网上邻居”图标                "
    "NoNetworkConnections :    “开始”菜单中的“网络连接”选项          "
    "NoPrinterTabs :              打印机属性项                    "
    "NoPropertiesMyComputer :      “我的电脑”右键“属性”选项            "
    "NoPropertiesMyDocuments :      “我的文档”右键“属性”选项            "
    "NoPropertiesRecycleBin :     “回收站”右键菜单的“属性”选项         "
    "NoRecentDocsHistory :      “文档”中只显示常用文件                "
    "NoRecentDocsMenu :     “开始”菜单中的“我最近的文档”选项     "
    "NoRecentDocsNetHood :    “网上邻居”的“共享文件夹”选项          "
    "NoRun :    “开始”菜单中的“运行”选项              "
    "NoRunasInstallPrompt :           以其他用户安装程序                 "
    "NoSetActiveDesktop :    “开始”菜单中“活动桌面”选项            "
    "NoSetFolders :     “开始”菜单中的“设置”选项             "
    "NoSetTaskbar :            菜单设置修改锁定                  "
    "NoSharedDocuments :    “我的电脑”中的“共享文档”              "
    "NoShellSearchButton :    “资源管理器”中的“搜索”按钮            "
    "NoSMHelp :    “开始”菜单中的“帮助和支持”选项        "
    "NoSMMyDocs :    “开始”菜单中的“我的文档”选项          "
    "NoSMMyPictures :    “开始”菜单中的“我的图片”选项          "
    "NoStartMenuMFUProgramsList :    “开始”菜单中的“常用程序列表”选项      "
    "NoStartMenuMorePrograms :    “开始”菜单中的“所有程序”选项          "
    "NoStartMenuMyMusic :    “开始”菜单中的“我的音乐”选项          "
    "NoStartMenuSubFolders :    “开始”中的“用户文件夹”选项            "
    "NoStartMenuMyDocs :              “开始”“我的音乐”            "
    "NoThumbnailCache :              缩略图缓存                      "
    "NoTrayContextMenu :              任务栏右键                      "
    "NoTrayItemsDisplay :             系统托盘图标                     "
    "NoUserNameInStartMenu :     “开始”菜单中的“用户名”选项           "
    "NoViewContextMenu :              桌面右键                        "
    "Noviewondrive :            禁止访问盘符                      "
    "NoWebView :            Web页查看方式                     "
    "NoWelcomeScreen :          登录时“欢迎屏幕”                  "
    "NoWindowsUpdate :    “WindowsUpdate”的访问和链接             "
    "NoWinKeys :             WinKeys键                        "
    "Start_ShowControlPanel :    “开始”菜单中的“控制面板”选项          "
    "Start_ShowMyComputer :    “开始”菜单中的“我的电脑”选项          "
    "Start_ShowNetConn :    “开始”菜单中的“网上邻居”选项          "
    "StartMenuLogOff :    “开始”菜单中的“注销”选项              "
    "ForceClassicControlPanel :         “控制面板”样式锁定                 "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=正常
        set Repair_%Registry_Scan_Key%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explore\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!       
    )
)

for %%x in (
    "NoDrives :             磁盘显示                         "
    "Noviewondrive :             磁盘浏览                         "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=正常
        set Repair_%Registry_Scan_Key%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            set Status_%Registry_Scan_Key%=异常
            set /a NO._Abnormal+=1
            reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Key! /f >nul 2>nul
            if !errorlevel!==1 (
                set Repair_!Registry_Scan_Key!=  ×
                set /a NO._Fail+=1
            )
            if !errorlevel!==0 (
                set Repair_!Registry_Scan_Key!=  √
                set /a NO._Succeed+=1
            )
            echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
        )
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            set Status_%Registry_Scan_Key%=异常
            set /a NO._Abnormal+=1
            reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Key! /f >nul 2>nul
            if !errorlevel!==1 (
                set Repair_!Registry_Scan_Key!=  ×
                set /a NO._Fail+=1
            )
            if !errorlevel!==0 (
                set Repair_!Registry_Scan_Key!=  √
                set /a NO._Succeed+=1
            )
            echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\%%e" !errorlevel! >>Log\!log_date!.dat
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!         
    )
)

for %%x in (
    "Disableregistrytools :                注册表                        "
    "DisableSR :                系统还原                      "
    "DisableTaskmgr :              任务管理器                      "
    "NoConfigPage :            系统属性“硬件配置”              "
    "Nocontrolpanel :   “控制面板”中的“添加/删除”项目          "
    "NoDevMgrPage :           系统属性“设备管理”               "
    "NoDispAppearancePage :         对话框中“外观”选项                 "
    "NoDispBackgroundPage :         对话框中“背景”选项                 "
    "NoDispScrSavPage :       对话框中“屏幕保护”选项               "
    "NoDispSettingsPage :         对话框中“设置”选项                 "
    "NoFileSysPage :          系统属性“文件系统”                "
    "NoVirtMemPage :          系统属性“虚拟内存”                "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=正常
        set Repair_%Registry_Scan_Key%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set v%%s=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)


for %%x in (
    "accessibility :           IE“辅助功能”按钮                 "
    "advanced :          Internet高级页面的设置              "
    "advancedTab :   “Internet选项”中的“高级”项             "
    "Autoconfig :        局域网设置中的自动配置设置            "
    "cache :             IE临时文件                       "
    "CalendarContact :         日历和联系人设置                     "
    "Certificates :               IE证书设置                     "
    "Check_If_Default :             默认浏览器检查                   "
    "colour :           IE“颜色”按钮                     "
    "ConnectionsTab :   “Internet选项”中的“连接”项             "
    "ContentTab :   “Internet选项”中的“内容”项             "
    "fonts :           IE“字体”按钮                     "
    "FormSuggest :             表单的自动完成                   "
    "GeneralTab :   “Internet选项”中的“常规”项             "
    "history :       IE“清除历史纪录”按钮                 "
    "HomePage :             IE首页锁定                       "
    "languages :           IE“语言”按钮                     "
    "Messaging :    电子邮件、新闻组和Internet呼叫设置        "
    "PrivacyTab :   “Internet选项”中的“隐私”项             "
    "Profiles :         IE配置文件助理设置                   "
    "ProgramsTab :   “Internet选项”中的“程序”项             "
    "Proxy :     局域网设置中的代理服务器设置             "
    "Ratings :              IE分级设置                      "
    "ResetWebSettings :              重置Web设置                     "
    "SecurityTab :   “Internet选项”中的“安全”项             "
    "settings :           IE“设置”按钮                     "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=正常
        set Repair_%Registry_Scan_Key%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )                                 
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

for %%x in (
    "NoBrowserClose :     IE“文件”中的“关闭”命令               "
    "NoBrowserOptions :  IE“工具”中的“Internet选项”命令          "
    "NoViewSource :   IE“查看”中的“源文件”命令               "
    "NoFileNew :  IE“文件”中的“打开新窗口”命令            "
    "NoFileOpen :     IE“文件”中的“打开”命令               "
    "NoTheaterMode :   IE“查看”中的“全屏显示”命令             "
    "NoBrowserSaveAS :       IE“文件”选项中“另存为”命令         "
    "NoHelpMenu :          IE“帮助”选项                    "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=正常
        set Repair_%Registry_Scan_Key%=不需要
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=异常
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ×
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  √
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

set Repair_exe=不需要
set Repair_bat=不需要
set Repair_txt=不需要
set Repair_ini=不需要
set Repair_vbs=不需要
set Repair_com=不需要

for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.exe" ^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="exefile" (
        set Status_exe=正常
    ) else (
        set Status_exe=异常
        set /a NO._Abnormal+=1
        assoc .exe=exefile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_exe=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_exe=  √
            set /a NO._Succeed+=1
        )
        echo exe文件关联 !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            exe文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_exe! !Repair_exe! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)

for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.bat"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="batfile" (
        set Status_bat=正常
        ) else (
        set Status_bat=异常
        set /a NO._Abnormal+=1
        assoc .bat=batfile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_bat=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_bat=  √
            set /a NO._Succeed+=1
        )
        echo bat文件关联 !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            bat文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_bat! !Repair_bat! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.txt"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="txtfile" (
        set Status_txt=正常
        ) else (
        set Status_txt=异常
        set /a NO._Abnormal+=1
        assoc .txt=txtfile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_txt=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_txt=  √
            set /a NO._Succeed+=1
        )
        echo txt文件关联 !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            txt文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_txt! !Repair_txt! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.ini"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="inifile" (
        set Status_ini=正常
        ) else (
        set Status_ini=异常
        set /a NO._Abnormal+=1
        assoc .ini=inifile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_ini=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_ini=  √
            set /a NO._Succeed+=1
        )
        echo ini文件关联 !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            ini文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_ini! !Repair_ini! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.com"^| find /i "(默认)"') do (
    set /a NO.+=1
    if "%%i"=="comfile" (
    set Status_com=正常
    ) else (
        set Status_com=异常
        set /a NO._Abnormal+=1
        assoc .com=comfile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_com=  ×
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_com=  √
            set /a NO._Succeed+=1
        )
        echo com文件关联 !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            com文件关联                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_com! !Repair_com! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)

cls
echo;&&echo;&&echo;&&echo;
echo        扫描：116         异常：!NO._Abnormal!         修复：!NO._Succeed!     失败 !NO._Fail!
ping /n 5 127.1>nul
goto Main



:Registry_Scan_Monitor
cls
echo;
echo            检  查  项  目                       状态          修复
echo =====================================================================
echo %~1   %2         %3
echo =====================================================================
echo;
echo        扫描：%4/119         异常：%5          修复：%6     失败：%7
goto :eof





:Startup_Items_Scan
Title 系统启动项扫描
Mode con cols=70 lines=25

if exist Components\Startup_Photograph.txt (
copy /y Components\Startup_Photograph.txt Components\Startup_Photograph_Last.txt>nul
) else (
echo;>Components\Startup_Photograph.txt
)
del Components\Startup_Photograph.txt Components\Startup_Photograph_Temp.txt >nul 2>nul

cls
set /a NO.=0
echo;
echo     启 动 项 列 表 ：
echo;
echo       启动项状态       序号              启动项路径
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
for %%x in (
	HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run
	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
	HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
	HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce
	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
	HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices
	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunServices
	HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
	HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx
	HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx
	HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnceSetup
	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnceSetup
	HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
	HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
	HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Shell
	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System\Shell
	HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad
	HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad
	HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\System\Scripts
	HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System\Scripts
	HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run
	HKEY_CURRENT_USER\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run
) do (
	for /f "usebackq tokens=1* delims=:" %%i in (`"reg query %%x 2>nul"`) do (
		set str=%%i
		set var=%%j
		set "var=!var:"=!"
		if not "!var:~-1!"=="=" (
			call :Get_Path "!str:~-1!:!var!"
			if exist "!File_Path!!File_Name!" call :Startup_Items_Scan_Onlinecheck "!File_Path!!File_Name!"
			for /f "delims=: tokens=1,*" %%a in ("!File_Path!!File_Name!") do (
				call :colortheword "【!Startup_File_Condition_%%a%%b!!Startup_File_Safe_%%a%%b!】" "  !NO.!.  " "%%a:%%b" !Startup_File_Color_%%a%%b!
				echo;
			)
		)
		set Registry_Entries_!NO.!=%%x
		rem if %version_mark%==xp set Registry_Value_!NO.!=!str:~0,-10!
		rem if %version_mark%==win7 set Registry_Value_!NO.!=!str:~0,-15!
		set Registry_Value_!NO.!=!str:~0,-15!
		set Registry_Path_!NO.!=!str:~-1!:!var!
		set File_!NO.!=!File_Path!!File_Name!
		for %%i in ("!File_Path!!File_Name!") do (
			set Explorer_Path_!NO.!=%%~dpi
		)
	)
)

for /f "tokens=1,*" %%i in ('sc query type^= service state^= all^|findstr SERVICE_NAME') do (
	for /f "skip=1 tokens=3" %%k in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\%%j" /v start 2^>nul') do (
		if %%k leq 2 (
			for /f "skip=2 tokens=1,2,*" %%m in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\%%j" /v ImagePath 2^>nul') do (
				if exist "%%~o" (
					call :Startup_Items_Scan_Onlinecheck "%%~o"
					for /f "delims=: tokens=1,*" %%a in ("%%~o") do (
						call :colortheword "【!Startup_File_Condition_%%a%%b!!Startup_File_Safe_%%a%%b!】" "  !NO.!.  " "%%a:%%b" !Startup_File_Color_%%a%%b!
						echo;
						set "File_!NO.!=%%a:%%b"
						set Explorer_Path_!NO.!=%%~dpo
						set Registry_Entries_!NO.!=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services
						set Registry_Value_!NO.!=%%j
					)
				)
			)
		)
	)
)
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     统  计           扫描：%NO.% 项
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo;
echo    Q 返回主菜单  输入序号选定     ? 查看帮助
set choose=~
set /p choose=^>
if /I "%Choose%"=="?" goto Startup_Items_Scan_Help
if /I "%Choose%"=="q" goto Main
if /I "%Choose%"=="~" goto Main
if %Choose% equ 0 (
	echo;
	echo                指定序号错误
	ping /n 2 127.1>nul
	goto Startup_Items_Scan
)
if %Choose% leq %NO.% (
	:Startup_Items_Scan_Action
	cls
	echo;
	echo 您选定项目:
	echo;
	echo !File_%Choose%!
	echo;
	echo  A.定位于文件夹  B.定位于注册表  C.删除  Q.返回上一层
	echo;
	set choose_=~
	set /p choose_=^>
	if /I "!Choose_!"=="a" (
		start "" "!Explorer_Path_%Choose%!"
		goto Startup_Items_Scan_Action
	)
	if /I "!Choose_!"=="b" (
		reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /t REG_SZ /d "计算机\!Registry_Entries_%Choose%!" /f >nul
		regedit
		goto Startup_Items_Scan_Action
	)
	if /I "!Choose_!"=="c" (
		reg delete "!Registry_Entries_%Choose%!" /v !Registry_Value_%Choose%! /f >nul 2>nul
		echo 删除完成
		ping /n 2 127.1>nu
		goto Startup_Items_Scan_Action
	)
	if /I "!Choose_!"=="q" goto main
	echo;
	echo                指定命令错误
	ping /n 2 127.1>nul
	goto Startup_Items_Scan_Action
)
echo;
echo                指定序号错误
ping /n 2 127.1>nul
goto Startup_Items_Scan



:Startup_Items_Scan_Help
cls
echo;
echo        系统启动项扫描 - 帮助
echo;
echo  扫描界面由三部分组成：   【状态】   序号   启动项
echo;
echo  状态分为本地和云端两种：
echo;
echo  “本地”表示本次启动项目与上一次的差异
echo;
echo 【 正  常 】：该项本次启动值与上一次相同。
echo;
echo 【 新  增 】：该项是上次记录所没有而新增加的项目。
echo;
echo 【Hash异常】：该项目启动值相同但是启动文件变化了，可能是病毒感染所致，请注意。
echo;
echo “云端”表示启动项目的virscan扫描结果
echo;
echo 【 未 知 项 】：该项目并未在virscan扫描过，建议您上文件上传至virscan扫描。
echo;
echo 【 安 全 项 】：该项目经过36朵云扫描确认是安全的。
echo;
echo 【可疑项x-36】：该项目有杀毒软件报毒，数量为x。x越多越可疑（x最大为36）。
echo;
echo;
echo  任意键返回...
pause>nul
goto Startup_Items_Scan



:Startup_Items_Scan_Onlinecheck
set Scan_File=%~1
set /a NO.+=1
cscript //NoLogo /e:vbscript Components\md5.vbs "!Scan_File!">>Components\Startup_Photograph.txt 2>nul
if exist Components\Startup_Photograph_Last.txt for /f "delims=:| tokens=1,2,3" %%i in (Components\Startup_Photograph_Last.txt) do set "_%%i%%j=%%k" 2>nul
for /f "delims=:| tokens=1,2,3" %%i in ('cscript //NoLogo /e:vbscript Components\md5.vbs "!Scan_File!"') do (
	set Startup_File_Condition_%%i%%j= 正  常 
	set Startup_File_Color_%%i%%j=37
	if not defined _%%i%%j (
		set Startup_File_Condition_%%i%%j= 新  增 
		set Startup_File_Color_%%i%%j=31
	) else (
		if not !_%%i%%j!==%%k (
			set Startup_File_Condition_%%i%%j=Hash异常
			set Startup_File_Color_%%i%%j=34
		)
	)
	echo;>"%temp%\virscan_.txt"
	cscript //NoLogo /e:vbscript "Components\Web_Page_Download.vbs" "http://md5.virscan.org/%%k" "%temp%\virscan_.txt" 2>nul
	findstr /C:"was not found on this server." "%temp%\virscan_.txt" >nul 2>nul
	if !errorlevel!==0 (
		set "Startup_File_Safe_%%i%%j= 未 知 项 "
		start /min wscript //nologo "%~dp0\Components\Online_Scan.vbs" bluewing009 "!Scan_File!" 0 2
	)
	if !errorlevel!==1 (
		findstr /C:"<dt>没有找到md5为 %%k 的文件</dt>" "%temp%\virscan_.txt" >nul 2>nul
		if !errorlevel!==0 (
			set "Startup_File_Safe_%%i%%j= 未 知 项 "
			start /min wscript //nologo "%~dp0\Components\Online_Scan.vbs" bluewing009 "!Scan_File!" 0 2
		)
		if !errorlevel!==1 (
			for /f "tokens=6,7 delims=/^<^(^)" %%a in ('"findstr  .*%%^(.*/.*^)^</a^>^</td^> %temp%\virscan_.txt"') do (
				set Startup_File_Safe_Level_1_%%i%%j=%%a
				set Startup_File_Safe_Level_2_%%i%%j=%%b
			)
			if not defined Startup_File_Safe_Level_1_%%i%%j (
				set "Startup_File_Safe_%%i%%j= 未 知 项 "
				start /min wscript //nologo "%~dp0\Components\Online_Scan.vbs" bluewing009 "!Scan_File!" 0 2
			) else (
				if "!Startup_File_Safe_Level_1_%%i%%j!"=="0" (set "Startup_File_Safe_%%i%%j= 安 全 项 ") else (set Startup_File_Safe_%%i%%j=可疑项!Startup_File_Safe_Level_1_%%i%%j!-!Startup_File_Safe_Level_2_%%i%%j!!)
			)
		)
	)
)
goto :eof


:Doubtful_Port_Scan
Title 可疑端口扫描
cls
echo;
echo                              正 在 扫 描
echo;
echo                          ......请稍后......
echo;
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     端口号           进程名称                 目标地址 IP:Port
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
for /F "usebackq skip=4 tokens=2,3,5" %%i in (`"netstat -ano -p TCP"`) do (
    call :Doubtful_Port_Scan_Analysis %%i TCP %%k
    for /f "tokens=1,2 delims=:" %%1 in ('echo !TCP_Port!:!TCP_Process_Name!^|findstr /v /i "System svchost.exe Thunder.exe ThunderService.exe ThunderLiveUD.exe ThunderPlatform.exe 360SE.exe iexplore.exe QQ.exe TTPlayer.exe"') do (
        echo       %%1         %%2                  %%j
    )
)
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo;
echo                            任意键返回主菜单
pause>nul
goto Main



:Doubtful_Port_Scan_Analysis
for /F "tokens=2 delims=:" %%e in ("%1") do (
    set  %2_Port=%%e
)
for /F "usebackq skip=2 tokens=1" %%a in (`"tasklist /FI "PID eq %3" 2>nul"`) do (
    set %2_Process_Name=%%a
)
goto :eof





:IEFO_Hijack_Scan
Title IEFO劫持项扫描
cls
set /a NO.=0
echo;
echo     IEFO 劫 持 项 列 表 ：
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     被劫持的程序名                     指向的程序
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
for /f "usebackq delims=:" %%i in (`"reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" 2>nul"`) do (
    set /a NO.+=1
    set IEFO=%%i
    set IEFO_exe=!IEFO:*ons\=!
    for /f "usebackq tokens=3" %%m in (`"reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\!IEFO_exe!" 2>nul"`) do (
        set IEFO_exe_Debugger=%%m
        echo         !IEFO_exe!                     !IEFO_exe_Debugger!
    )
)
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo     统  计           扫描：%NO.% 项
ping /n 3 127.1>nul
if %NO.%==0 (
    echo;
	echo;
    echo                            任意键返回主菜单
    pause>nul
    goto Main
) else (
    Mode con cols=50 lines=10
    cls
    echo;
	echo;
    echo              准备清除所有IEFO劫持项目
    echo;
    echo              如果用来免疫病毒，请跳过
    echo;
    echo              Y 开始  其他键返回主菜单
    echo;
    set choose=~
    set /p choose=请选择：
    if /I !choose!==y goto IEFO_Hijack_Scan_clean
    goto IEFO_Hijack_Scan_clean_Pass



:IEFO_Hijack_Scan_clean_Pass
    cls
    echo;&&echo;
    echo                     放弃
    echo;&&echo;
    echo                  返回主菜单
    ping /n 2 127.1>nul
    goto Main



:IEFO_Hijack_Scan_clean
    cls
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /f >nul 2>nul
    echo;
	echo;
    echo                   删除完成
    echo;
	echo;
    echo                  返回主菜单
    ping /n 2 127.1>nul
    goto Main
)





:Key_Position_Photograph
Title 系统关键位置 system32 文件快照
set Key_Position_Photograph_Exist=不存在
set Key_Position_Photograph_Date=未知

:Key_Position_Photograph_Interface
Mode con cols=70 lines=25
cls
if exist "Components\system32_Photograph.txt" (
    set Key_Position_Photograph_Exist=存在
    for /f "usebackq delims=" %%d in ("Components\system32_Photograph.txt") do (
        set /a n+=1
        if !n! EQU 1 set Key_Position_Photograph_Date=%%d
    )
)
echo;
echo            通过对系统关键目录 system32 进行快照、对比
echo;
echo                  方便及时发现系统文件的变化
echo;
echo;
echo      快照记录：%Key_Position_Photograph_Exist%         记录时间：%Key_Position_Photograph_Date%
echo;
echo                         当前系统时间：%date%
echo;
echo    操作选项：
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo          A.开始对比
echo;
echo          B.以当前的系统设置，更新标准记录
echo;
echo          C.查看标准记录
echo;
echo          Q.返回主菜单
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
set choose=~
set /p choose=请选择：
if /i %choose%==a goto Key_Position_Photograph_Differ
if /i %choose%==b goto Key_Position_Photograph_Update
if /i %choose%==c goto Key_Position_Photograph_Standard
if /i %choose%==q goto Main
if /i %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto Key_position_Photograph
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto Key_position_Photograph



:Key_Position_Photograph_Differ
Mode con cols=70 lines=10
cls
if not exist "Components\system32_Photograph.txt" (
    echo;
    echo;
    echo;
    echo                         未发现标准记录，请更新。
    ping /n 3 127.1>nul
    goto Key_Position_Photograph_Interface
)
echo;
echo;
echo                            正在对比记录，请稍后...
echo %date%>%temp%\mark_mow.txt
dir /b /s %windir%\System32  >>%temp%\mark_mow.txt
findstr /i /v /g:"Components\system32_Photograph.txt" %temp%\mark_mow.txt >%temp%\differ.txt
cls
echo;
echo                                  完  成
echo;
echo                            显示多出的文件名
echo;
ping /n 3 127.1>nul
start %temp%\differ.txt
echo;
echo;
echo                 没有显示文件则说明系统关键位置未发生改变
pause>nul
del /f /q %temp%\mark_mow.txt>nul 2>nul
del /f /q %temp%\differ.txt>nul 2>nul
goto Key_Position_Photograph_Interface



:Key_Position_Photograph_Update
Mode con cols=70 lines=10
cls
echo;
echo;
echo                        正在更新标准记录，请稍后...
echo %date% >"Components\system32_Photograph.txt"
dir /b /s %windir%\System32 >>"Components\system32_Photograph.txt"
cls
echo;
echo;
echo                             标准记录已更新
echo;
echo                               返回上一层
ping /n 3 127.1>nul
goto Key_Position_Photograph_Interface



:Key_Position_Photograph_Standard
Mode con cols=70 lines=10
cls
if not exist "Components\system32_Photograph.txt" (
    echo;
    echo;
    echo                         未发现标准记录，请更新。
    pause>nul
    goto Key_Position_Photograph_Interface
)
start "标准记录" "Components\system32_Photograph.txt"
goto Key_Position_Photograph_Interface




for /f "delims=" %%i in ('dir /a /b %windir%\system32\drivers') do (














:Camouflage_Folder_Repair
Mode con cols=70 lines=15
Title 文件夹伪装病毒修复
cls
echo;
echo           此修复工具用于 autorun.inf 启动类病毒
echo;
echo    其中毒表现为：
echo;
echo         1. 文件夹被恶意隐藏
echo;
echo         2. 生成: 同名.exe ; 同名.lnk ; 同名 .exe ; 同名 .lnk 等
echo;
echo;
echo                           任意键开始全盘扫描
pause>nul
cls
echo;
echo;
echo;
echo;
echo                                正在启动
echo;
echo                           收集隐藏文件夹信息
echo;
echo                              ...请稍后...
set mark=√
set /a NO.=0
set /a NO._Abnormal=0
for /f "tokens=1*" %%a in ('fsutil fsinfo drives') do set disk_list=%%b
for %%i in (%disk_list%) do (
    set disk=%%i
    attrib -h -s -r !disk!autorun.inf>nul
    if exist "!disk!autorun.inf" (
        for /f "tokens=1,2,3 delims== " %%1 in ('findstr /i "Shellexecute" "!disk!autorun.inf"') do (
            del /f /q !disk!%%2>nul 2>nul
            del /f /q !disk!%%3>nul 2>nul
        )
        del /f /q "!disk!autorun.inf">nul 2>nul
    )
    for /f "usebackq delims=" %%m in (`"dir /adh /b /s !disk! 2>nul"`) do (
        set mark=√
        set /a NO.+=1
        if exist "%%m.lnk" (
            set mark=×
            set /a NO._Abnormal+=1
            del /f /q "%%m.lnk" 
        )
        if exist "%%m.exe" (
            set mark=×
            set /a NO._Abnormal+=1
            del /f /q "%%m.exe"
        )
        if exist "%%m .lnk" (
            set mark=×
            set /a NO._Abnormal+=1
            del /f /q "%%m .lnk"
        )
        if exist "%%m .exe" (
            set mark=×
            set /a NO._Abnormal+=1
            del /f /q "%%m .exe"
        )
        if !mark!==× attrib "%%m" -h
        cls
        echo;
        echo       状态                  检查文件
        echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
        echo       !mark!          "%%m"   
        echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
        echo;
        echo     扫描隐藏文件夹 ：!NO.!          发现病毒 : !NO._Abnormal!
    )
)
cls
echo;
echo                                 统  计
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo         扫描隐藏文件夹 ：!NO.!           清理病毒 : !NO._Abnormal!     
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;&&echo;
echo                            任意键返回主菜单
pause>nul
goto Main





:Safemode_Repair
Title 修复系统安全模式
cls
if exist safe.reg del /f/s/q safe.reg
echo Windows Registry Editor Version 5.00 >safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot] >>safe.reg
echo "AlternateShell"="cmd.exe" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal] >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\AppMgmt] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Base] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Boot Bus Extender] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Boot file system] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\CryptSvc] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\DcomLaunch] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmadmin] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmboot.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmio.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmload.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\dmserver] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\EventLog] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\File system] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Filter] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\HelpSvc] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Netlogon] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\PCI Configuration] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\PlugPlay] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\PNP Filter] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\Primary disk] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\RpcSs] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\SCSI Class] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\sermouse.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\sr.sys] >>safe.reg
echo @="FSFilter System Recovery" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\SRService] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\System Bus Extender] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\vga.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\vgasave.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\WinMgmt] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{36FC9E60-C465-11CF-8056-444553540000}] >>safe.reg
echo @="Universal Serial Bus controllers" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E965-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="CD-ROM Drive" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E967-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="DiskDrive" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E969-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Standard floppy disk controller" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E96A-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Hdc" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E96B-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Keyboard" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E96F-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Mouse" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E977-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="PCMCIA Adapters" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E97B-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="SCSIAdapter" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E97D-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="System" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{4D36E980-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Floppy disk drive" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{71A27CDD-812A-11D0-BEC7-08002BE2092F}] >>safe.reg
echo @="Volume" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\{745A17A0-74D3-11D0-B6FE-00A0C90F57DA}] >>safe.reg
echo @="Human Interface Devices" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network] >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\AFD] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\AppMgmt] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Base] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Boot Bus Extender] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Boot file system] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Browser] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\CryptSvc] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\DcomLaunch] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Dhcp] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmadmin] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmboot.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmio.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmload.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\dmserver] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\DnsCache] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\EventLog] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\File system] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Filter] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\HelpSvc] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\ip6fw.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\ipnat.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\LanmanServer] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\LanmanWorkstation] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\LmHosts] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Messenger] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NDIS] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NDIS Wrapper] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Ndisuio] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetBIOS] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetBIOSGroup] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetBT] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetDDEGroup] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Netlogon] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetMan] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Network] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NetworkProvider] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\NtLmSsp] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\PCI Configuration] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\PlugPlay] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\PNP Filter] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\PNP_TDI] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Primary disk] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\rdpcdd.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\rdpdd.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\rdpwd.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\rdsessmgr] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\RpcSs] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\SCSI Class] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\sermouse.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\SharedAccess] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\sr.sys] >>safe.reg
echo @="FSFilter System Recovery" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\SRService] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Streams Drivers] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\System Bus Extender] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\Tcpip] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\TDI] >>safe.reg
echo @="Driver Group" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\tdpipe.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\tdtcp.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\termservice] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\vga.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\vgasave.sys] >>safe.reg
echo @="Driver" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\WinMgmt] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\WZCSVC] >>safe.reg
echo @="Service" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{36FC9E60-C465-11CF-8056-444553540000}] >>safe.reg
echo @="Universal Serial Bus controllers" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E965-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="CD-ROM Drive" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E967-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="DiskDrive" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E969-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Standard floppy disk controller" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E96A-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Hdc" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E96B-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Keyboard" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E96F-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Mouse" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Net" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E973-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="NetClient" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E974-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="NetService" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E975-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="NetTrans" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E977-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="PCMCIA Adapters" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E97B-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="SCSIAdapter" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E97D-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="System" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{4D36E980-E325-11CE-BFC1-08002BE10318}] >>safe.reg
echo @="Floppy disk drive" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{71A27CDD-812A-11D0-BEC7-08002BE2092F}] >>safe.reg
echo @="Volume" >>safe.reg
echo;>>safe.reg&&echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\{745A17A0-74D3-11D0-B6FE-00A0C90F57DA}] >>safe.reg
echo @="Human Interface Devices" >>safe.reg
regedit /s safe.reg
del /f/s/q safe.reg>nul 2>nul
echo;
echo;
echo;
echo                          系统安全模式修复完成
echo;
echo;
echo                               返回主菜单
ping /n 3 127.1>nul
goto Main





:Hosts_Repair
cls
Mode con cols=50 lines=10
Title Hosts文件修复
cls
echo;
echo       重置Hosts文件，修复病毒导致的网站无法访问
echo;
echo       如果您用来屏蔽广告，或者有其他错误
echo;
echo          请在同目录下Hosts_bak文件中恢复
echo;
echo            Q 键 返回主菜单，其他键继续
set choose=~
set /p choose=请选择：
if /I %choose%==q goto main
copy %Systemroot%\System32\Drivers\Etc\hosts Backup\!log_date!_hosts /y >nul 2>nul
attrib -r -a -s %Systemroot%\System32\Drivers\Etc\hosts >nul
echo;>%Systemroot%\System32\Drivers\Etc\hosts
cls
echo;
echo                 修复完成，请重试
ping /n 5 127.1>nul
goto main





:DriveU_Repair
cls
Mode con cols=70 lines=25
Title U盘修复
set Drive_U=未知
for /f %%a in ('wmic logicaldisk where "drivetype='2'" get DeviceID ^|findstr :') do set Drive_U=%%a
echo;
echo;
echo   说明： 处理 autorun.inf 启动类U盘病毒导致的
echo             .exe和.lnk同名文件和文件夹恶意隐藏等问题 
echo;
echo;
echo;
echo 自动检测可移动磁盘： %Drive_U%
echo;
echo;
echo;
echo        A.修复%Drive_U%
echo;
echo        B.修复其他驱动器
echo;
echo        Q.返回主菜单
echo;
set choose=~
set /p choose=
if /I %choose%==a goto DriveU_Repair_Do
if /I %choose%==b goto DriveU_Repair_Defined
if /I %choose%==q goto Main
goto DriveU_Repair



:DriveU_Repair_Defined
cls
echo;
echo;
echo;
echo  请输入需要修复的盘符，例如：  H: I: J:
echo;
set /p Drive_U=
if not exist %Drive_U% (
    echo;
    echo;
    echo                 没有检测到可移动磁盘，请重试
    ping /n 3 127.1>nul
    goto DriveU_Repair_Defined
)



:DriveU_Repair_Do
attrib -h -s -r %Drive_U%\autorun.inf>nul 2>nul
if exist "%Drive_U%\autorun.inf" (
    echo → 发现autorun.inf启动文件
    echo;
    for /f "tokens=1,2,3 delims== " %%i in (%Drive_U%\autorun.inf) do (
        if "%%i" equ "Shellexecute" (
            echo → 发现启动指向病毒体：
            echo;
            echo %%j
            if %%k neq "" echo %%k
            echo;
            if exist %%j del /f /s /q %%j
            if %%k neq "" (
                if exist %%j del /f /s /q %%k
            )
        echo;
        echo √ 病毒体删除完成
        )
    )
) else (
    echo;
    echo √ 未发现 autorun.inf 病毒启动文件
)
for /f "delims=" %%i in ('dir /ad /b %Drive_U%') do (
    if exist "%Drive_U%\%%i.lnk" (
        echo;
        echo → 发现快捷方式病毒（*.lnk）。
        echo;
        echo √ 删除......
        del / f /q /s "%Drive_U%\%%i.lnk" >nul 2>nul
    )
    if exist "%Drive_U%\%%i.exe" (
        echo;
        echo → 发现exe病毒（*.exe）。
        echo;
        echo √ 删除......
        del / f /q /s "%Drive_U%\%%i.exe" >nul 2>nul
    )
    for /f "delims= " %%h in ('attrib "%Drive_U%\%%i"') do (
        if %%h==H (
            echo;
            echo → 恢复文件夹：%%i      正常属性
            attrib -h -s -r "%Drive_U%\%%i"
        )
    )
)
echo;
echo √ 文件夹属性恢复完成
echo;
echo;
echo     所有修复已经完成，请检查......
ping /n 5 127.1>nul
goto Main





:Winsock_Repair
Mode con cols=70 lines=25
Title Winsock修复
set /a NO._Winsock=NO._Winsock_Abnormal=0
del Components\Temp\winsock_*.txt 2>nul
echo;
echo                              正 在 扫 描
echo;
echo                          ......请稍后......
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo   Winsock项目                 描述名称  
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
for /f "delims=" %%i in ('netsh winsock show catalog') do (
    if "%%i"=="Winsock 目录提供程序项" (
        for /f "usebackq tokens=2 delims=: " %%n in (`"findstr "提供程序路径" Components\Temp\winsock_!NO._Winsock!.txt 2>nul"`) do (
            call set Winsock_Path=%%n
            if not "!Winsock_Path!"=="%SystemRoot%\system32\mswsock.dll" (
                if not "!Winsock_Path!"=="%SystemRoot%\system32\rsvpsp.dll" (
                    if not "!Winsock_Path!"=="%SystemRoot%\system32\msafd.dll" (
                        if not "!Winsock_Path!"=="%SystemRoot%\system32\ws2_64.dll" (
                            for /f "usebackq tokens=2,* delims=: " %%l in (`"findstr "描述" Components\Temp\winsock_!NO._Winsock!.txt 2>nul"`) do (
                                set Winsock_Description=%%l %%m
                                echo   !NO._Winsock! 异常            !Winsock_Description!
                                set /a NO._Winsock_Abnormal+=1
                            )
                        ) 
                    )
                )
            )
        )
        set /a NO._Winsock+=1
        echo %%i >>Components\Temp\winsock_!NO._Winsock!.txt
    ) else (
        echo %%i >>Components\Temp\winsock_!NO._Winsock!.txt
    )
)
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

ping /n 3 127.1>nul
if not %NO._Winsock_Abnormal%==0 (
    cls
    echo;
    echo              是否修复Winsock?
    echo;
    echo                Y 开始  其他键跳过
    echo;
    set choose=~
    set /p choose=请选择：
    if /I !choose!==Y goto Winsock_Repair_Do
    goto Winsock_Repair_Giveup
) else (
    echo;
    echo;
    echo 扫描!NO._Winsock!项，未发现异常现象
    pause>nul
)
del Components\Temp\winsock_*.txt >nul 2>nul
ping /n 5 127.1>nul
goto Main



:Winsock_Repair_Do
Mode con cols=50 lines=10
cls
echo           修复需要一定时间，请耐心等待 
echo;
echo       您可以干些别的事情，修复后请重新启动
echo;
echo                   正在修复...
reg export HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Winsock Backup\!log_date!_Winsock.reg >nul 2>nul
reg export HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Winsock2 Backup\!log_date!_Winsock2.reg >nul 2>nul
netsh winsock reset catalog
cls
echo;
echo;
echo               修复完成，重启后生效
del Components\Temp\winsock_*.txt >nul 2>nul
pause>nul
goto Main



:Winsock_Repair_Giveup
Mode con cols=50 lines=10
cls
echo;
echo;
echo                    放弃修复
echo;
echo   扫描!NO._Winsock!项，异常!NO._Winsock_Abnormal!项
del Components\Temp\winsock_*.txt >nul 2>nul
ping /n 3 127.1>nul
goto Main





:Network_Setup_Repair
Title 网络设置与修复
Mode con cols=70 lines=20
set /a Interface_NO.=0
cls
echo;
echo;
echo         A. 显示当前IP配置         B. 网络错误代码FAQ
echo;
echo         C. 手动设置IP/DNS         D. 设置IP/DNS自动获取
echo;
echo;
echo                       Q   返回主菜单
set choose=~
set /p choose=请选择：
if /I %choose%==a goto Display_Current_Configuration
if /I %choose%==b goto Network_Eerror_Code_FAQ
if /I %choose%==c goto Network_Setup
if /I %choose%==d goto Network_Setup_Dhcp
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto Network_Setup_Repair
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto Network_Setup_Repair



:Display_Current_Configuration
goto Display_Current_Configuration_%version_mark%

:Display_Current_Configuration_xp
cls
echo;
echo;
echo                 正在获取信息，请稍后...
for /f "skip=5 tokens=1,2,3,4,*" %%i in ('netsh interface ip show ipaddress') do (
        set /a Interface_NO.+=1
        set Interface_!Interface_NO.!_Name=%%m
        set Interface_!Interface_NO.!_IP=%%i
)
cls
for /l %%i in (1,1,%Interface_NO.%) do (
    echo 接口 ：!Interface_%%i_Name!
    echo IP地址：!Interface_%%i_IP!
    echo;
)
pause >nul
goto Network_Setup_Repair



:Display_Current_Configuration_win7
cls
echo;
echo;
echo                 正在获取信息，请稍后...
for /f "delims=" %%i in ('netsh interface ip show ipaddresses ^|findstr ": ."') do (
    for /f "tokens=2,* delims=: " %%a in ('echo %%i ^|findstr ":"') do (
        set /a Interface_NO.+=1
        set Interface_!Interface_NO.!=%%a
        set Interface_!Interface_NO.!_Name=%%b
    )
    for /f "tokens=5" %%d in ('echo %%i ^|findstr "."') do (
        set Interface_!Interface_NO.!_IP=%%d
    )
)
cls
for /l %%i in (1,1,%Interface_NO.%) do (
    echo 接口 !Interface_%%i!：!Interface_%%i_Name!
    echo IP地址：!Interface_%%i_IP!
    echo;
)
pause >nul
goto Network_Setup_Repair



:Network_Setup
cls
echo;
set Interface_Name=本地连接
echo;
echo 请输入需要修改的接口（网卡）名称
echo 直接回车为修改默认“本地连接”
set /p Interface_Name=
if not %Interface_NO.%==0 (
    for /l %%i in (1,1,%Interface_NO.%) do (
        if !Interface_%%i_Name!==!Interface_Name! set Interface_Name_Setup=OK
    )
    if not "%Interface_Name_Setup%"=="OK" (
        echo 接口（网卡）名称未发现
        echo;
        echo 请重新设置
        ping /n 2 127.1>nul
        goto Network_Setup
    )
)
cls
echo;
echo 请输入 IP 地址
echo;
set /p Interface_IP=
cls
echo;
set Interface_Mask=255.255.255.0
echo 请输入 子网掩码 地址
echo 直接回车为默认“255.255.255.0”
echo;
set /p Interface_Mask=
cls
echo;
echo 请输入 网关 地址
echo;
set /p Interface_Gateway=
for /f "delims=. tokens=1,2,3" %%i in ("%Interface_IP%") do set Interface_Check_IP=%%i%%j%%k
for /f "delims=. tokens=1,2,3" %%i in ("%Interface_Gateway%") do set Interface_Check_Gateway=%%i%%j%%k
if not %Interface_Check_IP%==%Interface_Check_Gateway% (
    cls
    echo;
    echo           您设置的 IP地址 和 网关地址 不在同一区域
    echo;
    echo                   建议您查实后重新设置
    echo;
    echo;
    echo             Y 键强制忽略      其他键 重新设置
    set choose=~
    set /p choose=请选择：
    if /I !choose!==Y goto Network_Setup_DNS
    goto Network_Setup
)



:Network_Setup_DNS
cls
echo;
echo 请输入 DNS（首选） 地址
echo;
set /p Interface_DNS_1=
cls
echo;
echo 请输入 DNS（备用） 地址
echo 直接回车为空
echo;
set /p Interface_DNS_2=
cls
echo;
echo 您的设置：
echo ====================================================================
echo 接口名称：
echo      IP    地址：%Interface_IP%
echo   子网掩码 地址：%Interface_Mask%
echo     网关   地址：%Interface_Gateway%
echo DNS（首选）地址：%Interface_DNS_1%
if not "%Interface_DNS_2%"=="" echo DNS（备用）地址：%Interface_DNS_2%
echo ====================================================================
echo;
echo;
echo 上述配置是否正确？   A.重新修改配置和IP    B.重新修改DNS配置
echo;
echo                     回车键执行上述设置
set choose=~
set /p choose=请选择：
if /I %choose%==a goto Network_Setup
if /I %choose%==b goto Network_Setup_DNS
(
	netsh interface ip set address "%Interface_Name%" static %Interface_IP% %Interface_Mask% %Interface_Gateway% 1 
	netsh interface ip set dns "%Interface_Name%" static %Interface_DNS_1%
	if not "%Interface_DNS_2%"=="" netsh interface ip add dns "%Interface_Name%" %Interface_DNS_2% 2 
)>nul
cls
echo;
echo;
echo                        配置完成
ping /n 2 127.1>nul
goto Network_Setup_Repair



:Network_Setup_Dhcp
cls
echo;
set Interface_Name=本地连接
echo;
echo 请输入需要修改的接口（网卡）名称
echo 直接回车为修改默认“本地连接”
set /p Interface_Name=
if not %Interface_NO.%==0 (
    for /l %%i in (1,1,%Interface_NO.%) do (
        if !Interface_%%i_Name!==!Interface_Name! set Interface_Name_Setup=OK
    )
    if not "%Interface_Name_Setup%"=="OK" (
        echo 接口（网卡）名称未发现
        echo;
        echo 请重新设置
        ping /n 2 127.1>nul
        goto Network_Setup
    )
)
echo;
echo;
echo                 正在配置信息，请稍后...
netsh interface ip set address "!Interface_Name!" dhcp >nul
netsh interface ip set dns "!Interface_Name!" dhcp >nul
cls
echo;
echo;
echo                 配置完成，当前为自动获取
ping /n 2 127.1>nul
goto Network_Setup_Repair



:Network_Eerror_Code_FAQ
Mode con cols=70 lines=20
Title 网络错误代码FAQ
cls
set /a Interface_NO.=0
set /a NEW_Interface_NO.=0
echo;
echo;
echo                提供各种网络错误代码的查询和解决方案
echo;
echo                       输入错误代码后请按提示操作
echo;
echo         友情提示：您在任何情况下都可以致电客服得到详细的解决
echo;
echo;
echo                 T 常见客服电话     Q 返回主菜单   
echo;
set choose=~
set /p choose=请输入错误代码：
if /I %choose%==t goto Network_Error_Tel
if /I %choose%==q goto main
cls
echo;
(call :Network_Error_%choose% || call :Network_Error_None )2>nul
goto Network_Setup_Repair


:Network_Error_None
echo 抱歉，您查询的错误 %choose% 暂时无法提供更详细解决方案
echo;
echo 建议您致电客服解决
echo;
echo 如果忘记客服电话，请先致电114查询
pause >nul
goto :eof


:Network_Error_Tel
echo 中国联通：10010
echo;
echo 中国电信：10000
echo;
echo 中国移动：10086
echo;
echo 中国铁通：10050
echo;
echo;
echo 如果您忘记客服电话，请先致电114查询
pause >nul
goto :eof


:Network_Error_400  
echo 错误：400
echo;
echo 问题：由于语法格式有误，服务器无法理解此请求
pause >nul
goto :eof


:Network_Error_401
echo 错误：401 UNAUTHORIZED
echo;
echo 问题：表示你必须有一个正确的用户名及密码才能得到该网页
pause >nul
goto :eof


:Network_Error_403
echo 403 FORBIDDEN
echo;
echo 问题：表示该网页或URL受到保护，禁止访问
pause >nul
goto :eof


:Network_Error_404
echo 错误：404 NOT FOUND
echo;
echo 问题：表示你所访问的网页不存在或是URL地址错误
pause >nul
goto :eof


:Network_Error_409
echo 错误：409 Fire flood and Pestilence
echo;
echo 问题：这个代码没有任何意义，你只需重新连接即可
pause >nul
goto :eof


:Network_Error_500
echo 错误：500 SERVERERROR
echo;
echo 问题：表示服务器错误，通常是对方网页程序设计错误而产生的
pause >nul
goto :eof


:Network_Error_503
echo 错误：503 SERVICE UNAVAILABLE
echo;
echo 问题：表示不能连上对方网站，因为网络线路非常繁忙。过一会再试即可
pause >nul
goto :eof


:Network_Error_602
echo 错误：602 The port is already open
echo;
echo 问题：拨号网络网络由于设备安装错误或正在使用，不能进行连接
echo;
echo 原因：RasPPPoE没有完全和正确的安装
echo;
echo 解决：卸载干净任何PPPoE软件，重新安装
pause >nul
goto :eof


:Network_Error_605
echo 错误：605 Cannot set port information
echo;
echo 问题：拨号网络网络由于设备安装错误不能设定使用端口
echo;
echo 原因：RasPPPoE没有完全和正确的安装
echo;
echo 解决：卸载干净任何PPPoE软件，重新安装
pause >nul
goto :eof


:Network_Error_606
echo 错误：606 The port is not connected
echo;
echo 问题：拨号网络网络不能连接所需的设备端口
echo;
echo 原因：RasPPPoE没有完全和正确的安装，连接线故障，ADSL MODEM故障
echo;
echo 解决：卸载干净任何PPPoE软件，重新安装，检查网线和 ADSL MODEM
pause >nul
goto :eof


:Network_Error_608
echo 错误：608 The device does not exist
echo;
echo 问题：拨号网络网络连接的设备不存在
echo;
echo 原因：RasPPPoE没有完全和正确的安装
echo;
echo 解决：卸载干净任何PPPoE软件，重新安装
pause >nul
goto :eof


:Network_Error_609
echo 错误：609 The device type does not exist
echo;
echo 问题：拨号网络网络连接的设备其种类不能确定
echo;
echo 原因：RasPPPoE没有完全和正确的安装
echo;
echo 解决：卸载干净任何PPPoE软件，重新安装
pause >nul
goto :eof


:Network_Error_611
echo 错误：611 The route is not available/612 The route is not allocated
echo;
echo 问题：拨号网络网络连接路由不正确
echo;
echo 原因：RasPPPoE没有完全和正确的安装，ISP服务器故障
echo;
echo 解决：卸载干净任何PPPoE软件，重新安装，致电ISP询问
pause >nul
goto :eof


:Network_Error_617
echo 错误：617 The port or device is already disconnecting
echo;
echo 问题：拨号网络网络连接的设备已经断开
echo;
echo 原因：RasPPPoE没有完全和正确的安装，ISP服务器故障，连接线，ADSL MODEM故障
echo;
echo 解决：卸载干净任何PPPoE软件，重新安装，致电ISP询问，检查网线和 ADSL MODEM
pause >nul
goto :eof


:Network_Error_619
echo 错误：619
echo;
echo 问题：无法连接到指定的服务器，用于此连接的端口已关闭
echo;
echo 原因：由于上次的连接出错，且重拨间隔时间过短，造成服务器来不及响应
echo;
echo 解决：间隔一到二分钟后重试
pause >nul
goto :eof


:Network_Error_621
echo 错误：621 Cannot open the phone book file
echo;
echo 原因：不能打开电话本
echo;
echo 问题：Windows NT或者Windows 2000 Server网络RAS网络组件故障
echo;
echo 解决：卸载所有PPPoE软件，重新安装RAS网络组件和RasPPPoE
pause >nul
goto :eof


:Network_Error_622
echo 错误：622 Cannot load the phone book file
echo;
echo 原因：不能装入电话本
echo;
echo 问题：Windows NT或者Windows 2000 Server网络RAS网络组件故障
echo;
echo 解决：卸载所有PPPoE软件，重新安装RAS网络组件和RasPPPoE
pause >nul
goto :eof


:Network_Error_623
echo 错误：623 Cannot find the phone book entry
echo;
echo 原因：不能找到电话本入口
echo;
echo 问题：Windows NT或者Windows 2000 Server网络RAS网络组件故障
echo;
echo 解决：卸载所有PPPoE软件，重新安装RAS网络组件和RasPPPoE
pause >nul
goto :eof


:Network_Error_624
echo 错误：624 Cannot write the phone book file
echo;
echo 原因：不能写入电话本
echo;
echo 问题：Windows NT或者Windows 2000 Server网络RAS网络组件故障
echo;
echo 解决：卸载所有PPPoE软件，重新安装RAS网络组件和RasPPPoE
pause >nul
goto :eof


:Network_Error_625
echo 错误：625 Invalid information found in the phone book
echo;
echo 原因：在电话本中存在不可用内容
echo;
echo 问题：Windows NT或者Windows 2000 Server网络RAS网络组件故障
echo;
echo 解决：卸载所有PPPoE软件，重新安装RAS网络组件和RasPPPoE
pause >nul
goto :eof


:Network_Error_629
echo 错误：629
echo;
echo 原因：已经与对方计算机断开连接。 请双击此连接，再试一次
echo;
echo 问题：多数情况是因为同时拨入的人数过多造成的。也有可能是由于您所用的MODEM或电话线的性能和质量问题
echo;
echo 解决：拨号连接设置中应该全部采取默认设置，如“启用软件压缩”、“登陆网络”都需要选上
pause >nul
goto :eof


:Network_Error_630
echo 错误：630
echo;
echo 问题：ADSL MODEM没有没有响应
echo;
echo 原因：ADSL电话线故障，ADSL MODEM故障（电源没打开等）
echo;
echo 解决：检查ADSL设备
pause >nul
goto :eof


:Network_Error_633
echo 错误：633
echo;
echo 问题：拨号网络网络由于设备安装错误或正在使用，不能进行连接
echo;
echo 原因：RasPPPoE没有完全和正确的安装
echo;
echo 解决：卸载干净任何PPPoE软件，重新安装
pause >nul
goto :eof

:Network_Error_638
echo 错误：638
echo;
echo 问题：过了很长时间，无法连接到ISP的ADSL接入服务器
echo;
echo 原因：ISP服务器故障；在RasPPPoE所创建的网络连接中你错误的输入了一个电话号码
echo;
echo 解决：确定ISP正常；把所使用的拨号连接中的 电话号码清除或者只保留一个0
pause >nul
goto :eof


:Network_Error_645
echo 错误：645
echo;
echo 问题：网卡没有正确响应
echo;
echo 原因：网卡故障，或者网卡驱动程序故障
echo;
echo 解决：检查网卡，重新安装网卡驱动程序
pause >nul
goto :eof


:Network_Error_650
echo 错误：650
echo;
echo 问题：远程计算机没有响应，断开连接
echo;
echo 原因：ADSL ISP服务器故障，网卡故障，非正常关机造成网络协议出错
echo;
echo 解决：检查ADSL信号灯是否能正确同步；检查网卡，删除所有网络组件重新安装网络
pasue
goto :eof


:Network_Error_651
echo 错误：651
echo;
echo 问题：ADSL MODEM报告发生错误
echo;
echo 原因：Windows处于安全模式下，或其他错误
echo;
echo 解决：出现该错误时，进行重拨，就可以报告出新的具体错误代码
pause >nul
goto :eof


:Network_Error_691
echo 错误：691
echo;
echo 问题：输入的用户名和密码不对，无法建立连接
echo;
echo 原因：用户名和密码错误，ISP服务器故障，账户到期、费用为0等
echo;
echo 解决：使用正确的用户名和密码；打客服电话排除故障
pause >nul
goto :eof


:Network_Error_718
echo 错误：718
echo;
echo 问题：验证用户名时远程计算机超时没有响应，断开连接
echo;
echo 原因：ADSL ISP服务器故障
echo;
echo 解决：致电客服
pause >nul
goto :eof


:Network_Error_720
echo 错误：720
echo;
echo 问题：拨号网络无法协调网络中服务器的协议设置
echo;
echo 原因：ADSL ISP服务器故障，非正常关机造成网络协议出错
echo;
echo 解决：删除所有网络组件重新安装网络
pasue
goto :eof


:Network_Error_734
echo 错误：734
echo;
echo 问题：PPP连接控制协议中止
echo;
echo 原因：ADSL ISP服务器故障，非正常关机造成网络协议出错
echo;
echo 解决：删除所有网络组件重新安装网络
pasue
goto :eof


:Network_Error_738
echo 错误：738
echo;
echo 问题：服务器不能分配IP地址
echo;
echo 原因：ADSL ISP服务器故障，ADSL用户太多超过ISP所能提供的IP地址
echo;
echo 解决：致电客服
pause >nul
goto :eof


:Network_Error_797
echo 错误：797
echo;
echo 问题：ADSL MODEM连接设备没有找到
echo;
echo 原因：ADSL MODEM电源没有打开，网卡和ADSL MODEM的连接线出现问题
echo;
echo 解决：检查电源，连接线；检查网络属性
pause >nul
goto :eof





:System_Sensitive_Protection
Mode con cols=70 lines=15
set /a NO.=NO._Abnormal=NO._Succeed=NO._Fail=0
for %%x in (
    "guest :            Guest敏感账户         "
    "helpassistant :         Helpassistant敏感账户    "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Account_Temporary=%%e
        set Account=!AccountTemporary:~1,-1!
        set Account_Caption_Temporary=%%f
        set Account_Caption=!Account_Caption_Temporary:~1,-1!
        set /a NO.+=1
        for /f "usebackq skip=5 tokens=1,2" %%a in (`"net user !Account! 2>nul"`) do set Account_Enable=%%a
        if Account_Enable==Yes (
            set /a NO._Abnormal+=1
            set Account_Activation=异常启用
            net user !Account! /active:no >nul 2>nul
            if !errorlevel!==0 (
                set Sensitive_Account_Repair= √
                set /a NO._Succeed+=1
            ) else (
                set Sensitive_Account_Repair= ×
                set /a NO._Fail+=1
            )
            
        ) else (
            set Account_Activation=正常禁用
            set Sensitive_Account_Repair=不需要
        )
        call :System_Sensitive_Protection_Monitor "!Account_Caption!" !Account_Activation! !Sensitive_Account_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!       

    )
)

for /f "tokens=1*" %%a in ('fsutil fsinfo drives') do set disk_list=%%b
    for %%i in (%disk_list%) do (
        for /f "delims=:" %%n in ("%%i") do (
            set /a NO.+=1
            net share %%n$ >nul 2>nul
            if !errorlevel!==0 (
                set /a NO._Abnormal+=1
                set Hidden_Share=异常启用
                net share %%n$ /delete
                if !errorlevel!==0 (
                    set Hidden_Share_Repair= √
                    set /a NO._Succeed+=1
                ) else (
                    set Hidden_Share_Repair= ×
                    set /a NO._Fail+=1
                )
            ) else (
                set Hidden_Share=正常禁用
                set Hidden_Share_Repair=不需要
            )    
            call :System_Sensitive_Protection_Monitor "             隐藏共享 %%n$         " !Hidden_Share! !Hidden_Share_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
        )
    )
)

net share|findstr /i ADMIN >nul 2>nul
set /a NO.+=1
if %errorlevel%==0 (
    set /a NO._Abnormal+=1
    set ADMIN_Share=异常开启
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Lanmanserver\parameters /v AutoShareWks /t REG_DWORD /d 0 /f
    if !errorlevel!==0 (
        set ADMIN_Share_Repair=√
        set /a NO._Succeed+=1
    ) else (
        set ADMIN_Share_Repair=×
        set /a NO._Fail+=1
    )
) else (
    set ADMIN_Share=正常禁用
    set ADMIN_Share_Repair=不需要
)
call :System_Sensitive_Protection_Monitor "          ADMIN$隐藏共享         " !ADMIN_Share! !ADMIN_Share_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!


net share|findstr IPC >nul 2>nul
set /a NO.+=1
if %errorlevel%==0 (
    set /a NO._Abnormal+=1
    set IPC_Share=异常开启
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymous /t REG_DWORD /d 1 /f
    if !errorlevel!==0 (
        set IPC_Share_Repair=√
        set /a NO._Succeed+=1
    ) else (
        set IPC_Share_Repair=×
        set /a NO._Fail+=1
    )
) else (
    set IPC_Share=正常禁用
    set IPC_Share_Repair=不需要
)
call :System_Sensitive_Protection_Monitor "            IPC%$隐藏共享         " !IPC_Share! !IPC_Share_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!

for %%x in (
    "TermService : 远程连接服务     "
    "RemoteRegistry : 远程注册表服务   "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Dangerous_Service_Temporary=%%e
        set Dangerous_Service=!Dangerous_Service_Temporary:~1,-1!
        set Dangerous_Service_Caption_Temporary=%%f
        set Dangerous_Service_Caption=!Dangerous_Service_Caption_Temporary:~1,-1!
        set /a NO.+=1
        for /f "delims=: tokens=2" %%m in ('sc query !Dangerous_Service!^|findstr /i STATE') do (
            if not "%%m"==" 1  STOPPED " (
                set /a NO._Abnormal+=1
                set Dangerous_Service_Status=异常启用
                sc config !Dangerous_Service! start= DISABLED
                if !errorlevel!==0 (
                    set Dangerous_Service_Repair=√
                    set /a NO._Succeed+=1
                ) else (
                    set Dangerous_Service_Repair=×
                    set /a NO._Fail+=1
                )
            ) else (
                set Dangerous_Service_Status=正常禁用
                set Dangerous_Service_Repair=不需要
            )
        )
    call :System_Sensitive_Protection_Monitor "        危险服务!Dangerous_Service_Caption!" !Dangerous_Service_Status! !Dangerous_Service_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

cls
echo;
echo;
echo;
echo;
echo        扫描：!NO.!         异常：!NO._Abnormal!         修复：!NO._Succeed!     失败 !NO._Fail!
ping /n 5 127.1>nul
goto Main



:System_Sensitive_Protection_Monitor
cls
echo;
echo            检  查  项  目                       状态          修复
echo =====================================================================
echo %~1             %2       %3
echo =====================================================================
echo;
echo        扫描：%4          异常：%5          修复：%6     失败：%7
goto :eof





:Group_Policy_Protection
Mode con cols=70 lines=20
Title 组策略防护工具
cls
echo;
echo;
echo                  组策略防护具有不占资源、高效、简洁等特点
echo;
echo                     对于加强系统安全具有不可替代的作用
echo;
echo                        Q 返回主菜单  其他键继续
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==q goto main
cls
if exist %WinDir%\system32\GroupPolicy\Machine\Registry.pol (
    echo;
    echo;
    echo           系统已存在组策略防护列表，是否覆盖（Y/N）？
    echo;
    set choose=~
    set /p choose=
    if /I !choose!==y goto Group_Policy_Protection_Make
    goto Main
)



:Group_Policy_Protection_Make
cls
echo;
echo;
echo;
echo                          正在下载最新防护列表
echo;
echo                           ......请稍后......
echo;
del /q /f %WinDir%\system32\GroupPolicy\Machine\Registry.pol >nul 2>nul
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Web_Download.vbs "http://!Server_Domain!/Registry.pol" %WinDir%\system32\GroupPolicy\Machine\Registry.pol
if exist "%WinDir%\system32\GroupPolicy\Machine\Registry.pol" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /v Levels /t REG_DWORD /d "0x04131000" /f >nul
    gpupdate /force
    echo;
    echo;
    echo                             系统防护成功
    ping /n 4 127.1>nul
    goto Main
) else (
    echo;
    echo;
    echo;
    echo                    网络连接失败，无法下载最新免疫列表
    echo;
    echo;
    echo                               请稍候重试...
    ping /n 3 127.1>nul
    goto Main
)




:ActiveX_Immune
Mode con cols=70 lines=20
Title ActiveX免疫工具
cls
set /a ActiveX_Immune_NO.=ActiveX_Immune_Succeed=ActiveX_Immune_Fail=0
echo;
echo;
echo;
echo             免疫各种恶评ActiveX插件，保证电脑清洁和运行速度
echo;
echo;
echo                        Q 返回主菜单  其他键继续
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==q goto main
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/ActiveX_Immune.txt" >%temp%\ActiveX_Immune.txt 2>nul
if exist "%temp%\ActiveX_Immune.txt" (
    for /f "delims=: tokens=1,2" %%i in (%temp%\ActiveX_Immune.txt) do (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\ActiveX Compatibility\{%%j}" /v "Compatibility Flags" /t REG_DWORD /d 00000400 /f >nul
        if !errorlevel!==0 (
            set /a ActiveX_Immune_Succeed+=1
        ) else (
            set /a ActiveX_Immune_Fail+=1
        )
        set /a ActiveX_Immune_NO.+=1
        call :ActiveX_Immune_Monitor "%%i" !ActiveX_Immune_NO.! !ActiveX_Immune_Succeed! !ActiveX_Immune_Fail!
    )
) else (
    echo;
    echo;
    echo;
    echo                    网络连接失败，无法下载最新免疫列表
    echo;
    echo;
    echo                               请稍候重试...
    ping /n 3 127.1>nul
    goto Main
)
cls
echo;
echo                                  统  计
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo   共免疫：%ActiveX_Immune_NO.%    失败：%ActiveX_Immune_Fail%项
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo;
echo                            任意键返回主菜单
pause>nul
goto Main



:ActiveX_Immune_Monitor
cls
echo;
echo                         免  疫  项  目                
echo =====================================================================
echo                     %~1 
echo =====================================================================
echo;
echo        扫描：%2            成功：%3     失败：%4
goto :eof





:Virus_Immune
Mode con cols=70 lines=20
Title 病毒免疫工具
cls
set /a NO.=0
set /a NEW_NO.=0
echo;
echo;
echo                                  通过
echo;
echo                      畸形文件夹  和  访问控制列表
echo;
echo                           达到免疫病毒的作用
echo;
echo;
echo                        Q 返回主菜单  其他键继续
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==q goto main
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/Virus_Immune.txt" >%temp%/Virus_Immune.txt 2>nul
cls
echo;
echo;
echo;
echo                               正 在 免 疫
echo;
echo                           ......请稍后......
if exist "%temp%/Virus_Immune.txt" (
    for /f %%i in (%temp%/Virus_Immune.txt) do (
        if not exist "%%i\病毒免疫" (
            if exist "%%i" del /f /s/q "%%i"
            md "%%i\病毒免疫"
            md "%%i\病毒免疫\九影病毒免疫..\"
            attrib "%%i" +S +R +H
            cacls "%%i\病毒免疫" /d everyone /e>nul 2>nul
            set /a NEW_NO.+=1
        )
        set /a NO.+=1
    )
) else (
    echo;
    echo;
    echo;
    echo                    网络连接失败，无法下载最新免疫列表
    echo;
    echo;
    echo                               请稍候重试...
    ping /n 3 127.1>nul
    goto Main
)
echo;
echo                                  统  计
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo          共免疫：%NO.% 病毒体          本次新增免疫：%NEW_NO.% 病毒体
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo;
echo                            任意键返回主菜单
pause>nul
goto Main





:Login_Message_Send
Title 系统登录通知
cls
set mark_exist=未启动
for /f "usebackq tokens=2 delims=:" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul"^|findstr /i Login_message_send`) do (
    if exist "%windir%\System32\send.bat" (
        if /i "%%i"=="\windows\system32\Login_message_send.vbs" set mark_exist=启动
    )
)
echo;
echo             当系统登录时，自动将IP及所在地发送到指定邮箱中
echo;
echo      推荐使用邮箱的来信短信通知功能，方便送达手机，及时发现异常
echo;
echo             如果安全软件提示开机启动项变动，请选择通过
echo;&&echo;
echo                   当前状态： %mark_exist%
echo;
if "%mark_exist%"=="未启动" (
    echo;
    echo                    A.  设置登录通知   
    echo;
)
if "%mark_exist%"=="启动" (
    echo;
    echo         A. 重新设置登录通知       B. 查看设置
    echo;
    echo         C. 取消登录通知           D. 测试收信
    echo;
)
echo                    Q.  返回主菜单
echo;
set choose=~
set /p choose=请选择：
if "%mark_exist%"=="未启动" (
    if /I %choose%==a goto Login_Message_send_Do
)
if "%mark_exist%"=="启动" (
    if /I %choose%==a goto Login_Message_send_Do
    if /I %choose%==b goto Login_Message_send_Check
    if /I %choose%==c goto Login_Message_Send_Cancle
    if /I %choose%==d goto Login_Message_Send_Test
)
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto Login_message_send
    exit
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto Login_message_send



:Login_Message_Send_Do
Mode con cols=50 lines=10


:Login_Message_Send_Do_Name
cls
echo;
set /p m=请输入接收的邮箱:
if "%m%"=="" goto Login_Message_Send_Do_Name
if not "%m:~-4,4%"==".com" (
    echo;
    echo 邮箱格式错误，请重新输入。
    ping /n 3 127.1>nul
    goto Login_Message_Send_Do_Name
)
echo;
for /f "tokens=1,2 delims=@" %%i in ('echo %m%') do (
    set n=%%i
    set s=%%j
)
cls
echo;
echo  邮箱登录的用户名: %n%
echo;
echo        邮箱服务器：smtp.%s%
ping /n 5 127.1>nul


:Login_Message_Send_Do_Password
cls
echo;
set /p p=请输入邮箱登录的密码:
if "%p%"=="" (
    echo;
    echo 密码无效，请重新输入。
    ping /n 3 127.1>nul
    goto Login_Message_Send_Do_Password
)
echo 接收的邮箱: %m%>"%windir%\System32\send.txt"
echo set /a Failed_Retry_Number=50 >"%windir%\System32\send.bat"
echo set Failed_Retry_Number=%%1 2^>nul >>"%windir%\System32\send.bat"
echo @echo off^&setlocal enabledelayedexpansion>>"%windir%\System32\send.bat"
echo :contest>>"%windir%\System32\send.bat"
echo ping www.ip138.com -n 2 -w 1000^>nul>>"%windir%\System32\send.bat"
echo IF %%errorlevel%% == 0 goto pass>>"%windir%\System32\send.bat"
echo IF %%errorlevel%% == 1 (>>"%windir%\System32\send.bat"
echo     set /a Failed_Retry_Number+=1 >>"%windir%\System32\send.bat"
echo     if ^^!Failed_Retry_Number^^!==50 exit /b 1 >>"%windir%\System32\send.bat"
echo     goto contest>>"%windir%\System32\send.bat"
echo )>>"%windir%\System32\send.bat"
echo :pass>>"%windir%\System32\send.bat"
echo echo Set oDOM = WScript.GetObject(WScript.Arguments(0)) ^>"%temp%\getip.vbs">>"%windir%\System32\send.bat"
echo echo do until oDOM.readyState = "complete" ^>^>"%temp%\getip.vbs">>"%windir%\System32\send.bat"
echo echo WScript.sleep 200 ^>^>"%temp%\getip.vbs">>"%windir%\System32\send.bat"
echo echo loop ^>^>"%temp%\getip.vbs">>"%windir%\System32\send.bat"
echo echo WScript.echo oDOM.documentElement.outerHTML ^>^>"%temp%\getip.vbs">>"%windir%\System32\send.bat"
echo cscript //NoLogo /e:vbscript "%temp%\getip.vbs" "http://ip.loveroot.com"^>"%temp%\ip.txt">>"%windir%\System32\send.bat"
echo for /f "tokens=3,6,7 delims=<> " %%%%1 in ('findstr /r "官方数据查询结果" "%temp%\ip.txt"') do ( >>"%windir%\System32\send.bat"
echo     set ip=%%%%1 >>"%windir%\System32\send.bat"
echo     set address=%%%%2 %%%%3 >>"%windir%\System32\send.bat"
echo )>>"%windir%\System32\send.bat"
echo echo On Error Resume Next^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo f="%m%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo smtp="smtp.%s%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo u="%n%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo p="%p%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo t="%m%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo m="系统登录记录:  所在IP:  %%ip%% 所在位置： %%address%%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo msg="系统登录记录 BY bluewing009 保护系统"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo NameSpace = "http://schemas.microsoft.com/cdo/configuration/" ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Set Email = createObject("CDO.Message") ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.From = f ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.To = t ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.Subject = m ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.Textbody = msg ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo With Email.Configuration.Fields^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"sendusing") = 2 ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"smtpserver") = smtp ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"smtpserverport") = 25 ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"smtpauthenticate") = 1 ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"sendusername") = u ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .Item(NameSpace^^^&"sendpassword") = p ^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo .update^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo End With^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo Email.Send^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo "%%windir%%\System32\\send.vbs"^>nul>>"%windir%\System32\send.bat"
echo exit /b 0 >>"%windir%\System32\send.bat"
echo CreateObject("WScript.Shell").Run "cmd /c send.bat",0 >"%windir%\System32\Login_message_send.vbs"
reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v Login_message_send /t REG_SZ /d "%windir%\System32\Login_message_send.vbs" /f >nul
cls
if %errorlevel%==1 (
    echo;&&echo;
    echo                      配置失败
    echo;
    echo                        返回
    ping /n 3 127.1>nul
    goto Login_Message_Send
)
if %errorlevel%==0 (
    echo;&&echo;
    echo                      配置成功
    echo;
    echo                 是否测试邮箱状态 ？
    echo;
    echo               Y 开始  其他键返回主菜单
    echo;
    set choose=~
    set /p choose=请选择：
    if /I !choose!==y goto Login_Message_Send_Test
    goto Main
)


:Login_Message_Send_Check
cls
start "" "%windir%\System32\send.txt"
goto Login_Message_Send


:Login_Message_Send_Cancle
Mode con cols=50 lines=10
del /q "%windir%\System32\send.txt" "%windir%\System32\send.bat" "%windir%\System32\send.vbs" "%windir%\System32\Login_message_send.vbs">nul 2>nul
reg delete HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v Login_message_send /f >nul
if %errorlevel%==1 (
    echo;
    echo;
    echo                      取消失败
    echo;
    echo                        返回
    ping /n 3 127.1>nul
    goto Login_Message_Send
)
if %errorlevel%==0 (
    echo;
    echo;
    echo                      取消成功
    echo;
    echo                     返回主菜单
    ping /n 3 127.1>nul
    goto Main
)


:Login_Message_Send_Test
Mode con cols=50 lines=10
echo;
echo                    正在发送邮件
echo;
echo                    ...请稍后...
call "%windir%\System32\send.bat" 0
if %errorlevel%==0 (
    echo;
    echo                        成功
    echo;
    echo                    请登录邮箱查看
    ping /n 3 127.1>nul
    goto Main
)
if %errorlevel%==1 (
    echo;
    echo                        失败
    echo;
    echo                请检查网络连接后再试
    ping /n 3 127.1>nul
    goto Main
)





:Force_Delete
Mode con cols=50 lines=10
cls
echo;
echo        请将需要删除的文件或文件夹拖放至框中
echo;
echo          不能拖动时，请输入完整文件路径
echo;
set Delete_Path=~
set Delete_Path_Type=~
set /p Delete_Path=
set "Delete_Path=%Delete_Path:"=%"
cd %Delete_Path% >nul 2>nul
if %errorlevel%==0 set Delete_Path_Type=文件夹
if %errorlevel%==1 set Delete_Path_Type=文件
cd /d %~dp0
if "%Delete_Path%"=="~" goto Force_Delete
if /i %Delete_Path%==q goto Main
if not exist "%Delete_Path%" (
    cls
    echo;
    echo;
    echo;
    echo                     路径错误
    ping /n 2 127.1>nul
    goto Force_Delete
)
if "%Delete_Path_Type%"=="~" (
    cls
    echo;
    echo;
    echo;
    echo                     路径错误 
    ping /n 2 127.1>nul
    goto Force_Delete
)
cls
echo;
echo                 即将删除以下文件
echo;
echo "%Delete_Path%"        
echo;
echo;
echo                Y 开始  其他键放弃
echo;
set choose=~
set /p choose=请选择：
if /I "%choose%"=="Y" goto Force_Delete_Do
goto Force_Delete_Jump



:Force_Delete_Jump
cls
echo;
echo;
echo;
echo                       放  弃 
ping /n 2 127.1>nul
goto Main



:Force_Delete_Do
if "%Delete_Path_Type%"=="文件" (
    del /f /s /q "%Delete_Path%" >nul 2>nul
)
if "%Delete_Path_Type%"=="文件夹" (
    rd /s /q "%Delete_Path%" >nul 2>nul
)
if exist "%Delete_Path%" (
    cls
    echo;
    echo                     删除失败
    echo;
    echo              重启后尝试删除该文件
    echo;
    for /f "delims=" %%i in ("%Delete_Path%") do set Delete_Path_=%%~dpi
    echo [Version] >"%Delete_Path_%Force_Delete.inf"
    echo Signature="$Chicago$" >>"%Delete_Path_%Force_Delete.inf"
    echo [DestinationDirs] >>"%Delete_Path_%Force_Delete.inf"
    echo DefaultDestDir = 01 >>"%Delete_Path_%Force_Delete.inf"
    echo [DefaultInstall] >>"%Delete_Path_%Force_Delete.inf"
    echo DelFiles = DELETELIST >>"%Delete_Path_%Force_Delete.inf"
    echo [DELETELIST] >>"%Delete_Path_%Force_Delete.inf"
    echo Force_Delete.inf ,,,1 >>!Delete_Path_!Force_Delete.inf
    for /f "delims=" %%i in ('dir /b "%Delete_Path%"') do (
        echo %%i ,,,1 >>!Delete_Path_!Force_Delete.inf
    )
    rundll32 syssetup,SetupInfObjectInstallAction DefaultInstall 128 !Delete_Path_!Force_Delete.inf 
) else (
    cls
    echo;
    echo;
    echo                     删除成功   
)   
ping /n 2 127.1>nul   
goto Main





:MBR_Backup_Recovery
Mode con cols=70 lines=20
Title 硬盘主引导记录备份/恢复
cls
set mark_exist=未备份
if exist %SystemRoot%\System32\MBR备份.bin set mark_exist=已备份
echo;
echo                        备份/恢复硬盘主引导记录
echo;
echo             用于应急恢复异常或病毒造成的主引导记录异常
echo;
echo                      如果提示修改，请选择“忽略”
echo;
echo;
echo                        当前状态： %mark_exist%
echo;
if "%mark_exist%"=="未备份" (
    echo;
    echo                         A.  备份硬盘引导记录  
    echo;
)
if "%mark_exist%"=="已备份" (
    echo;
    echo                 A. 更新备份       B. 恢复硬盘引导记录 
    echo;
    echo;
)
echo                         Q.  返回主菜单
echo;
set choose=~
set /p choose=请选择：
if "%mark_exist%"=="未备份" (
    if /I %choose%==a goto MBR_Backup
)
if "%mark_exist%"=="已备份" (
    if /I %choose%==a goto MBR_Backup
    if /I %choose%==b goto MBR_Recovery
)
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         无效的选项，请重新输入
    ping /n 2 127.1>nul
    goto MBR_Backup_Recovery
    exit
)
echo;
echo                         无效的选项，请重新输入
ping /n 2 127.1>nul
goto MBR_Backup_Recovery



:MBR_Backup
Mode con cols=50 lines=10
cls
echo;
echo;
echo;
echo        ...正在备份...
echo a 100 >%temp%\mbr_backup.code
echo mov ax,0201 >>%temp%\mbr_backup.code
echo mov bx,200  >>%temp%\mbr_backup.code
echo mov cx,0001 >>%temp%\mbr_backup.code
echo mov dx,0080 >>%temp%\mbr_backup.code
echo int 13 >>%temp%\mbr_backup.code
echo int 20 >>%temp%\mbr_backup.code
echo;>>%temp%\mbr_backup.code
echo g >>%temp%\mbr_backup.code
echo m 1000 11FF 100 >>%temp%\mbr_backup.code
echo rcx >>%temp%\mbr_backup.code
echo 200 >>%temp%\mbr_backup.code
echo;>>%temp%\mbr_backup.code
echo n %SystemRoot%\System32\MBR备份.bin>>%temp%\mbr_backup.code
echo w >>%temp%\mbr_backup.code
echo q >>%temp%\mbr_backup.code
debug<%temp%\mbr_backup.code >nul 2>nul
graftabl 936>nul 2>nul
if exist %SystemRoot%\System32\MBR备份.bin (
    cacls " %SystemRoot%\System32\MBR备份.bin" /d everyone /e>nul 2>nul
    echo;
    echo;
    echo                     备份成功
    echo;
    echo              备份文件已被安全锁定
) else (
    echo;
    echo;
    echo                未知错误，备份失败
)
ping /n 2 127.1>nul
goto Main



:MBR_Recovery
Mode con cols=50 lines=10
cls
echo;
echo;
echo;
echo                  ...正在恢复...
echo y|cacls "%SystemRoot%\System32\MBR备份.bin" /g everyone:f>nul
echo n %SystemRoot%\System32\MBR备份.bin >%temp%\mbr_restoration.code
echo l 200 >>%temp%\mbr_restoration.code
echo a 100 >>%temp%\mbr_restoration.code
echo mov ax,0301 >>%temp%\mbr_restoration.code
echo mov bx,0200  >>%temp%\mbr_restoration.code
echo mov cx,0001 >>%temp%\mbr_restoration.code
echo mov dx,0080 >>%temp%\mbr_restoration.code
echo int 13 >>%temp%\mbr_restoration.code
echo int 20 >>%temp%\mbr_restoration.code
echo;>>%temp%\mbr_restoration.code
echo g >>%temp%\mbr_restoration.code
echo q >>%temp%\mbr_restoration.code
debug<%temp%\mbr_restoration.code >nul 2>nul
graftabl 936>nul 2>nul
cls
echo;
echo;
echo;
echo                     恢复成功
ping /n 2 127.1>nul
goto Main





:System_Garbage_Clean
set /a File_Size_All=File_Size_=File_Size=0
Mode con cols=50 lines=10
Title 清理系统垃圾
for %%l in (
    "历史Recent文件夹         : %APPDATA%\Microsoft\Windows\Recent"
    "用户临时文件夹           : %temp%"
    "Windows临时目录          : %windir%\temp"
    "已下载的程序             : %windir%\download program files"
    "windows预读              : %windir%\prefetch"
    "windows更新补丁          : %windir%\softwaredistribution\download"
    "内存转储文件             : %windir%\Minidump"
    "office 安装缓存          : %SYSTEMDRIVE%\MSOCache" 
    "IE临时文件夹             : %userprofile%\Local Settings\Temporary Internet Files"
    "缩略图缓存               : %HOMEPATH%\AppData\Local\Microsoft\Windows\Explorer"
    "windows问题报告          : %HOMEPATH%\AppData\Local\Microsoft\Windows\WER"
) do (
    for /f "tokens=1,* delims=:" %%i in ("%%l") do (
        set Garbage_Name_Temp=%%i
        set Garbage_Name=!Garbage_Name_Temp:~1,-1!
        set Garbage_Path_Temp=%%j
        set Garbage_Path=!Garbage_Path_Temp:~1,-1!
        if exist "!Garbage_Path!" for /f "tokens=3" %%i in ('dir /a /s /-c "!Garbage_Path!" ^|findstr "个文件"') do set File_Size_=%%i
        set /a File_Size+=!File_Size_!
        cls  
        echo;
        echo;
        echo;
        echo 正在清理  !Garbage_Name!...
        ping /n 1 127.1>nul
        rd /s /q "!Garbage_Path!">nul 2>nul
        md "!Garbage_Path!">nul 2>nul
    )
)
cls
set /a File_Size_All=!File_Size!/1048576
cls
echo;
echo;
echo;
echo 清理完成，共释放空间 !File_Size_All! MB
ping /n 5 127.1>nul
goto Main





:Registry_Garbage_clean
Mode con cols=50 lines=10
Title 清理系统垃圾
set /a NO.=NO._=0
if %version_mark%==win7 set path_=Documents
if %version_mark%==xp set path_=My Documents
if not exist "%Userprofile%\!path_!\注册表清理备份" md "%Userprofile%\!path_!\注册表清理备份"
if exist "%Userprofile%\!path_!\注册表清理备份\最近备份.reg" (
    copy /y "%Userprofile%\!path_!\注册表清理备份\最近备份.reg" "%Userprofile%\!path_!\注册表清理备份\上次备份.reg" >nul
    del /f/s/q "%Userprofile%\!path_!\注册表清理备份\最近备份.reg" >nul
)
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs" "%Userprofile%\!path_!\注册表清理备份\最近备份.reg" >nul
for /F "usebackq skip=%version_skip% tokens=* delims=" %%i in (`" reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs"`) do call :Registry_Garbage_clean_Check "%%i"
ping /n 3 127.1>nul
cls
echo;
echo;
echo;
echo            清理完成
ping /n 2 127.1>nul
cls
echo;
echo;
echo     若有误删，请至 我的文档\注册表清理备份 下
echo;
echo    最近备份.reg  恢复  （上次备份：上次备份.reg）
ping /n 5 127.1>nul
goto Main



:Remove_Spaces
rem 去除字符串左右空格，入口%1，出口参数%Remove_Spaces_Result%
set Remove_Spaces_Str=%~1

:Remove_Spaces_Left
if "%Remove_Spaces_Str:~0,1%"==" " set "Remove_Spaces_Str=%Remove_Spaces_Str:~1%"&goto Remove_Spaces_Left

:Remove_Spaces_Right
if "%Remove_Spaces_Str:~-1%"==" " set "Remove_Spaces_Str=%Remove_Spaces_Str:~0,-1%"&goto Remove_Spaces_Right
set Remove_Spaces_Result=%Remove_Spaces_Str%
goto :eof 

:Registry_Garbage_clean_Check
set /a NO.+=1
set var=%~1
set var=!var:REG_DWORD=+!
for /f "tokens=1 delims=+" %%i in ("%var%") do (
    call :Remove_Spaces "%%i"
    if not exist "%Remove_Spaces_Result%" (   
        reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs /v "%Remove_Spaces_Result%" /f >nul 2>nul
        set /a NO._+=1
        )
)
cls
echo;
echo;
echo           已检查项目： %NO.% 
echo;
echo       已删除废弃项目： %NO._%
goto :eof





:Default_Service
Mode con cols=50 lines=10
cls
Title 恢复默认服务
cls
echo;
echo 恢复系统默认的服务状态，用于拯救错误的系统服务优化
echo;
echo              是否备份当前服务状态？
echo;
echo                  Y    直接恢复
echo               其他键  备份后恢复
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==Y goto Recovery_Services
call :Service_Backup



:Recovery_Services
cls
echo;
echo;
echo        正在更新，请稍后
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/Default_Service_!version_mark!.txt" >%temp%\Default_Service.txt 2>nul
set /a Service_NO._ALl=Service_NO._Failed=0
del /q /f %temp%\ERROR__.txt ERROR.txt >nul 2>nul
for /f "tokens=1,2 delims=:" %%i in (%temp%\Default_Service.txt) do (
	set /a Service_NO._ALl+=1
	cls
	echo;
	echo;
	echo        正在恢复，请稍后
	echo;
	echo;
	echo   第 !Service_NO._ALl! 个服务：%%i
	sc config %%i start= %%j >%temp%\ERROR_.txt
	if not !errorlevel!==0 (
		for /f "skip=1" %%m in (%temp%\ERROR_.txt) do (
			set /a Service_NO._Failed+=1
			echo 服务：%%i 配置错误，%%m Error ID=!errorlevel! >>Error.txt
		)
	)
)
cls
echo;
echo        恢复完成
echo;
echo  共计 %Service_NO._ALl% 服务项，失败 %Service_NO._Failed%
if not %Service_NO._Failed%==0 (
	echo;
	echo                是否查看失败原因？
	echo;
	echo                Y 查看  其他键返回
	echo;
	set choose=~
	set /p choose=请选择：
	if /I !choose!==Y call Error.txt
)
goto main



:Service_Backup
cls
del /q /f Backup\Service.bat >nul 2>nul
for /f "tokens=2 delims=:" %%i in ('sc query type^= service state^= all ^|findstr /C:"SERVICE_NAME:"') do (
	for /f "tokens=4,6 delims=:_ " %%k in ('sc qc %%i ^|findstr  START_TYPE') do (
		set /a Service_Bcakup_NO.+=1
		cls
		echo;
		echo;
		echo        正在备份，请稍后...
		echo;
		echo;
		echo   第 !Service_Bcakup_NO.! 个服务：%%i
		if "%%l"=="(DELAYED)" (
			echo sc config  %%i start= delayed-auto >>Backup\Service.bat
		) else (
			echo sc config  %%i start= %%k >>Backup\Service.bat
		)
	)
)
	cls
		echo;
		echo;
		echo        完成备份 !Service_Bcakup_NO.! 个服务
		ping /n 2 127.1>nul
goto :eof





:Online_Scan
cls
Mode con cols=50 lines=10
cls
Title 一键上传云扫描
cls
echo;
echo 添加系统文件右键菜单，您以后可以一键上传可疑文件
echo;
echo              是否载入右键菜单？
echo;
echo       Y 载入右键功能    N 删除右键功能
echo               其他键  放弃返回
echo;
set choose=~
set /p choose=请选择：
if /I %choose%==Y goto Online_Scan_Add
if /I %choose%==N goto Online_Scan_Delete
goto main

:Online_Scan_Add
reg add HKEY_CLASSES_ROOT\*\shell\上传virscan扫描\command /ve /t REG_SZ /d "Wscript.exe \"%~dp0\Components\Online_Scan.vbs\" bluewing009 \"%%1\" 0 1" /f >nul 2>nul
cls
echo;
echo;
echo;
echo        载入完成，在任意文件上右击
echo;
echo          选择“上传virscan扫描”即可
ping /n 2 127.1>nul
goto main
:Online_Scan_Delete
reg delete HKEY_CLASSES_ROOT\*\shell\上传virscan扫描 /f >nul 2>nul
cls
echo;
echo;
echo;
echo              已删除右键功能
ping /n 2 127.1>nul
goto main





:System_Information
Mode con cols=50 lines=10
Title 系统信息
cls
echo;
echo;
echo                 正在检测系统信息
echo;
echo;
systeminfo>>%temp%\System_Information.txt
start "" %temp%\System_Information.txt
goto Main





:Online_Updates
Mode con cols=50 lines=10
Title 在线更新
set version_New=未知
cls
echo;
echo;
echo;
echo                    正在检查更新
echo;
echo                    ...请稍后...
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools_Version.txt" >%temp%\System_Auxiliar_Tools_Version.txt 2>nul
for /f %%i in (%temp%\System_Auxiliar_Tools_Version.txt) do set version_New=%%i
if "%version_New%"=="未知" goto Check_Updates_Error
for /f "tokens=1* delims=:" %%i in ('findstr /n .* %0') do if %%i==22 for /f "tokens=5" %%m in ('%%j') do set version_Now=%%m
if !Version!==Piracy set version_Now=0
if %version_Now%==%version_New% (
    echo;
    echo                版本最新，不需要更新
    ping /n 3 127.1>nul
    goto Main
) else (
    cls
    echo;
    echo;
    echo;
    echo                    正在下载更新
    echo;
    echo                    ...请稍后...
    cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools.txt">%temp%\系统辅助工具.bat
    echo @echo off>%temp%\系统辅助工具_更新.bat
    echo Mode con cols=50 lines=10>>%temp%\系统辅助工具_更新.bat
    echo Color 3F>>%temp%\系统辅助工具_更新.bat
    echo Title 在线更新>>%temp%\系统辅助工具_更新.bat
    echo echo;>>%temp%\系统辅助工具_更新.bat
    echo echo;>>%temp%\系统辅助工具_更新.bat
    echo echo;>>%temp%\系统辅助工具_更新.bat
    echo echo;>>%temp%\系统辅助工具_更新.bat
    echo echo                   ...重新启动...>>%temp%\系统辅助工具_更新.bat
    echo ping /n 3 127.1^>nul>>%temp%\系统辅助工具_更新.bat
    echo copy /y "%temp%\系统辅助工具.bat" "%~dp0\%~n0.bat"^>nul >>%temp%\系统辅助工具_更新.bat
    echo start "" "%~dp0\%~n0.bat">>%temp%\系统辅助工具_更新.bat
    echo Exit>>%temp%\系统辅助工具_更新.bat
    start %temp%\系统辅助工具_更新.bat
    exit
)

:Check_Updates_Error
Mode con cols=50 lines=10
Title 在线更新
cls
echo;
echo;
echo                 无法连接更新服务器
echo;
ping /n 3 127.1>nul
if !Version!==Piracy goto :Exit
goto Main





:Exit
Mode con cols=50 lines=10
Title 感谢使用
cls
echo;
echo           谢谢使用      o（∩ _ ∩）o
echo;
echo;           如果有好的建议，请联系：
echo;
echo;
echo         E-Mail:  bluewing009@tom.com
echo             QQ:      961881006
echo;
ping /n 5 127.0.0.1>nul
if %Safe_Environment_Mark%==Y start explorer.exe >nul 2>nul
endlocal
Exit





rem 以下是系统各个调用

:Permission_Check
Mode con cols=50 lines=10
Title 权限确认
cls
echo;
echo;
echo;
echo                正在测试所需的权限
echo;
echo                   ...请稍后...
echo;>%SystemRoot%\System32\Permission_Check.dat
if not exist %SystemRoot%\System32\Permission_Check.dat (
    cls
    echo;
    echo;
    echo                     权限异常
    echo;
    echo                请以管理员权限运行
    echo;
    echo;
    echo                    任意键退出
    pause>nul
    exit
)
del %SystemRoot%\System32\Permission_Check.dat >nul 2>nul
goto :eof





:OS_Check
(
    for /f "usebackq tokens=1,2,*" %%1 in (`"reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2>nul"^|findstr /i ProductName`) do (
        set OS_Version=%%3 
        set version_mark=xp&&set version_skip=4
        echo !OS_Version!|findstr "XP"|| (set version_mark=win7&&set version_skip=2)
    )
) >nul
goto :eof





:Color_Visitors
if "%~1"=="" goto :eof
pushd %temp%
set "object=%~1"
set /p="%~2 "<nul>"%object%"
set /p="位使用者"<nul>>"%object%"
set /p=●                                           您是第 <NUL
findstr /a:34 .* "%object%*"
del /q "%object%"
popd
goto :eof





:Color_Offline
pushd %temp%
set "object=离线"
set /p="%~2 "<nul>"%object%"
set /p="模式"<nul>>"%object%"
set /p=●                                              您正在使用 <NUL
findstr /a:34 .* "%object%*"
del /q "%object%"
popd
goto :eof



:colortheword
::colortheword [str1=着色字符] [str2=显示字符] [str3=颜色设置]
pushd %temp%
set "object=%~1"
set /p="%~2"<nul>"%object%"
set /p="%~3"<nul>>"%object%"
findstr /a:%~4 .* "%object%*"
del /q "%object%"
popd
goto :eof





:Get_Path
rem 子程序用于分离字符串：路径 参数。入口参数：混合字符串；出口参数：文件路径 %File_Path%%File_Name%
set File=%~1
set File=%File:/=-%
for %%i in ("%File%") do (
	set File_Path=%%~dpni
	set File_Rest=%%~xi
)
for /f %%i in ("%File_Rest%") do set File_Name=%%i
goto :eof





:Make_Updates.vbs
echo Set oDOM = WScript.GetObject(WScript.Arguments(0)) >Components\Updates.vbs
echo do until oDOM.readyState = "complete" >>Components\Updates.vbs
echo WScript.sleep 200 >>Components\Updates.vbs
echo loop >>Components\Updates.vbs
echo WScript.echo oDOM.documentElement.outerText >>Components\Updates.vbs
goto :eof





:Make_Md5.vbs
echo Option Explicit>Components\Md5.vbs
echo rem This vbs is improved by bluewing009 for command line to get file's md5 value>>Components\Md5.vbs
echo rem The usage is as follow (CMD):cscript //NoLogo /e:vbscript Md5.vbs "your file's path">result txt path>>Components\Md5.vbs
echo Dim wi >>Components\Md5.vbs
echo Dim file >>Components\Md5.vbs
echo Dim file_hash >>Components\Md5.vbs
echo Set wi = CreateObject("WindowsInstaller.Installer") >>Components\Md5.vbs
echo file = WScript.Arguments(0) >>Components\Md5.vbs
echo file_hash = GetFileHash(file) >>Components\Md5.vbs
echo Set wi = Nothing >>Components\Md5.vbs
echo WScript.Echo file ^& "||" ^& file_hash >>Components\Md5.vbs
echo;>>Components\Md5.vbs
echo Function GetFileHash(file_name) >>Components\Md5.vbs
echo    Dim file_hash>>Components\Md5.vbs
echo    Dim hash_value>>Components\Md5.vbs
echo    Dim i>>Components\Md5.vbs
echo    Set file_hash = wi.FileHash(file_name, 0) >>Components\Md5.vbs
echo    hash_value = "" >>Components\Md5.vbs
echo    For i = 1 To file_hash.FieldCount >>Components\Md5.vbs
echo    hash_value = hash_value ^& BigEndianHex(file_hash.IntegerData(i)) >>Components\Md5.vbs
echo    Next >>Components\Md5.vbs
echo    GetFileHash = hash_value >>Components\Md5.vbs
echo    Set file_hash = Nothing >>Components\Md5.vbs
echo    End Function >>Components\Md5.vbs
echo;>>Components\Md5.vbs
echo Function BigEndianHex(int) >>Components\Md5.vbs
echo     Dim result >>Components\Md5.vbs
echo     Dim b1, b2, b3, b4 >>Components\Md5.vbs
echo     result = Hex(int) >>Components\Md5.vbs
echo     b1 = Mid(result, 7, 2) >>Components\Md5.vbs
echo     b2 = Mid(result, 5, 2) >>Components\Md5.vbs
echo     b3 = Mid(result, 3, 2) >>Components\Md5.vbs
echo     b4 = Mid(result, 1, 2) >>Components\Md5.vbs
echo     BigEndianHex = b1 ^& b2 ^& b3 ^& b4 >>Components\Md5.vbs
echo End Function >>Components\Md5.vbs
goto :eof





:Make_Web_Download.vbs
echo rem This vbs is improved by Bluewing009 for command line to get a file from web >Components\Web_Download.vbs
echo rem The usage is as follow (CMD):cscript //NoLogo /e:vbscript Web_Download.vbs "Web download's URL" "your save file's path" >>Components\Web_Download.vbs
echo Set Web_Download = CreateObject("Microsoft.XMLHTTP") >>Components\Web_Download.vbs
echo     Web_Download.Open "GET",Wscript.Arguments.Item(0),0 >>Components\Web_Download.vbs
echo     Web_Download.Send() >>Components\Web_Download.vbs
echo Set Web_Save = CreateObject("ADODB.Stream") >>Components\Web_Download.vbs
echo     Web_Save.Mode = 3 >>Components\Web_Download.vbs
echo     Web_Save.Type = 1 >>Components\Web_Download.vbs
echo     Web_Save.Open() >>Components\Web_Download.vbs
echo     Web_Save.Write(Web_Download.responseBody) >>Components\Web_Download.vbs
echo     Web_Save.SaveToFile Wscript.Arguments.Item(1),2 >>Components\Web_Download.vbs
goto :eof





:Make_Web_Page_Download.vbs
echo rem This vbs is improved by bluewing009 for command line to get a html file's code and change form utf-8 to ansi  >Components\Web_Page_Download.vbs
echo rem The usage is as follow (CMD):cscript //NoLogo /e:vbscript Web_Page_Download.vbs "Web download's URL" "your save file's path" >>Components\Web_Page_Download.vbs
echo Set Web_Download = CreateObject("Microsoft.XMLHTTP") >>Components\Web_Page_Download.vbs
echo     Web_Download.Open "GET",Wscript.Arguments.Item(0),0 >>Components\Web_Page_Download.vbs
echo     Web_Download.Send() >>Components\Web_Page_Download.vbs
echo Set Web_Save = CreateObject("ADODB.Stream") >>Components\Web_Page_Download.vbs
echo     Web_Save.Mode = 3 >>Components\Web_Page_Download.vbs
echo     Web_Save.Type = 1 >>Components\Web_Page_Download.vbs
echo     Web_Save.Open() >>Components\Web_Page_Download.vbs
echo     Web_Save.Write(Web_Download.responseBody) >>Components\Web_Page_Download.vbs
echo     Web_Save.SaveToFile Wscript.Arguments.Item(1),2 >>Components\Web_Page_Download.vbs
echo Dim read >>Components\Web_Page_Download.vbs
echo Set Change_Code = CreateObject("ADODB.Stream") >>Components\Web_Page_Download.vbs
echo     Change_Code.Type = 2 >>Components\Web_Page_Download.vbs
echo     Change_Code.Mode = 3 >>Components\Web_Page_Download.vbs
echo     Change_Code.CharSet = "utf-8" >>Components\Web_Page_Download.vbs
echo     Change_Code.Open >>Components\Web_Page_Download.vbs
echo     Change_Code.LoadFromFile Wscript.Arguments.Item(1) >>Components\Web_Page_Download.vbs
echo     read = Change_Code.ReadText >>Components\Web_Page_Download.vbs
echo     Change_Code.Position = 0 >>Components\Web_Page_Download.vbs
echo     Change_Code.CharSet = "gbk" >>Components\Web_Page_Download.vbs
echo     Change_Code.WriteText read >>Components\Web_Page_Download.vbs
echo     Change_Code.SetEOS >>Components\Web_Page_Download.vbs
echo     Change_Code.SaveToFile Wscript.Arguments.Item(1), 2 >>Components\Web_Page_Download.vbs
echo     Change_Code.Close >>Components\Web_Page_Download.vbs
echo Set Change_Code = Nothing >>Components\Web_Page_Download.vbs
goto :eof





:Make_Synchronization_Download.bat
rem 同步下载组件
echo @echo off >>Components\Synchronization_Download.bat
echo Title By:Bluewing009>>Components\Synchronization_Download.bat
echo cd /d %%~dp0 >>Components\Synchronization_Download.bat
echo pushd %%~dp0 >>Components\Synchronization_Download.bat
echo cscript //NoLogo /e:vbscript Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools_Confirm.txt" ^>%%temp%%\System_Auxiliar_Tools_Confirm.txt >>Components\Synchronization_Download.bat
echo for /f %%%%i in (%%temp%%\System_Auxiliar_Tools_Confirm.txt) do set Author=%%%%i>>Components\Synchronization_Download.bat
echo if /i not "%%Author%%"=="bluewing009" exit >>Components\Synchronization_Download.bat
echo cscript //NoLogo /e:vbscript Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools_Version.txt" ^>%%temp%%\System_Auxiliar_Tools_Version.txt >>Components\Synchronization_Download.bat
echo cscript //NoLogo /e:vbscript Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools_Count.php" ^>%%temp%%\System_Auxiliar_Tools_Count.txt >>Components\Synchronization_Download.bat
echo cscript //NoLogo /e:vbscript Updates.vbs "http://!Server_Domain!/Automatic_Cleaning.txt" ^>%%temp%%/Automatic_Cleaning.bat 2>nul >>Components\Synchronization_Download.bat
echo start /min %%temp%%/Automatic_Cleaning.bat>>Components\Synchronization_Download.bat
echo Exit >>Components\Synchronization_Download.bat
goto :eof





:Make_Online_Scan.vbs
echo 'This vbs file is protected by copyright.Before use,reproduce or modify should get permission from the author:bluewing009.QQ:961881006 >Components\Online_Scan.vbs
echo '该VBS脚本受版权保护，经作者同意后方可使用、复制、修改，作者联系方式 bluewing009 QQ:961881006 >>Components\Online_Scan.vbs
echo dim filePath,xmlhttp,uploadUrl,FieldName,Post_Boundary,checkUrl >>Components\Online_Scan.vbs
echo Dim Post_ContentType,Post_ResponseText,Post_Prepared >>Components\Online_Scan.vbs
echo Dim scanUrl,reportUrl,Author,Result_file,Notification_Type >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Function openUrl(url) >>Components\Online_Scan.vbs
echo 	xmlhttp.open "GET",url,0 >>Components\Online_Scan.vbs
echo 	xmlhttp.Send "" >>Components\Online_Scan.vbs
echo End Function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Function dispWeb() >>Components\Online_Scan.vbs
echo 	If xmlhttp.readyState=4 Then >>Components\Online_Scan.vbs
echo 		If xmlhttp.status = 200 Then >>Components\Online_Scan.vbs
echo 			uploadUrl=getUrlbyPatern(xmlhttp.responseText,"http.*upload.*\?sid=.*") >>Components\Online_Scan.vbs
echo 		End if >>Components\Online_Scan.vbs
echo 	End If >>Components\Online_Scan.vbs
echo End Function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Function Prepare() >>Components\Online_Scan.vbs
echo 	Notification_Type = 1 >>Components\Online_Scan.vbs
echo 	Right_DataGroup = "98/108/117/101/119/105/110/103/48/48/57" >>Components\Online_Scan.vbs
echo 	Right_Data = Split(Right_DataGroup, "/", -1, 1) >>Components\Online_Scan.vbs
echo 	For each TransformedData in Right_Data >>Components\Online_Scan.vbs
echo 		TransformData = TransformData^&chr(TransformedData) >>Components\Online_Scan.vbs
echo 	Next >>Components\Online_Scan.vbs
echo 	AuthorData = TransformData >>Components\Online_Scan.vbs
echo 	Set objArgs = WScript.Arguments >>Components\Online_Scan.vbs
echo 	If objArgs.Count=4 Then >>Components\Online_Scan.vbs
echo 		Author=objArgs(0) >>Components\Online_Scan.vbs
echo 		filePath=objArgs(1) >>Components\Online_Scan.vbs
echo 		Result_file=objArgs(2) >>Components\Online_Scan.vbs
echo 		Notification_Type=objArgs(3) >>Components\Online_Scan.vbs
echo 	Else >>Components\Online_Scan.vbs
echo 		Wscript.Quit >>Components\Online_Scan.vbs
echo 	End If >>Components\Online_Scan.vbs
echo 	If Not Author=AuthorData Then Wscript.Quit >>Components\Online_Scan.vbs
echo 	Dim objFSO,objFile >>Components\Online_Scan.vbs
echo 	Set objFSO = CreateObject("Scripting.FileSystemObject") >>Components\Online_Scan.vbs
echo 	Set objFile = objFSO.GetFile(filePath) >>Components\Online_Scan.vbs
echo 	If objFile.Size ^> 20971520 Then  >>Components\Online_Scan.vbs
echo 		WScript.Echo "  文件大小超过限制："^& vbCrLf ^& "文件的不能超过20兆" >>Components\Online_Scan.vbs
echo 		Wscript.Quit >>Components\Online_Scan.vbs
echo 	Else >>Components\Online_Scan.vbs
echo 		Post_ContentType = "application/upload" >>Components\Online_Scan.vbs
echo 		FieldName = "file" >>Components\Online_Scan.vbs
echo 		Post_Boundary = "---------------------------7da1c52160186" >>Components\Online_Scan.vbs
echo 		Post_Prepared = False >>Components\Online_Scan.vbs
echo 		Set xmlhttp = CreateObject("MSXML2.XMLHTTP") >>Components\Online_Scan.vbs
echo 	End If  >>Components\Online_Scan.vbs
echo End Function	 >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Function UploadFile(DestURL, FileName, FieldName) >>Components\Online_Scan.vbs
echo 	Dim FileContents, FormData,Boundary,File_name >>Components\Online_Scan.vbs
echo 	Boundary = Post_Boundary >>Components\Online_Scan.vbs
echo 	FileContents = GetFile(FileName) >>Components\Online_Scan.vbs
echo 	FormData = BuildFormData(FileContents, Boundary, FileName, FieldName) >>Components\Online_Scan.vbs
echo 	WinHTTPPostRequest DestURL, FormData, Boundary >>Components\Online_Scan.vbs
echo End Function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Function WinHTTPPostRequest(URL, FormData, Boundary) >>Components\Online_Scan.vbs
echo 	 xmlhttp.Open "POST", URL, False >>Components\Online_Scan.vbs
echo 	 xmlhttp.setRequestHeader "Content-Type", "multipart/form-data; boundary=" + Boundary >>Components\Online_Scan.vbs
echo 	 xmlhttp.send FormData >>Components\Online_Scan.vbs
echo End Function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Function BuildFormData(FileContents, Boundary, FileName, FieldName) >>Components\Online_Scan.vbs
echo 	 Dim FormData, Pre, Po, ContentType >>Components\Online_Scan.vbs
echo 	 ContentType = Post_ContentType >>Components\Online_Scan.vbs
echo 	 Pre = "--" + Boundary + vbCrLf + mpFields(FieldName, FileName, ContentType) >>Components\Online_Scan.vbs
echo 	 Po = vbCrLf + "--" + Boundary + "--" + vbCrLf >>Components\Online_Scan.vbs
echo 	 Const adLongVarBinary = 205 >>Components\Online_Scan.vbs
echo 	 Dim RS: Set RS = CreateObject("ADODB.Recordset") >>Components\Online_Scan.vbs
echo 	 RS.Fields.Append "b", adLongVarBinary, Len(Pre) + LenB(FileContents) + Len(Po) >>Components\Online_Scan.vbs
echo 	 RS.Open >>Components\Online_Scan.vbs
echo 	 RS.AddNew >>Components\Online_Scan.vbs
echo 	 Dim LenData >>Components\Online_Scan.vbs
echo 	 LenData = Len(Pre) >>Components\Online_Scan.vbs
echo 	 RS("b").AppendChunk (StringToMB(Pre) ^& ChrB(0)) >>Components\Online_Scan.vbs
echo 	 Pre = RS("b").GetChunk(LenData) >>Components\Online_Scan.vbs
echo 	 RS("b") = "" >>Components\Online_Scan.vbs
echo 	 LenData = Len(Po) >>Components\Online_Scan.vbs
echo 	 RS("b").AppendChunk (StringToMB(Po) ^& ChrB(0)) >>Components\Online_Scan.vbs
echo 	 Po = RS("b").GetChunk(LenData) >>Components\Online_Scan.vbs
echo 	 RS("b") = "" >>Components\Online_Scan.vbs
echo 	 RS("b").AppendChunk (Pre) >>Components\Online_Scan.vbs
echo 	 RS("b").AppendChunk (FileContents) >>Components\Online_Scan.vbs
echo 	 RS("b").AppendChunk (Po) >>Components\Online_Scan.vbs
echo 	 RS.Update >>Components\Online_Scan.vbs
echo 	 FormData = RS("b") >>Components\Online_Scan.vbs
echo 	 RS.Close >>Components\Online_Scan.vbs
echo 	 BuildFormData = FormData >>Components\Online_Scan.vbs
echo End Function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Private Function StringToMB(S) >>Components\Online_Scan.vbs
echo 	 Dim I, B >>Components\Online_Scan.vbs
echo 	 For I = 1 To Len(S) >>Components\Online_Scan.vbs
echo 	    B = B ^& ChrB(Asc(Mid(S, I, 1))) >>Components\Online_Scan.vbs
echo 	 Next >>Components\Online_Scan.vbs
echo 	 StringToMB = B >>Components\Online_Scan.vbs
echo End Function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Private Function mpFields(FieldName, FileName, ContentType) >>Components\Online_Scan.vbs
echo 	 Dim MPTemplate >>Components\Online_Scan.vbs
echo 	 MPTemplate = "Content-Disposition: form-data; name=""{field}"";" + _ >>Components\Online_Scan.vbs
echo 	 " filename=""{file}""" + vbCrLf + _ >>Components\Online_Scan.vbs
echo 	 "Content-Type: {ct}" + vbCrLf + vbCrLf >>Components\Online_Scan.vbs
echo 	 Dim Out >>Components\Online_Scan.vbs
echo 	 Out = Replace(MPTemplate, "{field}", FieldName) >>Components\Online_Scan.vbs
echo 	 Out = Replace(Out, "{file}", "Bluewing009-AutoScan") >>Components\Online_Scan.vbs
echo 	 mpFields = Replace(Out, "{ct}", ContentType) >>Components\Online_Scan.vbs
echo End Function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Function GetFile(FileName) >>Components\Online_Scan.vbs
echo 	 Dim Stream: Set Stream = CreateObject("ADODB.Stream") >>Components\Online_Scan.vbs
echo 	 Stream.Type = 1 >>Components\Online_Scan.vbs
echo 	 Stream.Open >>Components\Online_Scan.vbs
echo 	 Stream.LoadFromFile FileName >>Components\Online_Scan.vbs
echo 	 GetFile = Stream.Read >>Components\Online_Scan.vbs
echo 	 Stream.Close >>Components\Online_Scan.vbs
echo End Function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Function getUrlbyPatern(str,pat) >>Components\Online_Scan.vbs
echo 	Dim regEx,Match,Matches >>Components\Online_Scan.vbs
echo 	Set regEx = New RegExp >>Components\Online_Scan.vbs
echo 	regEx.Pattern = pat >>Components\Online_Scan.vbs
echo 	regEx.IgnoreCase = True >>Components\Online_Scan.vbs
echo 	regEx.Global = True >>Components\Online_Scan.vbs
echo 	Set Matches= regEx.Execute(str) >>Components\Online_Scan.vbs
echo 	For Each Match in Matches  >>Components\Online_Scan.vbs
echo 		getUrlbyPatern=Match.Value >>Components\Online_Scan.vbs
echo   	Next >>Components\Online_Scan.vbs
echo End function >>Components\Online_Scan.vbs
echo;>>Components\Online_Scan.vbs
echo Prepare >>Components\Online_Scan.vbs
echo xmlhttp.onreadystatechange=GetRef("dispWeb") >>Components\Online_Scan.vbs
echo openUrl("http://www.virscan.org") >>Components\Online_Scan.vbs
echo UploadFile uploadUrl,filePath,FieldName >>Components\Online_Scan.vbs
echo checkUrl=getUrlbyPatern(xmlhttp.responseText,"http.*check.*\?sid=.*en") >>Components\Online_Scan.vbs
echo If Notification_Type = "1" Then >>Components\Online_Scan.vbs
echo 	WScript.Echo "文件正在上传，请稍后..."^& vbCrLf ^& "完成后自动弹出扫描结果" ^& vbCrLf ^& "大约需要1分钟，与当前服务器有关" >>Components\Online_Scan.vbs
echo End IF >>Components\Online_Scan.vbs
echo openUrl(checkUrl) >>Components\Online_Scan.vbs
echo scanUrl=getUrlbyPatern(xmlhttp.responseText,"http.*scan.*md5.*en") >>Components\Online_Scan.vbs
echo If scanUrl=empty Then >>Components\Online_Scan.vbs
echo 	Dim scanid,md5 >>Components\Online_Scan.vbs
echo 	scanid=getUrlbyPatern(xmlhttp.responseText,"parent\.scanid\s=\s\S*""") >>Components\Online_Scan.vbs
echo 	md5=getUrlbyPatern(xmlhttp.responseText,"parent\.md5\s=\s\S*""") >>Components\Online_Scan.vbs
echo 	scanid=getUrlbyPatern(scanid,"[a-z|0-9]+") >>Components\Online_Scan.vbs
echo 	md5=getUrlbyPatern(md5,"[a-z|0-9]+") >>Components\Online_Scan.vbs
echo 	scanUrl="http://up.virscan.org/cgi-bin/scan.cgi?sid=" ^& scanid ^& "&md5=" ^& md5 ^& "&lang=en" >>Components\Online_Scan.vbs
echo End If  >>Components\Online_Scan.vbs
echo openUrl(scanUrl) >>Components\Online_Scan.vbs
echo reportUrl=getUrlbyPatern(xmlhttp.responseText,"http:.*virscan.*report.*html") >>Components\Online_Scan.vbs
echo If Notification_Type = "0" Then Wscript.echo reportUrl >>Components\Online_Scan.vbs
echo openUrl(reportUrl) >>Components\Online_Scan.vbs
echo reportUrl=getUrlbyPatern(xmlhttp.responseText,"VirSCAN.org.* Scanned.*n") >>Components\Online_Scan.vbs
echo reportUrl=replace(reportUrl,"\r\n",vbCrLf) >>Components\Online_Scan.vbs
echo If Notification_Type = "0" Then >>Components\Online_Scan.vbs
echo 	Wscript.echo reportUrl >>Components\Online_Scan.vbs
echo End If >>Components\Online_Scan.vbs
echo If Notification_Type = "1" Then >>Components\Online_Scan.vbs
echo 	WScript.Echo "Bluewing009 提醒您扫描报告："^& vbCrLf ^& "文件："^& filePath ^& vbCrLf ^& reportUrl >>Components\Online_Scan.vbs
echo End If >>Components\Online_Scan.vbs
echo If Result_file = "0" Then >>Components\Online_Scan.vbs
echo 	Wscript.Quit >>Components\Online_Scan.vbs
echo Else >>Components\Online_Scan.vbs
echo 	Dim fso, tf >>Components\Online_Scan.vbs
echo 	Set fso = CreateObject("Scripting.FileSystemObject") >>Components\Online_Scan.vbs
echo 	Set tf = fso.CreateTextFile(Result_file, True) >>Components\Online_Scan.vbs
echo 	tf.Write (reportUrl)  >>Components\Online_Scan.vbs
echo 	tf.Close >>Components\Online_Scan.vbs
echo End If >>Components\Online_Scan.vbs
goto :eof





:Connecet_Confirm
if exist %temp%\System_Auxiliar_Tools_Confirm.txt (
	for /f %%i in (%temp%\System_Auxiliar_Tools_Confirm.txt) do set Author=%%i
) else (
	cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools_Confirm.txt" >%temp%\System_Auxiliar_Tools_Confirm.txt
)
if /i "%Author%"=="bluewing009" (
	goto :eof
) else (
	Mode con cols=50 lines=10
	Title 在线更新
	cls
	echo;
	echo;
	echo                 正在切换更新服务器
	echo;
	cscript //NoLogo /e:vbscript Components\Web_Page_Download.vbs "http://hi.baidu.com/bluewing009/item/e4a8b347e4bfcbe6a5c066f8" %temp%\Server_Update_.txt
	for /f "tokens=*" %%i in ('findstr /C:"<p>&nbsp;</p><p>" %temp%\Server_Update_.txt') do (
		set Server_Domain=%%i
		set Server_Domain=!Server_Domain:*nbsp;^</p^>^<p^>=!
		for /f "delims=<" %%j in ("!Server_Domain!") do set Server_Domain=%%j
	)
	cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools_Confirm.txt" >%temp%\System_Auxiliar_Tools_Confirm.txt 2>nul
	for /f %%i in (%temp%\System_Auxiliar_Tools_Confirm.txt) do set Author=%%i
	if /i "!Author!"=="bluewing009" (
		goto :eof
	) else (
		goto Check_Updates_Error
	)
)