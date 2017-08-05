/*
 * 文件名：	led.s	
 * 作者：	朱老师
 * 描述：	这是我们一步步点亮LED教程的自己写的第一个裸机程序
 */

 #define GPJ0_CON 0xE0200240
 #define GPJ0_DAT 0xE0200244
 #define GPD0_CON 0xE02000A0
 #define GPD0_DAT 0xE02000A4
 #define WT_CON 0xE2700000
 
 .global _start
_start:

	ldr r0, =(0<<5)
	ldr r1, =WT_CON
	str r0, [r1]
	
	mrc p15, 0, r0, c1, c0, 0
	ldr r1, =(1<<12) //开
	//ldr r1, =(0<<12) //关
	str r1,[r0]
	//r0, =(0<<12)
	//bic r0, r0, #(1<<12)
	//orr r0, r0, #(1<<12)
	mcr p15, 0, r0, c1, c0, 0

	// 第一步：把0x11111111写入0xE0200240(GPJ0CON)位置
	ldr r0, =0x11111111			// 从后面的=可以看出用的是ldr伪指令，因为需要编译器来判断这个数
	ldr r1, =GPJ0_CON			// 是合法立即数还是非法立即数。一般写代码都用ldr伪指令
	str r0, [r1]				// 寄存器间接寻址。功能是把r0中的数写入到r1中的数为地址的内存中去
	ldr r2, =GPD0_CON
	str r0, [r2]

	// 第二步：把0x0写入0xE0200244(GPJ0DAT)位置
loop:
	ldr r0, =(0<<3) | (1<<4) | (1<<5)
	ldr r1, =GPJ0_DAT
	str r0, [r1]				// 把0写入到GPJ0DAT寄存器中，引脚即输出低电平，LED点亮
	ldr r0, =(1<<1)
	ldr r2, =GPD0_DAT
	str r0, [r2] 
	bl delay
	
	ldr r0, =(1<<3) | (0<<4) | (1<<5)
	ldr r1, =GPJ0_DAT
	str r0, [r1]				// 把0写入到GPJ0DAT寄存器中，引脚即输出低电平，LED点亮
	ldr r0, =(1<<1)
	ldr r2, =GPD0_DAT
	str r0, [r2] 
	bl delay
	
	ldr r0, =(1<<3) | (1<<4) | (0<<5)
	ldr r1, =GPJ0_DAT
	str r0, [r1]				// 把0写入到GPJ0DAT寄存器中，引脚即输出低电平，LED点亮
	ldr r0, =(1<<1)
	ldr r2, =GPD0_DAT
	str r0, [r2] 
	bl delay
	
	ldr r0, =(1<<3) | (1<<4) | (1<<5)
	ldr r1, =GPJ0_DAT
	str r0, [r1]				// 把0写入到GPJ0DAT寄存器中，引脚即输出低电平，LED点亮
	ldr r0, =(0<<1)
	ldr r2, =GPD0_DAT
	str r0, [r2] 
	bl delay
	
	b loop

flag:							// 这两行写了一个死循环。因为裸机程序是直接在CPU上运行的，CPU会
	b flag						// 逐行运行裸机程序直到CPU断电关机。如果我们的程序所有的代码都
								// 执行完了CPU就会跑飞（跑飞以后是未定义的，所以千万不能让CPU
								// 跑飞），不让CPU跑飞的办法就是在我们整个程序执行完后添加死循环


delay:
	ldr r3, =0x0
	ldr r4, =90000
delay_loop:
	add r3, r3, #1
	cmp r3, r4
	bne delay_loop
	mov pc, lr





