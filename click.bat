:: 获取图片
set delay=5
choice /t %delay% /d y /n >nul
adb shell screencap -p sdcard/screen.png
adb pull sdcard/screen.png
adb shell rm sdcard/screen.png
move /-y screen.png %~sdp0
::ren "screen.png" "%filename%.png"
:: ftp 上传
choice /t %delay% /d y /n >nul
echo open 60.205.30.49>>ftp.up
echo bxu2359240250>>ftp.up
echo lj011200>>ftp.up
echo bin>>ftp.up
echo cd /htdocs/>>ftp.up
echo put "screen.png">>ftp.up
echo close>>ftp.up
echo bye>>ftp.up
FTP -s:ftp.up
choice /t %delay% /d y /n >nul
del screen.png
del ftp.up	
del screen.txt