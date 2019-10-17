@echo off

SET path=%~dp0

java -classpath ".;%path:~0,-5%\lib\*" Main %*
