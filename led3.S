/*
 * �ļ�����	led.s	
 * ���ߣ�	����ʦ
 * ������	��������һ��������LED�̵̳��Լ�д�ĵ�һ���������
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
	ldr r1, =(1<<12) //��
	//ldr r1, =(0<<12) //��
	str r1,[r0]
	//r0, =(0<<12)
	//bic r0, r0, #(1<<12)
	//orr r0, r0, #(1<<12)
	mcr p15, 0, r0, c1, c0, 0

	// ��һ������0x11111111д��0xE0200240(GPJ0CON)λ��
	ldr r0, =0x11111111			// �Ӻ����=���Կ����õ���ldrαָ���Ϊ��Ҫ���������ж������
	ldr r1, =GPJ0_CON			// �ǺϷ����������ǷǷ���������һ��д���붼��ldrαָ��
	str r0, [r1]				// �Ĵ������Ѱַ�������ǰ�r0�е���д�뵽r1�е���Ϊ��ַ���ڴ���ȥ
	ldr r2, =GPD0_CON
	str r0, [r2]

	// �ڶ�������0x0д��0xE0200244(GPJ0DAT)λ��
loop:
	ldr r0, =(0<<3) | (1<<4) | (1<<5)
	ldr r1, =GPJ0_DAT
	str r0, [r1]				// ��0д�뵽GPJ0DAT�Ĵ����У����ż�����͵�ƽ��LED����
	ldr r0, =(1<<1)
	ldr r2, =GPD0_DAT
	str r0, [r2] 
	bl delay
	
	ldr r0, =(1<<3) | (0<<4) | (1<<5)
	ldr r1, =GPJ0_DAT
	str r0, [r1]				// ��0д�뵽GPJ0DAT�Ĵ����У����ż�����͵�ƽ��LED����
	ldr r0, =(1<<1)
	ldr r2, =GPD0_DAT
	str r0, [r2] 
	bl delay
	
	ldr r0, =(1<<3) | (1<<4) | (0<<5)
	ldr r1, =GPJ0_DAT
	str r0, [r1]				// ��0д�뵽GPJ0DAT�Ĵ����У����ż�����͵�ƽ��LED����
	ldr r0, =(1<<1)
	ldr r2, =GPD0_DAT
	str r0, [r2] 
	bl delay
	
	ldr r0, =(1<<3) | (1<<4) | (1<<5)
	ldr r1, =GPJ0_DAT
	str r0, [r1]				// ��0д�뵽GPJ0DAT�Ĵ����У����ż�����͵�ƽ��LED����
	ldr r0, =(0<<1)
	ldr r2, =GPD0_DAT
	str r0, [r2] 
	bl delay
	
	b loop

flag:							// ������д��һ����ѭ������Ϊ���������ֱ����CPU�����еģ�CPU��
	b flag						// ���������������ֱ��CPU�ϵ�ػ���������ǵĳ������еĴ��붼
								// ִ������CPU�ͻ��ܷɣ��ܷ��Ժ���δ����ģ�����ǧ������CPU
								// �ܷɣ�������CPU�ܷɵİ취������������������ִ�����������ѭ��


delay:
	ldr r3, =0x0
	ldr r4, =90000
delay_loop:
	add r3, r3, #1
	cmp r3, r4
	bne delay_loop
	mov pc, lr




