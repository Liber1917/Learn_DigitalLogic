@echo off
set bin_path=E:/SoftWare/modelsim/win64
cd E:/NEU/FPGA/Learn/Learn_DigitalLogic/4WithHardware/logos/ip_pll/ip_pll/sim/behav
call "%bin_path%/modelsim"   -do "do {run_behav_compile.tcl};do {run_behav_simulate.tcl}" -l run_behav_simulate.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
