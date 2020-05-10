@echo off
if not exist third_party md third_party
if not exist third_party\make-4.2.exe curl -o third_party\make-4.2.exe https://raw.githubusercontent.com/MarkTiedemann/make-for-windows/master/make-4.2/64/make.exe
third_party\make-4.2 %*