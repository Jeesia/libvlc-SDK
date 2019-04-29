# libvlc-SDK
最新版的vlc安装目录中不再包含libvlc SDK。
Windows下 libvlc SDK 获取方式有两种，如下。

## 方式1. 官网下载 
例： http://download.videolan.org/pub/videolan/vlc/last/win32/
<br>          调试信息文件  vlc-3.0.6-win32-debugsym.7z 
<br>          SDK文件      vlc-3.0.6-win32.7z 
          
## 方式2. 从dll导出

### 安装VLC 

### 运行.bat批处理文件
文件内容为以下代码
<br>（其中"C:\Program Files (x86)\VideoLAN\VLC\"为安装目录，libvlc libvlccore 为需要导出lib库的名称）

```
cd /d "C:\Program Files (x86)\VideoLAN\VLC\"
set str=libvlc libvlccore
for %%k in (%str%) do (
	dumpbin /exports %%k.dll > %%k.def
	echo EXPORTS > %%k.def
	for /f "usebackq tokens=4,* delims=_ " %%i in (`dumpbin /exports %%k.dll`) do (
		if %%i==%%k echo %%i_%%j >> %%k.def 
	)
	lib /def:%%k.def /out:%%k.lib /machine:x86	
	xcopy .\%%k.def .\lib\
	xcopy .\%%k.lib .\lib\
	xcopy .\%%k.exp .\lib\
)
```
### 参考
https://wiki.videolan.org/GenerateLibFromDll
