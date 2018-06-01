.text                    
.globl main              

main:                    
  la $a0, prompt1        # 打印 prompt1
  li $v0, 4
  syscall

  la $t0, num            # 把10这个数字存到寄存器t0中
                        
  lw $t0, ($t0)          

  add $a0, $t0, $0       # 打印数字10
  li $v0, 1
  syscall

  la $a0, prompt2        # 打印 prompt2
  li $v0, 4
  syscall

  sll $a0, $t0, 2        # 为数组申请空间
  li $v0, 9              
  syscall

  add $t1, $v0, $0       # t1寄存器中存数组首地址

  add $t2, $0, $0        # 把临时变量i存到寄存器t2中

 inputLoop:
  slt	$t3, $t2, $t0	     # for循环判断条件如果i < 10 置t3为1否则置t3为0 
  beq $t3, $0, inputLoopBreak

  li $v0, 5              # 读一个数字
  syscall

  sll $t3, $t2, 2        # 求出i的偏移量
                       
  add $t3, $t1, $t3      # 找到arr[i]的地址
  sw $v0, ($t3)          # arr[i] = 输入的数字
  j	inputLoopCont        

 inputLoopCont:
  addi $t2, $t2, 1       # i ++ 
  j	inputLoop           

 inputLoopBreak:
  add $t2, $0, $0        # i = 0 

 outerLoop:
  slt	$t3, $t2, $t0	     # for循环判断条件如果i < 10 置t3为1否则置t3为0
  beq $t3, $0, outerLoopBreak

  add $t4, $t2, $0       # max = i 
  addi $t5, $t2, 1       # j = i + 1 

 innerLoop:
  slt	$t3, $t5, $t0	     # for循环判断条件如果j < 10置t3为1否则置t3为0
  beq $t3, $0, innerLoopBreak

  # get arr[j]
  sll $t3, $t5, 2        # 求出j的偏移量
                       
  add $t3, $t1, $t3      # 找到arr[j]
  lw $t3, ($t3)          # 把t3中存放的数字拿出来

  # get arr[maxIndex]
  sll $t6, $t4, 2        # 找到max的偏移量
                        
  add $t6, $t1, $t6      # 找到arr[max]
  lw $t6, ($t6)          # 把t6中存放的数字拿出来

  slt $t3, $t3, $t6      # 判断arr[j]与arr[max]大小
  bne $t3, $0, afterReplace

 replace:
  add $t4, $t5, $0       # max = j 
  j afterReplace

 afterReplace:
  j	innerLoopCont        # continue

 innerLoopCont:
  addi $t5, $t5, 1       # j++
  j	innerLoop            

 innerLoopBreak:
  beq $t2, $t4, afterSwap  # 如果 i = max 不交换

 swap:

  sll $t3, $t2, 2        # 计算i偏移量
                      
  add $t3, $t1, $t3      # 求出arr[i]

  sll $t5, $t4, 2        # 计算max偏移量
                        
  add $t5, $t1, $t5      # 求出arr[max]

  lw $t6, ($t3)          # 取出arr[i]

  lw $t7, ($t5)          # 取出arr[max]
                         
  sw $t7, ($t3)          # 交换

  sw $t6, ($t5)          
                         

  j afterSwap            

 afterSwap:
  j	outerLoopCont        # 继续循环

 outerLoopCont:
  addi $t2, $t2, 1       # i++
  j	outerLoop            # 进入外层循环

 outerLoopBreak:
  la $a0, result
  li $v0, 4
  syscall
  add $t2, $0, $0       # i = 0 

 outputLoop:
  slt	$t3, $t2, $t0	     # 判断 i < 10 是否成立
  beq $t3, $0, outputLoopBreak

  la $a0, space          # 打印空格
  li $v0, 4
  syscall

  sll $t3, $t2, 2        # 求出i的偏移量
                         
  add $t3, $t1, $t3     
  lw $a0, ($t3)          # 把t3中存放的数字拿出来存入a0

  li $v0, 1              # 打印数字
  syscall

  j	outputLoopCont       

 outputLoopCont:
  addi $t2, $t2, 1       # i++
  j	outputLoop          

 outputLoopBreak:
  la $a0, newline        # 打印换行
  li $v0, 4
  syscall

  li $v0, 10             # 退出
  syscall

.data                    # 数据声明模块
  prompt1:
    .asciiz "Please input "

  prompt2:
    .asciiz " unsigned integers, with one integer in one line:\n"

  result:
    .asciiz "Result:"

  space:
    .asciiz " "

  newline:
    .asciiz "\n"

  num:
    .word 0x0000000a