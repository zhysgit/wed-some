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
Title ϵͳ��������
cls
echo;
echo   ����������������������������������
echo   ��                                                              ��
echo   ��               ϵ ͳ �� �� �� ��                              ��
echo   ��                                                              ��
echo   ��             System  Auxiliar  Tools                   V5.11  ��
echo   ��                                                              ��
echo   ��                                                              ��
echo   ��                               Author ��    ��Ӱ  bluewing009 ��
echo   ��                                    QQ��       961881006      ��
echo   ��                                                              ��
echo   ����������������������������������
echo;
echo;
echo       ˵����
echo;
echo            �����ڽ���������߰�ȫ����޷�����ʱ����ϵͳ�����޸�
echo;
echo;
echo                      %OS_Version% 
echo;
echo                 %date:~0,4%��%date:~5,2%��%date:~8,2%��  ����%date:~-1,1%    %time:~0,2%ʱ%time:~3,2%��
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
Title ������ȫ����
cls
echo     �����Զ��رճ�ϵͳ������н��̱��ⲡ��פ��
echo;
echo   ���������ʱ�����ã����˵�ѡ���˳������Զ��ָ�
echo;
echo                �뱣��δ��ɵĹ���
echo;
echo                Y ��ʼ  ����������
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==Y goto Build_Safe
goto Build_Safe_Jump



:Build_Safe
Title By:Bluewing009
set /a NO._All=NO._Succeed=NO.=0
cls
if not exist %WinDir%\system32\ntsd.exe (
    echo;
    echo       δ���ּ�ǿ��������п��ܲ��������޷����
    echo;
    echo                    �Ƿ����� ��
    echo;
    echo               Y ��ʼ  ����������
    echo;
    set choose=~
    set /p choose=��ѡ��
    if /I !choose!==Y (
        cls
        echo;
        echo;
        echo;
        echo                   ������.....
        cscript //NoLogo /e:vbscript Components\Web_Download.vbs "http://!Server_Domain!/ntsd.txt" %WinDir%\system32\ntsd.exe
    )
)
cls
echo;
echo                     ���ڹ���
echo;
echo                       �Ժ�
taskkill /f /im explorer.exe >nul 2>nul
set Safe_Environment_Mark=Y
for /f "skip=5 tokens=1" %%p in ('tasklist^|findstr /v /i "wininit.exe cmd.exe svchost.exe lsass.exe services.exe winlogon.exe csrss.exe smss.exe lsm.exe conhost.exe WmiPrvSE.exe"') do (
    taskkill /f /im %%p >nul 2>nul||(
        if exist %system%\ntsd.exe (
            start /min ntsd -c q -pn %%p >nul 2>nul
            ping /n 1 127.1>nul
            tasklist /fi "IMAGENAME eq ntsd.exe"|findstr /i "û������"  && set /a NO._Succeed+=1
            taskkill /f /im ntsd.exe >nul 2>nul
        )
    )
)
if %version_mark%==win7 taskkill /f /t /im cmd.exe /fi "windowtitle ne ����Ա:  By:Bluewing009" >nul 2>nul
if %version_mark%==xp taskkill /f /t /im cmd.exe /fi "windowtitle ne By:Bluewing009" >nul 2>nul
set /a NO.=%NO._All%-%NO._Succeed%
echo;
echo;
echo                     �������
if not %NO.%==0 (
    echo;
    echo            ���� %NO.% �����޷��ر�
)
(tasklist /M >>Log\!log_date!.dat) 2>nul
echo;
echo;
echo       ����������˳�����Ȼ������̽��޷�����
ping /n 3 127.1>nul
goto Main



:Build_Safe_Jump
set Safe_Environment_Mark=N
cls
echo;
echo;
echo;
echo;
echo                       ����
(echo ����������ȫ���� >>Log\!log_date!.dat) 2>nul
ping /n 2 127.1>nul
goto Main





:Main
set Version_New=δ֪
set Version_Update=���߸���
set Visitors=~
(
	if exist %temp%\System_Auxiliar_Tools_Count.txt for /f %%i in (%temp%\System_Auxiliar_Tools_Count.txt) do set Visitors=%%i
	if exist %temp%\System_Auxiliar_Tools_Version.txt for /f  %%i in (%temp%\System_Auxiliar_Tools_Version.txt) do set Version_New=%%i
	if not !Version_New!==δ֪ (
		if not !Version_New!==!Version_Now! (
			set Version_Update=���߸���  !Version_Now! �� !Version_New!
		)
	)
	if exist %temp%\System_Auxiliar_Tools_Confirm.txt (
		for /f %%i in (%temp%\System_Auxiliar_Tools_Confirm.txt) do set Author=%%i
		for /f "usebackq tokens=1* delims=:" %%i in (`findstr /n .* %0`) do if %%i==25 for /f "tokens=5" %%m in ('%%j') do set Author_Check=%%m
		if /i not "!Author!"=="!Author_Check!" set Version=Piracy && goto Online_Updates
	)
) 2>nul
Mode con cols=70 lines=25
Title ϵͳ��������
cls
echo;
if not "%Visitors%"=="~" (
	call :Color_Visitors %Visitors%
) else (
	call :Color_Offline
)
echo;
echo                         �� �� �� ��
echo;
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                             ����
echo                             ����
echo       A. ϵͳɨ��           ����     B. ϵͳ�޸�
echo                             ����
echo                             ����
echo       C. ϵͳ����           ����     D. ϵͳ����
echo                             ����
echo                             ����
echo       E. ϵͳ��Ϣ           ����     F. %Version_Update%
echo                             ����
echo                             ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo;
echo;
echo                         Q. �� ��
echo;
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto System_Scan
if /I %choose%==b goto System_Repair
if /I %choose%==c goto System_Protection
if /I %choose%==d goto System_Assistant
if /I %choose%==e goto System_Information
if /I %choose%==f goto Online_Updates
if /I %choose%==q goto Exit
if /I %choose%==~ (
    echo;
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto Main
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto Main



:System_Scan
Mode con cols=70 lines=25
Title  ϵͳɨ��
cls
echo;
echo                         �� �� �� ��
echo;
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                            ����
echo                            ����
echo    A. ϵͳ�޸�ɨ��         ����     B. ������ɨ��
echo                            ����
echo                            ����
echo    C. ���ɶ˿�ɨ��         ����     D. IEFO�ٳ�ɨ��
echo                            ����
echo                            ����
echo    E. ϵͳ�ؼ�λ�ÿ���     ����     
echo                            ����
echo                            ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo;
echo;
echo                       Q.�������˵�
echo;
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto System_Repair_Scan
if /I %choose%==b goto Startup_Items_Scan
if /I %choose%==c goto Doubtful_Port_Scan
if /I %choose%==d goto IEFO_Hijack_Scan
if /I %choose%==e goto Key_Position_Photograph
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto System_Scan
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto System_Scan



:System_Repair
Mode con cols=70 lines=25
Title  ϵͳ�޸�
cls
echo;
echo                         �� �� �� ��
echo;
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                            ����
echo                            ����
echo    A. �ļ���αװ�޸�       ����     B. ��ȫģʽ�޸�
echo                            ����
echo                            ����
echo    C. HOSTS�ļ��޸�        ����     D.    U���޸�
echo                            ����
echo                            ����
echo    E.  Winsock�޸�         ����     F. �����������޸�
echo                            ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo;
echo;
echo                       Q.�������˵�
echo;
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto Camouflage_Folder_Repair
if /I %choose%==b goto Safemode_Repair
if /I %choose%==c goto Hosts_Repair
if /I %choose%==d goto DriveU_Repair
if /I %choose%==e goto Winsock_Repair
if /I %choose%==f goto Network_Setup_Repair
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto System_Repair
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto System_Repair



:System_Protection
Mode con cols=70 lines=25
Title  ϵͳ����
cls
echo;
echo                         �� �� �� ��
echo;
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                            ����
echo                            ����
echo    A. ϵͳ������Ŀ����     ����     B. ����Է���
echo                            ����
echo                            ����
echo    C. ActiveX���߷���      ����     D. �������߷���
echo                            ����
echo                            ����
echo    E. ϵͳ���Է���         ����   
echo                            ����
echo                            ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo;
echo;
echo                       Q.�������˵�
echo;
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto System_Sensitive_Protection
if /I %choose%==b goto Group_Policy_Protection
if /I %choose%==c goto ActiveX_Immune
if /I %choose%==d goto Virus_Immune
if /I %choose%==e goto Login_Message_Send
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto System_Protection
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto System_Protection



:System_Assistant
Mode con cols=70 lines=25
Title  ϵͳ����
cls
echo;
echo                         �� �� �� ��
echo;
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo                            ����
echo                            ����
echo    A. ǿ��ɾ������         ����     B. ϵͳ��¼֪ͨ
echo                            ����
echo                            ����
echo    C. ��������¼����/�ָ�  ����     D. ����ϵͳ����  
echo                            ����
echo                            ����
echo    F. ϵͳ�������ʼ��     ����     G. һ���ϴ���ɨ��
echo                            ����
echo                            ����
echo  �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��
echo;
echo;
echo                       Q.�������˵�
echo;
echo;
set choose=~
set /p choose=��ѡ��
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
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto System_Assistant
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto System_Assistant





:System_Repair_Scan
Title ϵͳ�޸�ɨ��
Mode con cols=70 lines=15
set /a NO.=NO._=NO._Abnormal=NO._Succeed=NO._Fail=0
cls
for %%x in (
    "HideClock :           ϵͳ֪ͨ����ʱ��                   "
    "LockTaskbar :           ���������޸�����                   "
    "NoActiveDesktop :             �������Ŀ                     "
    "NoActiveDesktopChanges :             ��������                     "
    "NoAddPrinter :             ��Ӵ�ӡ��                       "
    "NoAutoUpdate :           Windows�Զ�����                    "
    "NoBandCustomize :      ���鿴���еġ�������������              "
    "NoCDBurning :             CD��¼����                       "
    "NoChangeStartMenu :       ����ʼ���˵��е��޸�����               "
    "NoClose :    ����ʼ���˵��еġ��ر�ϵͳ��ѡ��          "
    "NoCloseDragDropBands :      ���鿴���еġ���������ѡ��              "
    "NoComputersNearMe :  �������ھӡ��еġ��Ҹ����ļ������ѡ��      "
    "NoDeletePrinter :             ɾ����ӡ��                       "
    "NoDesktop :             �����桱״̬                     "
    "NoExpandedNewMenu :     �ļ�ѡ���еġ��½���ѡ��                 "
    "NoEntireNetwork :     �������ھӡ��еġ���������ѡ�         "
    "NoFavoritesMenu :    ����ʼ���˵��еġ��ղؼС�ѡ��            "
    "NoFileAssociate :          �ļ�ѡ�����ļ�����                  "
    "NoFileMenu :         ��Դ�������е��ļ��˵�               "
    "NoFind :    ����ʼ���˵��еġ����ҡ�ѡ��              "
    "NoFolderOptions :    ����ʼ���˵��еġ��ļ��С�ѡ��            "
    "NoHardwareTab :     ��������塱�еġ�Ӳ����ѡ��             "
    "NoInternetIcon :           ���桰IE��ͼ��                     "
    "NoLogOff :    ����ʼ���˵��еġ�ע����ѡ��              "
    "NoLowDiskSpaceChecks :           Ӳ�̿ռ䲻�㾯��                   "
    "NoManageMyComputerVerb :      ���ҵĵ��ԡ��Ҽ�������ѡ��            "
    "NoMovingBands :            �����桱������                    "
    "NoNetConnectDisconnect :           ����������ѡ��                     "
    "NoNetHood :        ����ġ������ھӡ�ͼ��                "
    "NoNetworkConnections :    ����ʼ���˵��еġ��������ӡ�ѡ��          "
    "NoPrinterTabs :              ��ӡ��������                    "
    "NoPropertiesMyComputer :      ���ҵĵ��ԡ��Ҽ������ԡ�ѡ��            "
    "NoPropertiesMyDocuments :      ���ҵ��ĵ����Ҽ������ԡ�ѡ��            "
    "NoPropertiesRecycleBin :     ������վ���Ҽ��˵��ġ����ԡ�ѡ��         "
    "NoRecentDocsHistory :      ���ĵ�����ֻ��ʾ�����ļ�                "
    "NoRecentDocsMenu :     ����ʼ���˵��еġ���������ĵ���ѡ��     "
    "NoRecentDocsNetHood :    �������ھӡ��ġ������ļ��С�ѡ��          "
    "NoRun :    ����ʼ���˵��еġ����С�ѡ��              "
    "NoRunasInstallPrompt :           �������û���װ����                 "
    "NoSetActiveDesktop :    ����ʼ���˵��С�����桱ѡ��            "
    "NoSetFolders :     ����ʼ���˵��еġ����á�ѡ��             "
    "NoSetTaskbar :            �˵������޸�����                  "
    "NoSharedDocuments :    ���ҵĵ��ԡ��еġ������ĵ���              "
    "NoShellSearchButton :    ����Դ���������еġ���������ť            "
    "NoSMHelp :    ����ʼ���˵��еġ�������֧�֡�ѡ��        "
    "NoSMMyDocs :    ����ʼ���˵��еġ��ҵ��ĵ���ѡ��          "
    "NoSMMyPictures :    ����ʼ���˵��еġ��ҵ�ͼƬ��ѡ��          "
    "NoStartMenuMFUProgramsList :    ����ʼ���˵��еġ����ó����б�ѡ��      "
    "NoStartMenuMorePrograms :    ����ʼ���˵��еġ����г���ѡ��          "
    "NoStartMenuMyMusic :    ����ʼ���˵��еġ��ҵ����֡�ѡ��          "
    "NoStartMenuSubFolders :    ����ʼ���еġ��û��ļ��С�ѡ��            "
    "NoStartMenuMyDocs :              ����ʼ�����ҵ����֡�            "
    "NoThumbnailCache :              ����ͼ����                      "
    "NoTrayContextMenu :              �������Ҽ�                      "
    "NoTrayItemsDisplay :             ϵͳ����ͼ��                     "
    "NoUserNameInStartMenu :     ����ʼ���˵��еġ��û�����ѡ��           "
    "NoViewContextMenu :              �����Ҽ�                        "
    "Noviewondrive :            ��ֹ�����̷�                      "
    "NoWebView :            Webҳ�鿴��ʽ                     "
    "NoWelcomeScreen :          ��¼ʱ����ӭ��Ļ��                  "
    "NoWindowsUpdate :    ��WindowsUpdate���ķ��ʺ�����             "
    "NoWinKeys :             WinKeys��                        "
    "Start_ShowControlPanel :    ����ʼ���˵��еġ�������塱ѡ��          "
    "Start_ShowMyComputer :    ����ʼ���˵��еġ��ҵĵ��ԡ�ѡ��          "
    "Start_ShowNetConn :    ����ʼ���˵��еġ������ھӡ�ѡ��          "
    "StartMenuLogOff :    ����ʼ���˵��еġ�ע����ѡ��              "
    "ForceClassicControlPanel :         ��������塱��ʽ����                 "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=����
        set Repair_%Registry_Scan_Key%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explore\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!       
    )
)

