@echo off
REM Usage: build_dependencies.bat [precompiler_flags]
SetLocal
set /p cbpath= <cblocation
set /p pythonpath= <pythonlocation
set cbpp_path=%cbpath%\IDE\cbpp\cbpp.py
set compile_flags=%*
set sourcedir=src
set current=%~dp0

if (%cbpath%) == () goto error_no_cb
if (%pythonpath%) == () goto error_no_python

@echo on
%pythonpath% %cbpp_path% %compile_flags% --flags=_RELEASE src\main.cbpp %sourcedir%\main.cb -d %current%src\
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB;USE_EDITOR_COMPONENTS sync\sync.cbpp %sourcedir%\inc\sync_debug.cb -d %current%editor
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB sync\sync.cbpp %sourcedir%\inc\sync_release.cb -d %current%editor
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB seek\foobar.cbpp %sourcedir%\inc\foobar.cb -d %current%seek\
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB;_RELEASE src\editor.cbpp %sourcedir%\inc\editor_release.cb -d %current%src\
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB;_DEBUG src\editor.cbpp %sourcedir%\inc\editor_debug.cb -d %current%src\
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB;_RELEASE src\objloader.cbpp %sourcedir%\inc\objloader.cb -d %current%src\
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB;_RELEASE src\effects\garbage.cbpp %sourcedir%\inc\garbage.cb -d %current%src\effects\
ml src\camera.cbml src\camera.cbpp
@echo off
REM do not use pause here, use the --wait-on-error flag instead
exit /b

:error_no_cb
echo Please save your CoolBasic editor location to file cblocation
pause
exit /b

:error_no_python
echo Please save your Python interpreter location to file pythonlocation
pause
exit /b

EndLocal
