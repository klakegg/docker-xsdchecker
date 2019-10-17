@echo off

SET path=%~dp0

java %JAVA_OPTS% -classpath ".;%path:~0,-5%\lib\*" Main %*
