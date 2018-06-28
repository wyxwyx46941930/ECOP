@echo off
set xv_path=D:\\xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xsim TestCPU_behav -key {Behavioral:sim_1:Functional:TestCPU} -tclbatch TestCPU.tcl -view C:/Users/dell/Desktop/MultipleCPU/TestCPU_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
