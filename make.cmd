@echo off
if not exist third_party (
	echo mkdir third_party
	mkdir third_party
)
if not exist third_party\make-4.2.exe (
	echo powershell -c "Invoke-WebRequest -OutFile third_party\make-4.2.exe -Uri https://raw.githubusercontent.com/MarkTiedemann/make-for-windows/master/make-4.2/64/make.exe"
	powershell -c "Invoke-WebRequest -OutFile third_party\make-4.2.exe -Uri https://raw.githubusercontent.com/MarkTiedemann/make-for-windows/master/make-4.2/64/make.exe"
)
echo third_party\make-4.2.exe %*
third_party\make-4.2.exe %*
