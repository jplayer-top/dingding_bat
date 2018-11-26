:: 编码格式 GB2312 
@echo off
echo 服务进行中...
:: 查看是否锁屏?
del screen.txt
choice /t 1 /d y /n >nul
adb shell "dumpsys window policy|grep mShowingLockscreen" >>screen.txt
choice /t 1 /d y /n >nul
set /p a=<screen.txt
echo %a%|findstr "mShowingLockscreen=true"
if %errorlevel% equ 0 (  
	:: 锁屏状态开屏(不可设置密码或指纹)
	adb shell input keyevent 26
	adb shell input keyevent 3
	adb shell input swipe 300 1800 300 800
)
::adb shell settings get secure enabled_accessibility_services获取无障碍列表
::adb 指定 到 无障碍服务 并关闭其他已开启的无障碍
adb shell settings put secure enabled_accessibility_services top.jplayer.quick_test1.debug/top.jplayer.baseprolibrary.alive.service.CustomAccessibilityService 
:: 1 开启服务
adb shell settings put secure accessibility_enabled 1

::回到手机主页
adb shell input keyevent 3
::开启服务
adb shell am startservice  top.jplayer.quick_test1.debug/top.jplayer.baseprolibrary.alive.service.WhiteService>nul
choice /t 2 /d y /n >nul
adb shell am start -n com.alibaba.android.rimet/com.alibaba.android.rimet.biz.SplashActivity>nul
choice /t 10 /d y /n >nul
:a
set HOUR=%time:~0,2%  
set MINUTE=%time:~3,2%  
set SECOND=%time:~6,2%  
set CURRENT_TIME=%HOUR%:%MINUTE%:%SECOND%  
set yy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set hh=%time:~0,2%
set mn=%time:~3,2%
set ss=%time:~6,2%
set filename=%yy%%mm%%dd%%hh%%mn%%ss%
set delay=5
set /a am=%random%
set /a am=am%%600+1
set /a pm=%random%
set /a pm=pm%%600+1
:: 打卡操作
if %HOUR% LEQ 16  if %HOUR% GEQ 11 (
	echo 非打卡时间
	echo 等待时间:%am%
	echo 等待时间:%pm%
	adb shell dumpsys activity | findstr "mFocusedActivity">nul
	echo adb 指令重复发送中
	choice /t 60 /d y /n >nul
	goto a
)
if %HOUR% LEQ 10  if %HOUR% GEQ 8 (
	echo 上班打卡
	echo 等待时间:%am%
	choice /t %am% /d y /n >nul
	adb shell input tap 540 800
	click.bat
	pause
) 
if %HOUR% GEQ   18 (
	echo 下班打卡
	echo 等待时间:%pm%
	choice /t %pm% /d y /n >nul
	adb shell input tap 540 1200
	click.bat	
	pause
)
goto a
