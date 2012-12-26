@echo on

set /p archiverpath=<7ziplocation

set archivename=cbdemo.zip
set tempdir=release\temp
set infodir=release\nfo
set archivedir=release\archives
set assetdir=src\assets
set sourcedir=src
set binarypath=src\cbRun.exe
REM the final binary name
set binaryname=cbdemo.exe
set sourcearchive=%tempdir%\source.zip


rmdir /Q /S %tempdir%
mkdir %tempdir%
mkdir %tempdir%\assets
xcopy %infodir% %tempdir% /Y /E
xcopy %assetdir% %tempdir%\assets /Y /E
copy %binarypath% %tempdir%\%binaryname%

del %sourcearchive%
del %archivedir%\%archivename%

"%archiverpath%" a -xr@source_exclude.txt -xr!assets -tzip -y %sourcearchive% %sourcedir%\* 
copy %sourcearchive% %tempdir%\source.zip

cd release
cd temp
"%archiverpath%" a -tzip -y ..\..\%archivedir%\%archivename% .\*
cd ..
cd ..

