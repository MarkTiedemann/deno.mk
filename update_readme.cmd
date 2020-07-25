@echo off
if exist third_party (
	echo rd /q /s third_party
	rd /q /s third_party
)

if not exist tmp (
	echo md tmp
	md tmp
)

echo del /q tmp\*
del /q tmp\*

echo cmd /c "set NO_COLOR=true& make.cmd > tmp\first_make.txt 2>&1"
cmd /c "set NO_COLOR=true& make.cmd > tmp\first_make.txt 2>&1"

echo cmd /c "set NO_COLOR=true& make.cmd > tmp\second_make.txt 2>&1"
cmd /c "set NO_COLOR=true& make.cmd > tmp\second_make.txt 2>&1"

echo call make.cmd update_readme
call make.cmd update_readme
