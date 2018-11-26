:: 编码格式 GB2312  
@echo off
echo 记得写周报
set day=%date:~-1%
:a

if %day%==七 (
	echo %day%
	choice /t 5 /d y /n >nul
	exit
)
adb shell dumpsys activity | findstr "mFocusedActivity"
choice /t 60 /d y /n >nul
goto a
