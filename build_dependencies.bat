@echo off
SetLocal
set /p cbpath= <cblocation
set /p pythonpath= <pythonlocation
set cbpp_path=%cbpath%\IDE\cbpp\cbpp.py
set compile_flags=
set sourcedir=src

if (%cbpath%) == () goto error_no_cb
if (%pythonpath%) == () goto error_no_python

@echo on
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB;USE_EDITOR_COMPONENTS editor\sync.cbpp %sourcedir%\inc\sync_debug.cb
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB editor\sync.cbpp %sourcedir%\inc\sync_release.cb
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB seek\foobar.cbpp %sourcedir%\inc\foobar.cb
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB;_RELEASE src\editor.cbpp %sourcedir%\inc\editor_release.cb
%pythonpath% %cbpp_path% %compile_flags% --flags=BUILD_AS_LIB;_DEBUG src\editor.cbpp %sourcedir%\inc\editor_debug.cb
@echo off

exit /b

:error_no_cb
echo Please save your CoolBasic editor location to file cblocation
exit /b

:error_no_python
echo Please save your Python interpreter  location to file pythonlocation
exit /b

EndLocal