for %%x in (
    "NoDrives :             ������ʾ                         "
    "Noviewondrive :             �������                         "

) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=����
        set Repair_%Registry_Scan_Key%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            set Status_%Registry_Scan_Key%=�쳣
            set /a NO._Abnormal+=1
            reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Key! /f >nul 2>nul
            if !errorlevel!==1 (
                set Repair_!Registry_Scan_Key!=  ��
                set /a NO._Fail+=1
            )
            if !errorlevel!==0 (
                set Repair_!Registry_Scan_Key!=  ��
                set /a NO._Succeed+=1
            )
            echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
        )
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            set Status_%Registry_Scan_Key%=�쳣
            set /a NO._Abnormal+=1
            reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v !Registry_Scan_Key! /f >nul 2>nul
            if !errorlevel!==1 (
                set Repair_!Registry_Scan_Key!=  ��
                set /a NO._Fail+=1
            )
            if !errorlevel!==0 (
                set Repair_!Registry_Scan_Key!=  ��
                set /a NO._Succeed+=1
            )
            echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\%%e" !errorlevel! >>Log\!log_date!.dat
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!         
    )
)

for %%x in (
    "Disableregistrytools :                ע���                        "
    "DisableSR :                ϵͳ��ԭ                      "
    "DisableTaskmgr :              ���������                      "
    "NoConfigPage :            ϵͳ���ԡ�Ӳ�����á�              "
    "Nocontrolpanel :   ��������塱�еġ����/ɾ������Ŀ          "
    "NoDevMgrPage :           ϵͳ���ԡ��豸����               "
    "NoDispAppearancePage :         �Ի����С���ۡ�ѡ��                 "
    "NoDispBackgroundPage :         �Ի����С�������ѡ��                 "
    "NoDispScrSavPage :       �Ի����С���Ļ������ѡ��               "
    "NoDispSettingsPage :         �Ի����С����á�ѡ��                 "
    "NoFileSysPage :          ϵͳ���ԡ��ļ�ϵͳ��                "
    "NoVirtMemPage :          ϵͳ���ԡ������ڴ桱                "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=����
        set Repair_%Registry_Scan_Key%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set v%%s=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)


for %%x in (
    "accessibility :           IE���������ܡ���ť                 "
    "advanced :          Internet�߼�ҳ�������              "
    "advancedTab :   ��Internetѡ��еġ��߼�����             "
    "Autoconfig :        �����������е��Զ���������            "
    "cache :             IE��ʱ�ļ�                       "
    "CalendarContact :         ��������ϵ������                     "
    "Certificates :               IE֤������                     "
    "Check_If_Default :             Ĭ����������                   "
    "colour :           IE����ɫ����ť                     "
    "ConnectionsTab :   ��Internetѡ��еġ����ӡ���             "
    "ContentTab :   ��Internetѡ��еġ����ݡ���             "
    "fonts :           IE�����塱��ť                     "
    "FormSuggest :             �����Զ����                   "
    "GeneralTab :   ��Internetѡ��еġ����桱��             "
    "history :       IE�������ʷ��¼����ť                 "
    "HomePage :             IE��ҳ����                       "
    "languages :           IE�����ԡ���ť                     "
    "Messaging :    �����ʼ����������Internet��������        "
    "PrivacyTab :   ��Internetѡ��еġ���˽����             "
    "Profiles :         IE�����ļ���������                   "
    "ProgramsTab :   ��Internetѡ��еġ�������             "
    "Proxy :     �����������еĴ������������             "
    "Ratings :              IE�ּ�����                      "
    "ResetWebSettings :              ����Web����                     "
    "SecurityTab :   ��Internetѡ��еġ���ȫ����             "
    "settings :           IE�����á���ť                     "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=����
        set Repair_%Registry_Scan_Key%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Control Panel\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Control Panel\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )                                 
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

