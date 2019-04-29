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
 

