@echo off
if not exist third_party\make-4.2.exe (
    powershell -c "Invoke-WebRequest -Uri https://raw.githubusercontent.com/MarkTiedemann/make-for-windows/master/make-4.2/64/make.exe -OutFile third_party\make-4.2.exe"
)
third_party\make-4.2.exe %*