for %%x in (
    "NoBrowserClose :     IE���ļ����еġ��رա�����               "
    "NoBrowserOptions :  IE�����ߡ��еġ�Internetѡ�����          "
    "NoViewSource :   IE���鿴���еġ�Դ�ļ�������               "
    "NoFileNew :  IE���ļ����еġ����´��ڡ�����            "
    "NoFileOpen :     IE���ļ����еġ��򿪡�����               "
    "NoTheaterMode :   IE���鿴���еġ�ȫ����ʾ������             "
    "NoBrowserSaveAS :       IE���ļ���ѡ���С����Ϊ������         "
    "NoHelpMenu :          IE��������ѡ��                    "
) do (
    for /f "tokens=1,* delims=:" %%e in ("%%x") do (
        set Registry_Scan_Key_Temporary=%%e
        set Registry_Scan_Key=!Registry_Scan_Key_Temporary:~1,-1!
        set Registry_Scan_Function_Temporary=%%f
        set Registry_Scan_Function=!Registry_Scan_Function_Temporary:~1,-1!
        set Status_%Registry_Scan_Key%=����
        set Repair_%Registry_Scan_Key%=����Ҫ
        set /a NO.+=1
        for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Restrictions\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
            for /f "usebackq tokens=3" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions" 2>nul"^|findstr /i !Registry_Scan_Key!`) do (
            if "%%i"=="0x1" (
                set Status_%Registry_Scan_Key%=�쳣
                set /a NO._Abnormal+=1
                reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v !Registry_Scan_Key! /f >nul 2>nul
                if !errorlevel!==1 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Fail+=1
                )
                if !errorlevel!==0 (
                    set Repair_!Registry_Scan_Key!=  ��
                    set /a NO._Succeed+=1
                )
                echo "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Internet Explorer\Restrictions\!Registry_Scan_Key!" !errorlevel! >>Log\!log_date!.dat
            )
        )
    call :Registry_Scan_Monitor "!Registry_Scan_Function!" !Status_%Registry_Scan_Key%! !Repair_%Registry_Scan_Key%! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

set Repair_exe=����Ҫ
set Repair_bat=����Ҫ
set Repair_txt=����Ҫ
set Repair_ini=����Ҫ
set Repair_vbs=����Ҫ
set Repair_com=����Ҫ

for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.exe" ^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="exefile" (
        set Status_exe=����
    ) else (
        set Status_exe=�쳣
        set /a NO._Abnormal+=1
        assoc .exe=exefile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_exe=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_exe=  ��
            set /a NO._Succeed+=1
        )
        echo exe�ļ����� !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            exe�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_exe! !Repair_exe! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)

for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.bat"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="batfile" (
        set Status_bat=����
        ) else (
        set Status_bat=�쳣
        set /a NO._Abnormal+=1
        assoc .bat=batfile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_bat=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_bat=  ��
            set /a NO._Succeed+=1
        )
        echo bat�ļ����� !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            bat�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_bat! !Repair_bat! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.txt"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="txtfile" (
        set Status_txt=����
        ) else (
        set Status_txt=�쳣
        set /a NO._Abnormal+=1
        assoc .txt=txtfile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_txt=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_txt=  ��
            set /a NO._Succeed+=1
        )
        echo txt�ļ����� !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            txt�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_txt! !Repair_txt! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.ini"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="inifile" (
        set Status_ini=����
        ) else (
        set Status_ini=�쳣
        set /a NO._Abnormal+=1
        assoc .ini=inifile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_ini=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_ini=  ��
            set /a NO._Succeed+=1
        )
        echo ini�ļ����� !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            ini�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_ini! !Repair_ini! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)


for /f "tokens=3" %%i in ('reg query "HKEY_CLASSES_ROOT\.com"^| find /i "(Ĭ��)"') do (
    set /a NO.+=1
    if "%%i"=="comfile" (
    set Status_com=����
    ) else (
        set Status_com=�쳣
        set /a NO._Abnormal+=1
        assoc .com=comfile >nul 2>nul
        if !errorlevel!==1 (
            set Repair_com=  ��
            set /a NO._Fail+=1
        )
        if !errorlevel!==0 (
            set Repair_com=  ��
            set /a NO._Succeed+=1
        )
        echo com�ļ����� !errorlevel! >>Log\!log_date!.dat
    )
    set Key_Name=            com�ļ�����                      
    call :Registry_Scan_Monitor "!Key_Name!" !Status_com! !Repair_com! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
)

cls
echo;&&echo;&&echo;&&echo;
echo        ɨ�裺116         �쳣��!NO._Abnormal!         �޸���!NO._Succeed!     ʧ�� !NO._Fail!
ping /n 5 127.1>nul
goto Main



:Registry_Scan_Monitor
cls
echo;
echo            ��  ��  ��  Ŀ                       ״̬          �޸�
echo =====================================================================
echo %~1   %2         %3
echo =====================================================================
echo;
echo        ɨ�裺%4/119         �쳣��%5          �޸���%6     ʧ�ܣ�%7
goto :eof





:Startup_Items_Scan
Title ϵͳ������ɨ��
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
echo     �� �� �� �� �� ��
echo;
echo       ������״̬       ���              ������·��
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
				call :colortheword "��!Startup_File_Condition_%%a%%b!!Startup_File_Safe_%%a%%b!��" "  !NO.!.  " "%%a:%%b" !Startup_File_Color_%%a%%b!
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
						call :colortheword "��!Startup_File_Condition_%%a%%b!!Startup_File_Safe_%%a%%b!��" "  !NO.!.  " "%%a:%%b" !Startup_File_Color_%%a%%b!
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
echo     ͳ  ��           ɨ�裺%NO.% ��
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo;
echo    Q �������˵�  �������ѡ��     ? �鿴����
set choose=~
set /p choose=^>
if /I "%Choose%"=="?" goto Startup_Items_Scan_Help
if /I "%Choose%"=="q" goto Main
if /I "%Choose%"=="~" goto Main
if %Choose% equ 0 (
	echo;
	echo                ָ����Ŵ���
	ping /n 2 127.1>nul
	goto Startup_Items_Scan
)
if %Choose% leq %NO.% (
	:Startup_Items_Scan_Action
	cls
	echo;
	echo ��ѡ����Ŀ:
	echo;
	echo !File_%Choose%!
	echo;
	echo  A.��λ���ļ���  B.��λ��ע���  C.ɾ��  Q.������һ��
	echo;
	set choose_=~
	set /p choose_=^>
	if /I "!Choose_!"=="a" (
		start "" "!Explorer_Path_%Choose%!"
		goto Startup_Items_Scan_Action
	)
	if /I "!Choose_!"=="b" (
		reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /t REG_SZ /d "�����\!Registry_Entries_%Choose%!" /f >nul
		regedit
		goto Startup_Items_Scan_Action
	)
	if /I "!Choose_!"=="c" (
		reg delete "!Registry_Entries_%Choose%!" /v !Registry_Value_%Choose%! /f >nul 2>nul
		echo ɾ�����
		ping /n 2 127.1>nu
		goto Startup_Items_Scan_Action
	)
	if /I "!Choose_!"=="q" goto main
	echo;
	echo                ָ���������
	ping /n 2 127.1>nul
	goto Startup_Items_Scan_Action
)
echo;
echo                ָ����Ŵ���
ping /n 2 127.1>nul
goto Startup_Items_Scan



:Startup_Items_Scan_Help
cls
echo;
echo        ϵͳ������ɨ�� - ����
echo;
echo  ɨ���������������ɣ�   ��״̬��   ���   ������
echo;
echo  ״̬��Ϊ���غ��ƶ����֣�
echo;
echo  �����ء���ʾ����������Ŀ����һ�εĲ���
echo;
echo �� ��  �� �������������ֵ����һ����ͬ��
echo;
echo �� ��  �� �����������ϴμ�¼��û�ж������ӵ���Ŀ��
echo;
echo ��Hash�쳣��������Ŀ����ֵ��ͬ���������ļ��仯�ˣ������ǲ�����Ⱦ���£���ע�⡣
echo;
echo ���ƶˡ���ʾ������Ŀ��virscanɨ����
echo;
echo �� δ ֪ �� ��������Ŀ��δ��virscanɨ��������������ļ��ϴ���virscanɨ�衣
echo;
echo �� �� ȫ �� ��������Ŀ����36����ɨ��ȷ���ǰ�ȫ�ġ�
echo;
echo ��������x-36��������Ŀ��ɱ���������������Ϊx��xԽ��Խ���ɣ�x���Ϊ36����
echo;
echo;
echo  ���������...
pause>nul
goto Startup_Items_Scan



:Startup_Items_Scan_Onlinecheck
set Scan_File=%~1
set /a NO.+=1
cscript //NoLogo /e:vbscript Components\md5.vbs "!Scan_File!">>Components\Startup_Photograph.txt 2>nul
if exist Components\Startup_Photograph_Last.txt for /f "delims=:| tokens=1,2,3" %%i in (Components\Startup_Photograph_Last.txt) do set "_%%i%%j=%%k" 2>nul
for /f "delims=:| tokens=1,2,3" %%i in ('cscript //NoLogo /e:vbscript Components\md5.vbs "!Scan_File!"') do (
	set Startup_File_Condition_%%i%%j= ��  �� 
	set Startup_File_Color_%%i%%j=37
	if not defined _%%i%%j (
		set Startup_File_Condition_%%i%%j= ��  �� 
		set Startup_File_Color_%%i%%j=31
	) else (
		if not !_%%i%%j!==%%k (
			set Startup_File_Condition_%%i%%j=Hash�쳣
			set Startup_File_Color_%%i%%j=34
		)
	)
	echo;>"%temp%\virscan_.txt"
	cscript //NoLogo /e:vbscript "Components\Web_Page_Download.vbs" "http://md5.virscan.org/%%k" "%temp%\virscan_.txt" 2>nul
	findstr /C:"was not found on this server." "%temp%\virscan_.txt" >nul 2>nul
	if !errorlevel!==0 (
		set "Startup_File_Safe_%%i%%j= δ ֪ �� "
		start /min wscript //nologo "%~dp0\Components\Online_Scan.vbs" bluewing009 "!Scan_File!" 0 2
	)
	if !errorlevel!==1 (
		findstr /C:"<dt>û���ҵ�md5Ϊ %%k ���ļ�</dt>" "%temp%\virscan_.txt" >nul 2>nul
		if !errorlevel!==0 (
			set "Startup_File_Safe_%%i%%j= δ ֪ �� "
			start /min wscript //nologo "%~dp0\Components\Online_Scan.vbs" bluewing009 "!Scan_File!" 0 2
		)
		if !errorlevel!==1 (
			for /f "tokens=6,7 delims=/^<^(^)" %%a in ('"findstr  .*%%^(.*/.*^)^</a^>^</td^> %temp%\virscan_.txt"') do (
				set Startup_File_Safe_Level_1_%%i%%j=%%a
				set Startup_File_Safe_Level_2_%%i%%j=%%b
			)
			if not defined Startup_File_Safe_Level_1_%%i%%j (
				set "Startup_File_Safe_%%i%%j= δ ֪ �� "
				start /min wscript //nologo "%~dp0\Components\Online_Scan.vbs" bluewing009 "!Scan_File!" 0 2
			) else (
				if "!Startup_File_Safe_Level_1_%%i%%j!"=="0" (set "Startup_File_Safe_%%i%%j= �� ȫ �� ") else (set Startup_File_Safe_%%i%%j=������!Startup_File_Safe_Level_1_%%i%%j!-!Startup_File_Safe_Level_2_%%i%%j!!)
			)
		)
	)
)
goto :eof


:Doubtful_Port_Scan
Title ���ɶ˿�ɨ��
cls
echo;
echo                              �� �� ɨ ��
echo;
echo                          ......���Ժ�......
echo;
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     �˿ں�           ��������                 Ŀ���ַ IP:Port
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
echo                            ������������˵�
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
Title IEFO�ٳ���ɨ��
cls
set /a NO.=0
echo;
echo     IEFO �� �� �� �� �� ��
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo     ���ٳֵĳ�����                     ָ��ĳ���
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
echo     ͳ  ��           ɨ�裺%NO.% ��
ping /n 3 127.1>nul
if %NO.%==0 (
    echo;
	echo;
    echo                            ������������˵�
    pause>nul
    goto Main
) else (
    Mode con cols=50 lines=10
    cls
    echo;
	echo;
    echo              ׼���������IEFO�ٳ���Ŀ
    echo;
    echo              ����������߲�����������
    echo;
    echo              Y ��ʼ  �������������˵�
    echo;
    set choose=~
    set /p choose=��ѡ��
    if /I !choose!==y goto IEFO_Hijack_Scan_clean
    goto IEFO_Hijack_Scan_clean_Pass



:IEFO_Hijack_Scan_clean_Pass
    cls
    echo;&&echo;
    echo                     ����
    echo;&&echo;
    echo                  �������˵�
    ping /n 2 127.1>nul
    goto Main



:IEFO_Hijack_Scan_clean
    cls
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /f >nul 2>nul
    echo;
	echo;
    echo                   ɾ�����
    echo;
	echo;
    echo                  �������˵�
    ping /n 2 127.1>nul
    goto Main
)





:Key_Position_Photograph
Title ϵͳ�ؼ�λ�� system32 �ļ�����
set Key_Position_Photograph_Exist=������
set Key_Position_Photograph_Date=δ֪

:Key_Position_Photograph_Interface
Mode con cols=70 lines=25
cls
if exist "Components\system32_Photograph.txt" (
    set Key_Position_Photograph_Exist=����
    for /f "usebackq delims=" %%d in ("Components\system32_Photograph.txt") do (
        set /a n+=1
        if !n! EQU 1 set Key_Position_Photograph_Date=%%d
    )
)
echo;
echo            ͨ����ϵͳ�ؼ�Ŀ¼ system32 ���п��ա��Ա�
echo;
echo                  ���㼰ʱ����ϵͳ�ļ��ı仯
echo;
echo;
echo      ���ռ�¼��%Key_Position_Photograph_Exist%         ��¼ʱ�䣺%Key_Position_Photograph_Date%
echo;
echo                         ��ǰϵͳʱ�䣺%date%
echo;
echo    ����ѡ�
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo          A.��ʼ�Ա�
echo;
echo          B.�Ե�ǰ��ϵͳ���ã����±�׼��¼
echo;
echo          C.�鿴��׼��¼
echo;
echo          Q.�������˵�
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
set choose=~
set /p choose=��ѡ��
if /i %choose%==a goto Key_Position_Photograph_Differ
if /i %choose%==b goto Key_Position_Photograph_Update
if /i %choose%==c goto Key_Position_Photograph_Standard
if /i %choose%==q goto Main
if /i %choose%==~ (
    echo;
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto Key_position_Photograph
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto Key_position_Photograph



:Key_Position_Photograph_Differ
Mode con cols=70 lines=10
cls
if not exist "Components\system32_Photograph.txt" (
    echo;
    echo;
    echo;
    echo                         δ���ֱ�׼��¼������¡�
    ping /n 3 127.1>nul
    goto Key_Position_Photograph_Interface
)
echo;
echo;
echo                            ���ڶԱȼ�¼�����Ժ�...
echo %date%>%temp%\mark_mow.txt
dir /b /s %windir%\System32  >>%temp%\mark_mow.txt
findstr /i /v /g:"Components\system32_Photograph.txt" %temp%\mark_mow.txt >%temp%\differ.txt
cls
echo;
echo                                  ��  ��
echo;
echo                            ��ʾ������ļ���
echo;
ping /n 3 127.1>nul
start %temp%\differ.txt
echo;
echo;
echo                 û����ʾ�ļ���˵��ϵͳ�ؼ�λ��δ�����ı�
pause>nul
del /f /q %temp%\mark_mow.txt>nul 2>nul
del /f /q %temp%\differ.txt>nul 2>nul
goto Key_Position_Photograph_Interface



:Key_Position_Photograph_Update
Mode con cols=70 lines=10
cls
echo;
echo;
echo                        ���ڸ��±�׼��¼�����Ժ�...
echo %date% >"Components\system32_Photograph.txt"
dir /b /s %windir%\System32 >>"Components\system32_Photograph.txt"
cls
echo;
echo;
echo                             ��׼��¼�Ѹ���
echo;
echo                               ������һ��
ping /n 3 127.1>nul
goto Key_Position_Photograph_Interface



:Key_Position_Photograph_Standard
Mode con cols=70 lines=10
cls
if not exist "Components\system32_Photograph.txt" (
    echo;
    echo;
    echo                         δ���ֱ�׼��¼������¡�
    pause>nul
    goto Key_Position_Photograph_Interface
)
start "��׼��¼" "Components\system32_Photograph.txt"
goto Key_Position_Photograph_Interface




for /f "delims=" %%i in ('dir /a /b %windir%\system32\drivers') do (














:Camouflage_Folder_Repair
Mode con cols=70 lines=15
Title �ļ���αװ�����޸�
cls
echo;
echo           ���޸��������� autorun.inf �����ಡ��
echo;
echo    ���ж�����Ϊ��
echo;
echo         1. �ļ��б���������
echo;
echo         2. ����: ͬ��.exe ; ͬ��.lnk ; ͬ�� .exe ; ͬ�� .lnk ��
echo;
echo;
echo                           �������ʼȫ��ɨ��
pause>nul
cls
echo;
echo;
echo;
echo;
echo                                ��������
echo;
echo                           �ռ������ļ�����Ϣ
echo;
echo                              ...���Ժ�...
set mark=��
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
        set mark=��
        set /a NO.+=1
        if exist "%%m.lnk" (
            set mark=��
            set /a NO._Abnormal+=1
            del /f /q "%%m.lnk" 
        )
        if exist "%%m.exe" (
            set mark=��
            set /a NO._Abnormal+=1
            del /f /q "%%m.exe"
        )
        if exist "%%m .lnk" (
            set mark=��
            set /a NO._Abnormal+=1
            del /f /q "%%m .lnk"
        )
        if exist "%%m .exe" (
            set mark=��
            set /a NO._Abnormal+=1
            del /f /q "%%m .exe"
        )
        if !mark!==�� attrib "%%m" -h
        cls
        echo;
        echo       ״̬                  ����ļ�
        echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
        echo       !mark!          "%%m"   
        echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
        echo;
        echo     ɨ�������ļ��� ��!NO.!          ���ֲ��� : !NO._Abnormal!
    )
)
cls
echo;
echo                                 ͳ  ��
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo         ɨ�������ļ��� ��!NO.!           ������ : !NO._Abnormal!     
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;&&echo;
echo                            ������������˵�
pause>nul
goto Main





:Safemode_Repair
Title �޸�ϵͳ��ȫģʽ
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
echo                          ϵͳ��ȫģʽ�޸����
echo;
echo;
echo                               �������˵�
ping /n 3 127.1>nul
goto Main





:Hosts_Repair
cls
Mode con cols=50 lines=10
Title Hosts�ļ��޸�
cls
echo;
echo       ����Hosts�ļ����޸��������µ���վ�޷�����
echo;
echo       ������������ι�棬��������������
echo;
echo          ����ͬĿ¼��Hosts_bak�ļ��лָ�
echo;
echo            Q �� �������˵�������������
set choose=~
set /p choose=��ѡ��
if /I %choose%==q goto main
copy %Systemroot%\System32\Drivers\Etc\hosts Backup\!log_date!_hosts /y >nul 2>nul
attrib -r -a -s %Systemroot%\System32\Drivers\Etc\hosts >nul
echo;>%Systemroot%\System32\Drivers\Etc\hosts
cls
echo;
echo                 �޸���ɣ�������
ping /n 5 127.1>nul
goto main





:DriveU_Repair
cls
Mode con cols=70 lines=25
Title U���޸�
set Drive_U=δ֪
for /f %%a in ('wmic logicaldisk where "drivetype='2'" get DeviceID ^|findstr :') do set Drive_U=%%a
echo;
echo;
echo   ˵���� ���� autorun.inf ������U�̲������µ�
echo             .exe��.lnkͬ���ļ����ļ��ж������ص����� 
echo;
echo;
echo;
echo �Զ������ƶ����̣� %Drive_U%
echo;
echo;
echo;
echo        A.�޸�%Drive_U%
echo;
echo        B.�޸�����������
echo;
echo        Q.�������˵�
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
echo  ��������Ҫ�޸����̷������磺  H: I: J:
echo;
set /p Drive_U=
if not exist %Drive_U% (
    echo;
    echo;
    echo                 û�м�⵽���ƶ����̣�������
    ping /n 3 127.1>nul
    goto DriveU_Repair_Defined
)



:DriveU_Repair_Do
attrib -h -s -r %Drive_U%\autorun.inf>nul 2>nul
if exist "%Drive_U%\autorun.inf" (
    echo �� ����autorun.inf�����ļ�
    echo;
    for /f "tokens=1,2,3 delims== " %%i in (%Drive_U%\autorun.inf) do (
        if "%%i" equ "Shellexecute" (
            echo �� ��������ָ�򲡶��壺
            echo;
            echo %%j
            if %%k neq "" echo %%k
            echo;
            if exist %%j del /f /s /q %%j
            if %%k neq "" (
                if exist %%j del /f /s /q %%k
            )
        echo;
        echo �� ������ɾ�����
        )
    )
) else (
    echo;
    echo �� δ���� autorun.inf ���������ļ�
)
for /f "delims=" %%i in ('dir /ad /b %Drive_U%') do (
    if exist "%Drive_U%\%%i.lnk" (
        echo;
        echo �� ���ֿ�ݷ�ʽ������*.lnk����
        echo;
        echo �� ɾ��......
        del / f /q /s "%Drive_U%\%%i.lnk" >nul 2>nul
    )
    if exist "%Drive_U%\%%i.exe" (
        echo;
        echo �� ����exe������*.exe����
        echo;
        echo �� ɾ��......
        del / f /q /s "%Drive_U%\%%i.exe" >nul 2>nul
    )
    for /f "delims= " %%h in ('attrib "%Drive_U%\%%i"') do (
        if %%h==H (
            echo;
            echo �� �ָ��ļ��У�%%i      ��������
            attrib -h -s -r "%Drive_U%\%%i"
        )
    )
)
echo;
echo �� �ļ������Իָ����
echo;
echo;
echo     �����޸��Ѿ���ɣ�����......
ping /n 5 127.1>nul
goto Main





:Winsock_Repair
Mode con cols=70 lines=25
Title Winsock�޸�
set /a NO._Winsock=NO._Winsock_Abnormal=0
del Components\Temp\winsock_*.txt 2>nul
echo;
echo                              �� �� ɨ ��
echo;
echo                          ......���Ժ�......
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo   Winsock��Ŀ                 ��������  
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
for /f "delims=" %%i in ('netsh winsock show catalog') do (
    if "%%i"=="Winsock Ŀ¼�ṩ������" (
        for /f "usebackq tokens=2 delims=: " %%n in (`"findstr "�ṩ����·��" Components\Temp\winsock_!NO._Winsock!.txt 2>nul"`) do (
            call set Winsock_Path=%%n
            if not "!Winsock_Path!"=="%SystemRoot%\system32\mswsock.dll" (
                if not "!Winsock_Path!"=="%SystemRoot%\system32\rsvpsp.dll" (
                    if not "!Winsock_Path!"=="%SystemRoot%\system32\msafd.dll" (
                        if not "!Winsock_Path!"=="%SystemRoot%\system32\ws2_64.dll" (
                            for /f "usebackq tokens=2,* delims=: " %%l in (`"findstr "����" Components\Temp\winsock_!NO._Winsock!.txt 2>nul"`) do (
                                set Winsock_Description=%%l %%m
                                echo   !NO._Winsock! �쳣            !Winsock_Description!
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
    echo              �Ƿ��޸�Winsock?
    echo;
    echo                Y ��ʼ  ����������
    echo;
    set choose=~
    set /p choose=��ѡ��
    if /I !choose!==Y goto Winsock_Repair_Do
    goto Winsock_Repair_Giveup
) else (
    echo;
    echo;
    echo ɨ��!NO._Winsock!�δ�����쳣����
    pause>nul
)
del Components\Temp\winsock_*.txt >nul 2>nul
ping /n 5 127.1>nul
goto Main



:Winsock_Repair_Do
Mode con cols=50 lines=10
cls
echo           �޸���Ҫһ��ʱ�䣬�����ĵȴ� 
echo;
echo       �����Ը�Щ������飬�޸�������������
echo;
echo                   �����޸�...
reg export HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Winsock Backup\!log_date!_Winsock.reg >nul 2>nul
reg export HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Winsock2 Backup\!log_date!_Winsock2.reg >nul 2>nul
netsh winsock reset catalog
cls
echo;
echo;
echo               �޸���ɣ���������Ч
del Components\Temp\winsock_*.txt >nul 2>nul
pause>nul
goto Main



:Winsock_Repair_Giveup
Mode con cols=50 lines=10
cls
echo;
echo;
echo                    �����޸�
echo;
echo   ɨ��!NO._Winsock!��쳣!NO._Winsock_Abnormal!��
del Components\Temp\winsock_*.txt >nul 2>nul
ping /n 3 127.1>nul
goto Main





:Network_Setup_Repair
Title �����������޸�
Mode con cols=70 lines=20
set /a Interface_NO.=0
cls
echo;
echo;
echo         A. ��ʾ��ǰIP����         B. ����������FAQ
echo;
echo         C. �ֶ�����IP/DNS         D. ����IP/DNS�Զ���ȡ
echo;
echo;
echo                       Q   �������˵�
set choose=~
set /p choose=��ѡ��
if /I %choose%==a goto Display_Current_Configuration
if /I %choose%==b goto Network_Eerror_Code_FAQ
if /I %choose%==c goto Network_Setup
if /I %choose%==d goto Network_Setup_Dhcp
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto Network_Setup_Repair
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto Network_Setup_Repair



:Display_Current_Configuration
goto Display_Current_Configuration_%version_mark%

:Display_Current_Configuration_xp
cls
echo;
echo;
echo                 ���ڻ�ȡ��Ϣ�����Ժ�...
for /f "skip=5 tokens=1,2,3,4,*" %%i in ('netsh interface ip show ipaddress') do (
        set /a Interface_NO.+=1
        set Interface_!Interface_NO.!_Name=%%m
        set Interface_!Interface_NO.!_IP=%%i
)
cls
for /l %%i in (1,1,%Interface_NO.%) do (
    echo �ӿ� ��!Interface_%%i_Name!
    echo IP��ַ��!Interface_%%i_IP!
    echo;
)
pause >nul
goto Network_Setup_Repair



:Display_Current_Configuration_win7
cls
echo;
echo;
echo                 ���ڻ�ȡ��Ϣ�����Ժ�...
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
    echo �ӿ� !Interface_%%i!��!Interface_%%i_Name!
    echo IP��ַ��!Interface_%%i_IP!
    echo;
)
pause >nul
goto Network_Setup_Repair



:Network_Setup
cls
echo;
set Interface_Name=��������
echo;
echo ��������Ҫ�޸ĵĽӿڣ�����������
echo ֱ�ӻس�Ϊ�޸�Ĭ�ϡ��������ӡ�
set /p Interface_Name=
if not %Interface_NO.%==0 (
    for /l %%i in (1,1,%Interface_NO.%) do (
        if !Interface_%%i_Name!==!Interface_Name! set Interface_Name_Setup=OK
    )
    if not "%Interface_Name_Setup%"=="OK" (
        echo �ӿڣ�����������δ����
        echo;
        echo ����������
        ping /n 2 127.1>nul
        goto Network_Setup
    )
)
cls
echo;
echo ������ IP ��ַ
echo;
set /p Interface_IP=
cls
echo;
set Interface_Mask=255.255.255.0
echo ������ �������� ��ַ
echo ֱ�ӻس�ΪĬ�ϡ�255.255.255.0��
echo;
set /p Interface_Mask=
cls
echo;
echo ������ ���� ��ַ
echo;
set /p Interface_Gateway=
for /f "delims=. tokens=1,2,3" %%i in ("%Interface_IP%") do set Interface_Check_IP=%%i%%j%%k
for /f "delims=. tokens=1,2,3" %%i in ("%Interface_Gateway%") do set Interface_Check_Gateway=%%i%%j%%k
if not %Interface_Check_IP%==%Interface_Check_Gateway% (
    cls
    echo;
    echo           �����õ� IP��ַ �� ���ص�ַ ����ͬһ����
    echo;
    echo                   ��������ʵ����������
    echo;
    echo;
    echo             Y ��ǿ�ƺ���      ������ ��������
    set choose=~
    set /p choose=��ѡ��
    if /I !choose!==Y goto Network_Setup_DNS
    goto Network_Setup
)



:Network_Setup_DNS
cls
echo;
echo ������ DNS����ѡ�� ��ַ
echo;
set /p Interface_DNS_1=
cls
echo;
echo ������ DNS�����ã� ��ַ
echo ֱ�ӻس�Ϊ��
echo;
set /p Interface_DNS_2=
cls
echo;
echo �������ã�
echo ====================================================================
echo �ӿ����ƣ�
echo      IP    ��ַ��%Interface_IP%
echo   �������� ��ַ��%Interface_Mask%
echo     ����   ��ַ��%Interface_Gateway%
echo DNS����ѡ����ַ��%Interface_DNS_1%
if not "%Interface_DNS_2%"=="" echo DNS�����ã���ַ��%Interface_DNS_2%
echo ====================================================================
echo;
echo;
echo ���������Ƿ���ȷ��   A.�����޸����ú�IP    B.�����޸�DNS����
echo;
echo                     �س���ִ����������
set choose=~
set /p choose=��ѡ��
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
echo                        �������
ping /n 2 127.1>nul
goto Network_Setup_Repair



:Network_Setup_Dhcp
cls
echo;
set Interface_Name=��������
echo;
echo ��������Ҫ�޸ĵĽӿڣ�����������
echo ֱ�ӻس�Ϊ�޸�Ĭ�ϡ��������ӡ�
set /p Interface_Name=
if not %Interface_NO.%==0 (
    for /l %%i in (1,1,%Interface_NO.%) do (
        if !Interface_%%i_Name!==!Interface_Name! set Interface_Name_Setup=OK
    )
    if not "%Interface_Name_Setup%"=="OK" (
        echo �ӿڣ�����������δ����
        echo;
        echo ����������
        ping /n 2 127.1>nul
        goto Network_Setup
    )
)
echo;
echo;
echo                 ����������Ϣ�����Ժ�...
netsh interface ip set address "!Interface_Name!" dhcp >nul
netsh interface ip set dns "!Interface_Name!" dhcp >nul
cls
echo;
echo;
echo                 ������ɣ���ǰΪ�Զ���ȡ
ping /n 2 127.1>nul
goto Network_Setup_Repair



:Network_Eerror_Code_FAQ
Mode con cols=70 lines=20
Title ����������FAQ
cls
set /a Interface_NO.=0
set /a NEW_Interface_NO.=0
echo;
echo;
echo                �ṩ��������������Ĳ�ѯ�ͽ������
echo;
echo                       ������������밴��ʾ����
echo;
echo         ������ʾ�������κ�����¶������µ�ͷ��õ���ϸ�Ľ��
echo;
echo;
echo                 T �����ͷ��绰     Q �������˵�   
echo;
set choose=~
set /p choose=�����������룺
if /I %choose%==t goto Network_Error_Tel
if /I %choose%==q goto main
cls
echo;
(call :Network_Error_%choose% || call :Network_Error_None )2>nul
goto Network_Setup_Repair


:Network_Error_None
echo ��Ǹ������ѯ�Ĵ��� %choose% ��ʱ�޷��ṩ����ϸ�������
echo;
echo �������µ�ͷ����
echo;
echo ������ǿͷ��绰�������µ�114��ѯ
pause >nul
goto :eof


:Network_Error_Tel
echo �й���ͨ��10010
echo;
echo �й����ţ�10000
echo;
echo �й��ƶ���10086
echo;
echo �й���ͨ��10050
echo;
echo;
echo ��������ǿͷ��绰�������µ�114��ѯ
pause >nul
goto :eof


:Network_Error_400  
echo ����400
echo;
echo ���⣺�����﷨��ʽ���󣬷������޷���������
pause >nul
goto :eof


:Network_Error_401
echo ����401 UNAUTHORIZED
echo;
echo ���⣺��ʾ�������һ����ȷ���û�����������ܵõ�����ҳ
pause >nul
goto :eof


:Network_Error_403
echo 403 FORBIDDEN
echo;
echo ���⣺��ʾ����ҳ��URL�ܵ���������ֹ����
pause >nul
goto :eof


:Network_Error_404
echo ����404 NOT FOUND
echo;
echo ���⣺��ʾ�������ʵ���ҳ�����ڻ���URL��ַ����
pause >nul
goto :eof


:Network_Error_409
echo ����409 Fire flood and Pestilence
echo;
echo ���⣺�������û���κ����壬��ֻ���������Ӽ���
pause >nul
goto :eof


:Network_Error_500
echo ����500 SERVERERROR
echo;
echo ���⣺��ʾ����������ͨ���ǶԷ���ҳ������ƴ����������
pause >nul
goto :eof


:Network_Error_503
echo ����503 SERVICE UNAVAILABLE
echo;
echo ���⣺��ʾ�������϶Է���վ����Ϊ������·�ǳ���æ����һ�����Լ���
pause >nul
goto :eof


:Network_Error_602
echo ����602 The port is already open
echo;
echo ���⣺�����������������豸��װ���������ʹ�ã����ܽ�������
echo;
echo ԭ��RasPPPoEû����ȫ����ȷ�İ�װ
echo;
echo �����ж�ظɾ��κ�PPPoE��������°�װ
pause >nul
goto :eof


:Network_Error_605
echo ����605 Cannot set port information
echo;
echo ���⣺�����������������豸��װ�������趨ʹ�ö˿�
echo;
echo ԭ��RasPPPoEû����ȫ����ȷ�İ�װ
echo;
echo �����ж�ظɾ��κ�PPPoE��������°�װ
pause >nul
goto :eof


:Network_Error_606
echo ����606 The port is not connected
echo;
echo ���⣺�����������粻������������豸�˿�
echo;
echo ԭ��RasPPPoEû����ȫ����ȷ�İ�װ�������߹��ϣ�ADSL MODEM����
echo;
echo �����ж�ظɾ��κ�PPPoE��������°�װ��������ߺ� ADSL MODEM
pause >nul
goto :eof


:Network_Error_608
echo ����608 The device does not exist
echo;
echo ���⣺���������������ӵ��豸������
echo;
echo ԭ��RasPPPoEû����ȫ����ȷ�İ�װ
echo;
echo �����ж�ظɾ��κ�PPPoE��������°�װ
pause >nul
goto :eof


:Network_Error_609
echo ����609 The device type does not exist
echo;
echo ���⣺���������������ӵ��豸�����಻��ȷ��
echo;
echo ԭ��RasPPPoEû����ȫ����ȷ�İ�װ
echo;
echo �����ж�ظɾ��κ�PPPoE��������°�װ
pause >nul
goto :eof


:Network_Error_611
echo ����611 The route is not available/612 The route is not allocated
echo;
echo ���⣺����������������·�ɲ���ȷ
echo;
echo ԭ��RasPPPoEû����ȫ����ȷ�İ�װ��ISP����������
echo;
echo �����ж�ظɾ��κ�PPPoE��������°�װ���µ�ISPѯ��
pause >nul
goto :eof


:Network_Error_617
echo ����617 The port or device is already disconnecting
echo;
echo ���⣺���������������ӵ��豸�Ѿ��Ͽ�
echo;
echo ԭ��RasPPPoEû����ȫ����ȷ�İ�װ��ISP���������ϣ������ߣ�ADSL MODEM����
echo;
echo �����ж�ظɾ��κ�PPPoE��������°�װ���µ�ISPѯ�ʣ�������ߺ� ADSL MODEM
pause >nul
goto :eof


:Network_Error_619
echo ����619
echo;
echo ���⣺�޷����ӵ�ָ���ķ����������ڴ����ӵĶ˿��ѹر�
echo;
echo ԭ�������ϴε����ӳ������ز����ʱ����̣���ɷ�������������Ӧ
echo;
echo ��������һ�������Ӻ�����
pause >nul
goto :eof


:Network_Error_621
echo ����621 Cannot open the phone book file
echo;
echo ԭ�򣺲��ܴ򿪵绰��
echo;
echo ���⣺Windows NT����Windows 2000 Server����RAS�����������
echo;
echo �����ж������PPPoE��������°�װRAS���������RasPPPoE
pause >nul
goto :eof


:Network_Error_622
echo ����622 Cannot load the phone book file
echo;
echo ԭ�򣺲���װ��绰��
echo;
echo ���⣺Windows NT����Windows 2000 Server����RAS�����������
echo;
echo �����ж������PPPoE��������°�װRAS���������RasPPPoE
pause >nul
goto :eof


:Network_Error_623
echo ����623 Cannot find the phone book entry
echo;
echo ԭ�򣺲����ҵ��绰�����
echo;
echo ���⣺Windows NT����Windows 2000 Server����RAS�����������
echo;
echo �����ж������PPPoE��������°�װRAS���������RasPPPoE
pause >nul
goto :eof


:Network_Error_624
echo ����624 Cannot write the phone book file
echo;
echo ԭ�򣺲���д��绰��
echo;
echo ���⣺Windows NT����Windows 2000 Server����RAS�����������
echo;
echo �����ж������PPPoE��������°�װRAS���������RasPPPoE
pause >nul
goto :eof


:Network_Error_625
echo ����625 Invalid information found in the phone book
echo;
echo ԭ���ڵ绰���д��ڲ���������
echo;
echo ���⣺Windows NT����Windows 2000 Server����RAS�����������
echo;
echo �����ж������PPPoE��������°�װRAS���������RasPPPoE
pause >nul
goto :eof


:Network_Error_629
echo ����629
echo;
echo ԭ���Ѿ���Է�������Ͽ����ӡ� ��˫�������ӣ�����һ��
echo;
echo ���⣺�����������Ϊͬʱ���������������ɵġ�Ҳ�п��������������õ�MODEM��绰�ߵ����ܺ���������
echo;
echo �������������������Ӧ��ȫ����ȡĬ�����ã��硰�������ѹ����������½���硱����Ҫѡ��
pause >nul
goto :eof


:Network_Error_630
echo ����630
echo;
echo ���⣺ADSL MODEMû��û����Ӧ
echo;
echo ԭ��ADSL�绰�߹��ϣ�ADSL MODEM���ϣ���Դû�򿪵ȣ�
echo;
echo ��������ADSL�豸
pause >nul
goto :eof


:Network_Error_633
echo ����633
echo;
echo ���⣺�����������������豸��װ���������ʹ�ã����ܽ�������
echo;
echo ԭ��RasPPPoEû����ȫ����ȷ�İ�װ
echo;
echo �����ж�ظɾ��κ�PPPoE��������°�װ
pause >nul
goto :eof

:Network_Error_638
echo ����638
echo;
echo ���⣺���˺ܳ�ʱ�䣬�޷����ӵ�ISP��ADSL���������
echo;
echo ԭ��ISP���������ϣ���RasPPPoE������������������������������һ���绰����
echo;
echo �����ȷ��ISP����������ʹ�õĲ��������е� �绰�����������ֻ����һ��0
pause >nul
goto :eof


:Network_Error_645
echo ����645
echo;
echo ���⣺����û����ȷ��Ӧ
echo;
echo ԭ���������ϣ��������������������
echo;
echo �����������������°�װ������������
pause >nul
goto :eof


:Network_Error_650
echo ����650
echo;
echo ���⣺Զ�̼����û����Ӧ���Ͽ�����
echo;
echo ԭ��ADSL ISP���������ϣ��������ϣ��������ػ��������Э�����
echo;
echo ��������ADSL�źŵ��Ƿ�����ȷͬ�������������ɾ����������������°�װ����
pasue
goto :eof


:Network_Error_651
echo ����651
echo;
echo ���⣺ADSL MODEM���淢������
echo;
echo ԭ��Windows���ڰ�ȫģʽ�£�����������
echo;
echo ��������ָô���ʱ�������ز����Ϳ��Ա�����µľ���������
pause >nul
goto :eof


:Network_Error_691
echo ����691
echo;
echo ���⣺������û��������벻�ԣ��޷���������
echo;
echo ԭ���û������������ISP���������ϣ��˻����ڡ�����Ϊ0��
echo;
echo �����ʹ����ȷ���û��������룻��ͷ��绰�ų�����
pause >nul
goto :eof


:Network_Error_718
echo ����718
echo;
echo ���⣺��֤�û���ʱԶ�̼������ʱû����Ӧ���Ͽ�����
echo;
echo ԭ��ADSL ISP����������
echo;
echo ������µ�ͷ�
pause >nul
goto :eof


:Network_Error_720
echo ����720
echo;
echo ���⣺���������޷�Э�������з�������Э������
echo;
echo ԭ��ADSL ISP���������ϣ��������ػ��������Э�����
echo;
echo �����ɾ����������������°�װ����
pasue
goto :eof


:Network_Error_734
echo ����734
echo;
echo ���⣺PPP���ӿ���Э����ֹ
echo;
echo ԭ��ADSL ISP���������ϣ��������ػ��������Э�����
echo;
echo �����ɾ����������������°�װ����
pasue
goto :eof


:Network_Error_738
echo ����738
echo;
echo ���⣺���������ܷ���IP��ַ
echo;
echo ԭ��ADSL ISP���������ϣ�ADSL�û�̫�೬��ISP�����ṩ��IP��ַ
echo;
echo ������µ�ͷ�
pause >nul
goto :eof


:Network_Error_797
echo ����797
echo;
echo ���⣺ADSL MODEM�����豸û���ҵ�
echo;
echo ԭ��ADSL MODEM��Դû�д򿪣�������ADSL MODEM�������߳�������
echo;
echo ���������Դ�������ߣ������������
pause >nul
goto :eof





:System_Sensitive_Protection
Mode con cols=70 lines=15
set /a NO.=NO._Abnormal=NO._Succeed=NO._Fail=0
for %%x in (
    "guest :            Guest�����˻�         "
    "helpassistant :         Helpassistant�����˻�    "
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
            set Account_Activation=�쳣����
            net user !Account! /active:no >nul 2>nul
            if !errorlevel!==0 (
                set Sensitive_Account_Repair= ��
                set /a NO._Succeed+=1
            ) else (
                set Sensitive_Account_Repair= ��
                set /a NO._Fail+=1
            )
            
        ) else (
            set Account_Activation=��������
            set Sensitive_Account_Repair=����Ҫ
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
                set Hidden_Share=�쳣����
                net share %%n$ /delete
                if !errorlevel!==0 (
                    set Hidden_Share_Repair= ��
                    set /a NO._Succeed+=1
                ) else (
                    set Hidden_Share_Repair= ��
                    set /a NO._Fail+=1
                )
            ) else (
                set Hidden_Share=��������
                set Hidden_Share_Repair=����Ҫ
            )    
            call :System_Sensitive_Protection_Monitor "             ���ع��� %%n$         " !Hidden_Share! !Hidden_Share_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
        )
    )
)

net share|findstr /i ADMIN >nul 2>nul
set /a NO.+=1
if %errorlevel%==0 (
    set /a NO._Abnormal+=1
    set ADMIN_Share=�쳣����
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Lanmanserver\parameters /v AutoShareWks /t REG_DWORD /d 0 /f
    if !errorlevel!==0 (
        set ADMIN_Share_Repair=��
        set /a NO._Succeed+=1
    ) else (
        set ADMIN_Share_Repair=��
        set /a NO._Fail+=1
    )
) else (
    set ADMIN_Share=��������
    set ADMIN_Share_Repair=����Ҫ
)
call :System_Sensitive_Protection_Monitor "          ADMIN$���ع���         " !ADMIN_Share! !ADMIN_Share_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!


net share|findstr IPC >nul 2>nul
set /a NO.+=1
if %errorlevel%==0 (
    set /a NO._Abnormal+=1
    set IPC_Share=�쳣����
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymous /t REG_DWORD /d 1 /f
    if !errorlevel!==0 (
        set IPC_Share_Repair=��
        set /a NO._Succeed+=1
    ) else (
        set IPC_Share_Repair=��
        set /a NO._Fail+=1
    )
) else (
    set IPC_Share=��������
    set IPC_Share_Repair=����Ҫ
)
call :System_Sensitive_Protection_Monitor "            IPC%$���ع���         " !IPC_Share! !IPC_Share_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!

for %%x in (
    "TermService : Զ�����ӷ���     "
    "RemoteRegistry : Զ��ע������   "
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
                set Dangerous_Service_Status=�쳣����
                sc config !Dangerous_Service! start= DISABLED
                if !errorlevel!==0 (
                    set Dangerous_Service_Repair=��
                    set /a NO._Succeed+=1
                ) else (
                    set Dangerous_Service_Repair=��
                    set /a NO._Fail+=1
                )
            ) else (
                set Dangerous_Service_Status=��������
                set Dangerous_Service_Repair=����Ҫ
            )
        )
    call :System_Sensitive_Protection_Monitor "        Σ�շ���!Dangerous_Service_Caption!" !Dangerous_Service_Status! !Dangerous_Service_Repair! !NO.! !NO._Abnormal! !NO._Succeed! !NO._Fail!
    )
)

cls
echo;
echo;
echo;
echo;
echo        ɨ�裺!NO.!         �쳣��!NO._Abnormal!         �޸���!NO._Succeed!     ʧ�� !NO._Fail!
ping /n 5 127.1>nul
goto Main



:System_Sensitive_Protection_Monitor
cls
echo;
echo            ��  ��  ��  Ŀ                       ״̬          �޸�
echo =====================================================================
echo %~1             %2       %3
echo =====================================================================
echo;
echo        ɨ�裺%4          �쳣��%5          �޸���%6     ʧ�ܣ�%7
goto :eof





:Group_Policy_Protection
Mode con cols=70 lines=20
Title ����Է�������
cls
echo;
echo;
echo                  ����Է������в�ռ��Դ����Ч�������ص�
echo;
echo                     ���ڼ�ǿϵͳ��ȫ���в������������
echo;
echo                        Q �������˵�  ����������
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==q goto main
cls
if exist %WinDir%\system32\GroupPolicy\Machine\Registry.pol (
    echo;
    echo;
    echo           ϵͳ�Ѵ�������Է����б��Ƿ񸲸ǣ�Y/N����
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
echo                          �����������·����б�
echo;
echo                           ......���Ժ�......
echo;
del /q /f %WinDir%\system32\GroupPolicy\Machine\Registry.pol >nul 2>nul
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Web_Download.vbs "http://!Server_Domain!/Registry.pol" %WinDir%\system32\GroupPolicy\Machine\Registry.pol
if exist "%WinDir%\system32\GroupPolicy\Machine\Registry.pol" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /v Levels /t REG_DWORD /d "0x04131000" /f >nul
    gpupdate /force
    echo;
    echo;
    echo                             ϵͳ�����ɹ�
    ping /n 4 127.1>nul
    goto Main
) else (
    echo;
    echo;
    echo;
    echo                    ��������ʧ�ܣ��޷��������������б�
    echo;
    echo;
    echo                               ���Ժ�����...
    ping /n 3 127.1>nul
    goto Main
)




:ActiveX_Immune
Mode con cols=70 lines=20
Title ActiveX���߹���
cls
set /a ActiveX_Immune_NO.=ActiveX_Immune_Succeed=ActiveX_Immune_Fail=0
echo;
echo;
echo;
echo             ���߸��ֶ���ActiveX�������֤�������������ٶ�
echo;
echo;
echo                        Q �������˵�  ����������
echo;
set choose=~
set /p choose=��ѡ��
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
    echo                    ��������ʧ�ܣ��޷��������������б�
    echo;
    echo;
    echo                               ���Ժ�����...
    ping /n 3 127.1>nul
    goto Main
)
cls
echo;
echo                                  ͳ  ��
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo   �����ߣ�%ActiveX_Immune_NO.%    ʧ�ܣ�%ActiveX_Immune_Fail%��
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo;
echo                            ������������˵�
pause>nul
goto Main



:ActiveX_Immune_Monitor
cls
echo;
echo                         ��  ��  ��  Ŀ                
echo =====================================================================
echo                     %~1 
echo =====================================================================
echo;
echo        ɨ�裺%2            �ɹ���%3     ʧ�ܣ�%4
goto :eof





:Virus_Immune
Mode con cols=70 lines=20
Title �������߹���
cls
set /a NO.=0
set /a NEW_NO.=0
echo;
echo;
echo                                  ͨ��
echo;
echo                      �����ļ���  ��  ���ʿ����б�
echo;
echo                           �ﵽ���߲���������
echo;
echo;
echo                        Q �������˵�  ����������
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==q goto main
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/Virus_Immune.txt" >%temp%/Virus_Immune.txt 2>nul
cls
echo;
echo;
echo;
echo                               �� �� �� ��
echo;
echo                           ......���Ժ�......
if exist "%temp%/Virus_Immune.txt" (
    for /f %%i in (%temp%/Virus_Immune.txt) do (
        if not exist "%%i\��������" (
            if exist "%%i" del /f /s/q "%%i"
            md "%%i\��������"
            md "%%i\��������\��Ӱ��������..\"
            attrib "%%i" +S +R +H
            cacls "%%i\��������" /d everyone /e>nul 2>nul
            set /a NEW_NO.+=1
        )
        set /a NO.+=1
    )
) else (
    echo;
    echo;
    echo;
    echo                    ��������ʧ�ܣ��޷��������������б�
    echo;
    echo;
    echo                               ���Ժ�����...
    ping /n 3 127.1>nul
    goto Main
)
echo;
echo                                  ͳ  ��
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo          �����ߣ�%NO.% ������          �����������ߣ�%NEW_NO.% ������
echo;
echo = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
echo;
echo;
echo                            ������������˵�
pause>nul
goto Main





:Login_Message_Send
Title ϵͳ��¼֪ͨ
cls
set mark_exist=δ����
for /f "usebackq tokens=2 delims=:" %%i in (`"reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" 2>nul"^|findstr /i Login_message_send`) do (
    if exist "%windir%\System32\send.bat" (
        if /i "%%i"=="\windows\system32\Login_message_send.vbs" set mark_exist=����
    )
)
echo;
echo             ��ϵͳ��¼ʱ���Զ���IP�����ڵط��͵�ָ��������
echo;
echo      �Ƽ�ʹ����������Ŷ���֪ͨ���ܣ������ʹ��ֻ�����ʱ�����쳣
echo;
echo             �����ȫ�����ʾ����������䶯����ѡ��ͨ��
echo;&&echo;
echo                   ��ǰ״̬�� %mark_exist%
echo;
if "%mark_exist%"=="δ����" (
    echo;
    echo                    A.  ���õ�¼֪ͨ   
    echo;
)
if "%mark_exist%"=="����" (
    echo;
    echo         A. �������õ�¼֪ͨ       B. �鿴����
    echo;
    echo         C. ȡ����¼֪ͨ           D. ��������
    echo;
)
echo                    Q.  �������˵�
echo;
set choose=~
set /p choose=��ѡ��
if "%mark_exist%"=="δ����" (
    if /I %choose%==a goto Login_Message_send_Do
)
if "%mark_exist%"=="����" (
    if /I %choose%==a goto Login_Message_send_Do
    if /I %choose%==b goto Login_Message_send_Check
    if /I %choose%==c goto Login_Message_Send_Cancle
    if /I %choose%==d goto Login_Message_Send_Test
)
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto Login_message_send
    exit
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto Login_message_send



:Login_Message_Send_Do
Mode con cols=50 lines=10


:Login_Message_Send_Do_Name
cls
echo;
set /p m=��������յ�����:
if "%m%"=="" goto Login_Message_Send_Do_Name
if not "%m:~-4,4%"==".com" (
    echo;
    echo �����ʽ�������������롣
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
echo  �����¼���û���: %n%
echo;
echo        �����������smtp.%s%
ping /n 5 127.1>nul


:Login_Message_Send_Do_Password
cls
echo;
set /p p=�����������¼������:
if "%p%"=="" (
    echo;
    echo ������Ч�����������롣
    ping /n 3 127.1>nul
    goto Login_Message_Send_Do_Password
)
echo ���յ�����: %m%>"%windir%\System32\send.txt"
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
echo for /f "tokens=3,6,7 delims=<> " %%%%1 in ('findstr /r "�ٷ����ݲ�ѯ���" "%temp%\ip.txt"') do ( >>"%windir%\System32\send.bat"
echo     set ip=%%%%1 >>"%windir%\System32\send.bat"
echo     set address=%%%%2 %%%%3 >>"%windir%\System32\send.bat"
echo )>>"%windir%\System32\send.bat"
echo echo On Error Resume Next^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo f="%m%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo smtp="smtp.%s%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo u="%n%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo p="%p%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo t="%m%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo m="ϵͳ��¼��¼:  ����IP:  %%ip%% ����λ�ã� %%address%%"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
echo echo msg="ϵͳ��¼��¼ BY bluewing009 ����ϵͳ"^>^>"%%windir%%\System32\\send.vbs">>"%windir%\System32\send.bat"
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
    echo                      ����ʧ��
    echo;
    echo                        ����
    ping /n 3 127.1>nul
    goto Login_Message_Send
)
if %errorlevel%==0 (
    echo;&&echo;
    echo                      ���óɹ�
    echo;
    echo                 �Ƿ��������״̬ ��
    echo;
    echo               Y ��ʼ  �������������˵�
    echo;
    set choose=~
    set /p choose=��ѡ��
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
    echo                      ȡ��ʧ��
    echo;
    echo                        ����
    ping /n 3 127.1>nul
    goto Login_Message_Send
)
if %errorlevel%==0 (
    echo;
    echo;
    echo                      ȡ���ɹ�
    echo;
    echo                     �������˵�
    ping /n 3 127.1>nul
    goto Main
)


:Login_Message_Send_Test
Mode con cols=50 lines=10
echo;
echo                    ���ڷ����ʼ�
echo;
echo                    ...���Ժ�...
call "%windir%\System32\send.bat" 0
if %errorlevel%==0 (
    echo;
    echo                        �ɹ�
    echo;
    echo                    ���¼����鿴
    ping /n 3 127.1>nul
    goto Main
)
if %errorlevel%==1 (
    echo;
    echo                        ʧ��
    echo;
    echo                �����������Ӻ�����
    ping /n 3 127.1>nul
    goto Main
)





:Force_Delete
Mode con cols=50 lines=10
cls
echo;
echo        �뽫��Ҫɾ�����ļ����ļ����Ϸ�������
echo;
echo          �����϶�ʱ�������������ļ�·��
echo;
set Delete_Path=~
set Delete_Path_Type=~
set /p Delete_Path=
set "Delete_Path=%Delete_Path:"=%"
cd %Delete_Path% >nul 2>nul
if %errorlevel%==0 set Delete_Path_Type=�ļ���
if %errorlevel%==1 set Delete_Path_Type=�ļ�
cd /d %~dp0
if "%Delete_Path%"=="~" goto Force_Delete
if /i %Delete_Path%==q goto Main
if not exist "%Delete_Path%" (
    cls
    echo;
    echo;
    echo;
    echo                     ·������
    ping /n 2 127.1>nul
    goto Force_Delete
)
if "%Delete_Path_Type%"=="~" (
    cls
    echo;
    echo;
    echo;
    echo                     ·������ 
    ping /n 2 127.1>nul
    goto Force_Delete
)
cls
echo;
echo                 ����ɾ�������ļ�
echo;
echo "%Delete_Path%"        
echo;
echo;
echo                Y ��ʼ  ����������
echo;
set choose=~
set /p choose=��ѡ��
if /I "%choose%"=="Y" goto Force_Delete_Do
goto Force_Delete_Jump



:Force_Delete_Jump
cls
echo;
echo;
echo;
echo                       ��  �� 
ping /n 2 127.1>nul
goto Main



:Force_Delete_Do
if "%Delete_Path_Type%"=="�ļ�" (
    del /f /s /q "%Delete_Path%" >nul 2>nul
)
if "%Delete_Path_Type%"=="�ļ���" (
    rd /s /q "%Delete_Path%" >nul 2>nul
)
if exist "%Delete_Path%" (
    cls
    echo;
    echo                     ɾ��ʧ��
    echo;
    echo              ��������ɾ�����ļ�
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
    echo                     ɾ���ɹ�   
)   
ping /n 2 127.1>nul   
goto Main





:MBR_Backup_Recovery
Mode con cols=70 lines=20
Title Ӳ����������¼����/�ָ�
cls
set mark_exist=δ����
if exist %SystemRoot%\System32\MBR����.bin set mark_exist=�ѱ���
echo;
echo                        ����/�ָ�Ӳ����������¼
echo;
echo             ����Ӧ���ָ��쳣�򲡶���ɵ���������¼�쳣
echo;
echo                      �����ʾ�޸ģ���ѡ�񡰺��ԡ�
echo;
echo;
echo                        ��ǰ״̬�� %mark_exist%
echo;
if "%mark_exist%"=="δ����" (
    echo;
    echo                         A.  ����Ӳ��������¼  
    echo;
)
if "%mark_exist%"=="�ѱ���" (
    echo;
    echo                 A. ���±���       B. �ָ�Ӳ��������¼ 
    echo;
    echo;
)
echo                         Q.  �������˵�
echo;
set choose=~
set /p choose=��ѡ��
if "%mark_exist%"=="δ����" (
    if /I %choose%==a goto MBR_Backup
)
if "%mark_exist%"=="�ѱ���" (
    if /I %choose%==a goto MBR_Backup
    if /I %choose%==b goto MBR_Recovery
)
if /I %choose%==q goto Main
if /I %choose%==~ (
    echo;
    echo                         ��Ч��ѡ�����������
    ping /n 2 127.1>nul
    goto MBR_Backup_Recovery
    exit
)
echo;
echo                         ��Ч��ѡ�����������
ping /n 2 127.1>nul
goto MBR_Backup_Recovery



:MBR_Backup
Mode con cols=50 lines=10
cls
echo;
echo;
echo;
echo        ...���ڱ���...
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
echo n %SystemRoot%\System32\MBR����.bin>>%temp%\mbr_backup.code
echo w >>%temp%\mbr_backup.code
echo q >>%temp%\mbr_backup.code
debug<%temp%\mbr_backup.code >nul 2>nul
graftabl 936>nul 2>nul
if exist %SystemRoot%\System32\MBR����.bin (
    cacls " %SystemRoot%\System32\MBR����.bin" /d everyone /e>nul 2>nul
    echo;
    echo;
    echo                     ���ݳɹ�
    echo;
    echo              �����ļ��ѱ���ȫ����
) else (
    echo;
    echo;
    echo                δ֪���󣬱���ʧ��
)
ping /n 2 127.1>nul
goto Main



:MBR_Recovery
Mode con cols=50 lines=10
cls
echo;
echo;
echo;
echo                  ...���ڻָ�...
echo y|cacls "%SystemRoot%\System32\MBR����.bin" /g everyone:f>nul
echo n %SystemRoot%\System32\MBR����.bin >%temp%\mbr_restoration.code
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
echo                     �ָ��ɹ�
ping /n 2 127.1>nul
goto Main





:System_Garbage_Clean
set /a File_Size_All=File_Size_=File_Size=0
Mode con cols=50 lines=10
Title ����ϵͳ����
for %%l in (
    "��ʷRecent�ļ���         : %APPDATA%\Microsoft\Windows\Recent"
    "�û���ʱ�ļ���           : %temp%"
    "Windows��ʱĿ¼          : %windir%\temp"
    "�����صĳ���             : %windir%\download program files"
    "windowsԤ��              : %windir%\prefetch"
    "windows���²���          : %windir%\softwaredistribution\download"
    "�ڴ�ת���ļ�             : %windir%\Minidump"
    "office ��װ����          : %SYSTEMDRIVE%\MSOCache" 
    "IE��ʱ�ļ���             : %userprofile%\Local Settings\Temporary Internet Files"
    "����ͼ����               : %HOMEPATH%\AppData\Local\Microsoft\Windows\Explorer"
    "windows���ⱨ��          : %HOMEPATH%\AppData\Local\Microsoft\Windows\WER"
) do (
    for /f "tokens=1,* delims=:" %%i in ("%%l") do (
        set Garbage_Name_Temp=%%i
        set Garbage_Name=!Garbage_Name_Temp:~1,-1!
        set Garbage_Path_Temp=%%j
        set Garbage_Path=!Garbage_Path_Temp:~1,-1!
        if exist "!Garbage_Path!" for /f "tokens=3" %%i in ('dir /a /s /-c "!Garbage_Path!" ^|findstr "���ļ�"') do set File_Size_=%%i
        set /a File_Size+=!File_Size_!
        cls  
        echo;
        echo;
        echo;
        echo ��������  !Garbage_Name!...
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
echo ������ɣ����ͷſռ� !File_Size_All! MB
ping /n 5 127.1>nul
goto Main





:Registry_Garbage_clean
Mode con cols=50 lines=10
Title ����ϵͳ����
set /a NO.=NO._=0
if %version_mark%==win7 set path_=Documents
if %version_mark%==xp set path_=My Documents
if not exist "%Userprofile%\!path_!\ע���������" md "%Userprofile%\!path_!\ע���������"
if exist "%Userprofile%\!path_!\ע���������\�������.reg" (
    copy /y "%Userprofile%\!path_!\ע���������\�������.reg" "%Userprofile%\!path_!\ע���������\�ϴα���.reg" >nul
    del /f/s/q "%Userprofile%\!path_!\ע���������\�������.reg" >nul
)
reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs" "%Userprofile%\!path_!\ע���������\�������.reg" >nul
for /F "usebackq skip=%version_skip% tokens=* delims=" %%i in (`" reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs"`) do call :Registry_Garbage_clean_Check "%%i"
ping /n 3 127.1>nul
cls
echo;
echo;
echo;
echo            �������
ping /n 2 127.1>nul
cls
echo;
echo;
echo     ������ɾ������ �ҵ��ĵ�\ע��������� ��
echo;
echo    �������.reg  �ָ�  ���ϴα��ݣ��ϴα���.reg��
ping /n 5 127.1>nul
goto Main



:Remove_Spaces
rem ȥ���ַ������ҿո����%1�����ڲ���%Remove_Spaces_Result%
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
echo           �Ѽ����Ŀ�� %NO.% 
echo;
echo       ��ɾ��������Ŀ�� %NO._%
goto :eof





:Default_Service
Mode con cols=50 lines=10
cls
Title �ָ�Ĭ�Ϸ���
cls
echo;
echo �ָ�ϵͳĬ�ϵķ���״̬���������ȴ����ϵͳ�����Ż�
echo;
echo              �Ƿ񱸷ݵ�ǰ����״̬��
echo;
echo                  Y    ֱ�ӻָ�
echo               ������  ���ݺ�ָ�
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==Y goto Recovery_Services
call :Service_Backup



:Recovery_Services
cls
echo;
echo;
echo        ���ڸ��£����Ժ�
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/Default_Service_!version_mark!.txt" >%temp%\Default_Service.txt 2>nul
set /a Service_NO._ALl=Service_NO._Failed=0
del /q /f %temp%\ERROR__.txt ERROR.txt >nul 2>nul
for /f "tokens=1,2 delims=:" %%i in (%temp%\Default_Service.txt) do (
	set /a Service_NO._ALl+=1
	cls
	echo;
	echo;
	echo        ���ڻָ������Ժ�
	echo;
	echo;
	echo   �� !Service_NO._ALl! ������%%i
	sc config %%i start= %%j >%temp%\ERROR_.txt
	if not !errorlevel!==0 (
		for /f "skip=1" %%m in (%temp%\ERROR_.txt) do (
			set /a Service_NO._Failed+=1
			echo ����%%i ���ô���%%m Error ID=!errorlevel! >>Error.txt
		)
	)
)
cls
echo;
echo        �ָ����
echo;
echo  ���� %Service_NO._ALl% �����ʧ�� %Service_NO._Failed%
if not %Service_NO._Failed%==0 (
	echo;
	echo                �Ƿ�鿴ʧ��ԭ��
	echo;
	echo                Y �鿴  ����������
	echo;
	set choose=~
	set /p choose=��ѡ��
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
		echo        ���ڱ��ݣ����Ժ�...
		echo;
		echo;
		echo   �� !Service_Bcakup_NO.! ������%%i
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
		echo        ��ɱ��� !Service_Bcakup_NO.! ������
		ping /n 2 127.1>nul
goto :eof





:Online_Scan
cls
Mode con cols=50 lines=10
cls
Title һ���ϴ���ɨ��
cls
echo;
echo ���ϵͳ�ļ��Ҽ��˵������Ժ����һ���ϴ������ļ�
echo;
echo              �Ƿ������Ҽ��˵���
echo;
echo       Y �����Ҽ�����    N ɾ���Ҽ�����
echo               ������  ��������
echo;
set choose=~
set /p choose=��ѡ��
if /I %choose%==Y goto Online_Scan_Add
if /I %choose%==N goto Online_Scan_Delete
goto main

:Online_Scan_Add
reg add HKEY_CLASSES_ROOT\*\shell\�ϴ�virscanɨ��\command /ve /t REG_SZ /d "Wscript.exe \"%~dp0\Components\Online_Scan.vbs\" bluewing009 \"%%1\" 0 1" /f >nul 2>nul
cls
echo;
echo;
echo;
echo        ������ɣ��������ļ����һ�
echo;
echo          ѡ���ϴ�virscanɨ�衱����
ping /n 2 127.1>nul
goto main
:Online_Scan_Delete
reg delete HKEY_CLASSES_ROOT\*\shell\�ϴ�virscanɨ�� /f >nul 2>nul
cls
echo;
echo;
echo;
echo              ��ɾ���Ҽ�����
ping /n 2 127.1>nul
goto main





:System_Information
Mode con cols=50 lines=10
Title ϵͳ��Ϣ
cls
echo;
echo;
echo                 ���ڼ��ϵͳ��Ϣ
echo;
echo;
systeminfo>>%temp%\System_Information.txt
start "" %temp%\System_Information.txt
goto Main





:Online_Updates
Mode con cols=50 lines=10
Title ���߸���
set version_New=δ֪
cls
echo;
echo;
echo;
echo                    ���ڼ�����
echo;
echo                    ...���Ժ�...
call :Connecet_Confirm
cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools_Version.txt" >%temp%\System_Auxiliar_Tools_Version.txt 2>nul
for /f %%i in (%temp%\System_Auxiliar_Tools_Version.txt) do set version_New=%%i
if "%version_New%"=="δ֪" goto Check_Updates_Error
for /f "tokens=1* delims=:" %%i in ('findstr /n .* %0') do if %%i==22 for /f "tokens=5" %%m in ('%%j') do set version_Now=%%m
if !Version!==Piracy set version_Now=0
if %version_Now%==%version_New% (
    echo;
    echo                �汾���£�����Ҫ����
    ping /n 3 127.1>nul
    goto Main
) else (
    cls
    echo;
    echo;
    echo;
    echo                    �������ظ���
    echo;
    echo                    ...���Ժ�...
    cscript //NoLogo /e:vbscript Components\Updates.vbs "http://!Server_Domain!/System_Auxiliar_Tools.txt">%temp%\ϵͳ��������.bat
    echo @echo off>%temp%\ϵͳ��������_����.bat
    echo Mode con cols=50 lines=10>>%temp%\ϵͳ��������_����.bat
    echo Color 3F>>%temp%\ϵͳ��������_����.bat
    echo Title ���߸���>>%temp%\ϵͳ��������_����.bat
    echo echo;>>%temp%\ϵͳ��������_����.bat
    echo echo;>>%temp%\ϵͳ��������_����.bat
    echo echo;>>%temp%\ϵͳ��������_����.bat
    echo echo;>>%temp%\ϵͳ��������_����.bat
    echo echo                   ...��������...>>%temp%\ϵͳ��������_����.bat
    echo ping /n 3 127.1^>nul>>%temp%\ϵͳ��������_����.bat
    echo copy /y "%temp%\ϵͳ��������.bat" "%~dp0\%~n0.bat"^>nul >>%temp%\ϵͳ��������_����.bat
    echo start "" "%~dp0\%~n0.bat">>%temp%\ϵͳ��������_����.bat
    echo Exit>>%temp%\ϵͳ��������_����.bat
    start %temp%\ϵͳ��������_����.bat
    exit
)

:Check_Updates_Error
Mode con cols=50 lines=10
Title ���߸���
cls
echo;
echo;
echo                 �޷����Ӹ��·�����
echo;
ping /n 3 127.1>nul
if !Version!==Piracy goto :Exit
goto Main





:Exit
Mode con cols=50 lines=10
Title ��лʹ��
cls
echo;
echo           ллʹ��      o���� _ �ɣ�o
echo;
echo;           ����кõĽ��飬����ϵ��
echo;
echo;
echo         E-Mail:  bluewing009@tom.com
echo             QQ:      961881006
echo;
ping /n 5 127.0.0.1>nul
if %Safe_Environment_Mark%==Y start explorer.exe >nul 2>nul
endlocal
Exit





rem ������ϵͳ��������

:Permission_Check
Mode con cols=50 lines=10
Title Ȩ��ȷ��
cls
echo;
echo;
echo;
echo                ���ڲ��������Ȩ��
echo;
echo                   ...���Ժ�...
echo;>%SystemRoot%\System32\Permission_Check.dat
if not exist %SystemRoot%\System32\Permission_Check.dat (
    cls
    echo;
    echo;
    echo                     Ȩ���쳣
    echo;
    echo                ���Թ���ԱȨ������
    echo;
    echo;
    echo                    ������˳�
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
set /p="λʹ����"<nul>>"%object%"
set /p=��                                           ���ǵ� <NUL
findstr /a:34 .* "%object%*"
del /q "%object%"
popd
goto :eof





:Color_Offline
pushd %temp%
set "object=����"
set /p="%~2 "<nul>"%object%"
set /p="ģʽ"<nul>>"%object%"
set /p=��                                              ������ʹ�� <NUL
findstr /a:34 .* "%object%*"
del /q "%object%"
popd
goto :eof



:colortheword
::colortheword [str1=��ɫ�ַ�] [str2=��ʾ�ַ�] [str3=��ɫ����]
pushd %temp%
set "object=%~1"
set /p="%~2"<nul>"%object%"
set /p="%~3"<nul>>"%object%"
findstr /a:%~4 .* "%object%*"
del /q "%object%"
popd
goto :eof





:Get_Path
rem �ӳ������ڷ����ַ�����·�� ��������ڲ���������ַ��������ڲ������ļ�·�� %File_Path%%File_Name%
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
rem ͬ���������
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
echo '��VBS�ű��ܰ�Ȩ������������ͬ��󷽿�ʹ�á����ơ��޸ģ�������ϵ��ʽ bluewing009 QQ:961881006 >>Components\Online_Scan.vbs
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
echo 		WScript.Echo "  �ļ���С�������ƣ�"^& vbCrLf ^& "�ļ��Ĳ��ܳ���20��" >>Components\Online_Scan.vbs
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
echo 	WScript.Echo "�ļ������ϴ������Ժ�..."^& vbCrLf ^& "��ɺ��Զ�����ɨ����" ^& vbCrLf ^& "��Լ��Ҫ1���ӣ��뵱ǰ�������й�" >>Components\Online_Scan.vbs
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
echo 	WScript.Echo "Bluewing009 ������ɨ�豨�棺"^& vbCrLf ^& "�ļ���"^& filePath ^& vbCrLf ^& reportUrl >>Components\Online_Scan.vbs
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
	Title ���߸���
	cls
	echo;
	echo;
	echo                 �����л����·�����
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