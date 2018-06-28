@echo off
set xv_path=D:\\xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 09e5ac719a424377b43d4b99d4083e28 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot TestCPU_behav xil_defaultlib.TestCPU xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
