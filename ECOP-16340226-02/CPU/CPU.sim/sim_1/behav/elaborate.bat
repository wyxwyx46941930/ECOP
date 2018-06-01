@echo off
set xv_path=D:\\xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto d9746928c0a74d06b13feac788a40f30 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot SingleCircleCPUTest_behav xil_defaultlib.SingleCircleCPUTest xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
