
;------------------------------------------------------
; EMBEDDED SYSTEMS
; Practical Work #1
;------------------------------------------------------
; This is a source file of the program which finds the
; maximal element from the given array of numbers.
#include "p16f84.inc" 

c_adr set 0x30  ; the starting address of the array, a constant
v_ptr equ 0x2F  ; the pointer to the current element in array, a variable
v_min equ 0x2E  ; the maximal number in array, a variable
c_num set 0x14   ; the number of elements in array, a constant 

; The allocation of variables in Data Memory:
; Address   :   The value of object
; 0x2E      :   v_ptr
; 0x2F      :   v_min
; 0x30      :   array[0]
; 0x31      :   array[1]
; 0x32      :   array[2]
; ...................
; 0x43      :   array[20]

BEGIN:
	BCF STATUS, RP0 ; set Bank0 in Data Memory by clearing RP0 bit in STATUS register
	CLRF v_ptr      ; v_ptr=0
	MOVLW  0xFF 
	MOVWF v_min      ; v_min=0xFF
LOOP1:
	MOVF v_ptr,0    ; W=v_ptr
	ADDLW c_adr     ; W=W+c_addr
	MOVWF FSR       ; FSR=W, INDF=array[W]
	MOVF INDF,0     ; W=INDF
	SUBWF v_min,W   ; W=W-v_min
	BTFSS STATUS,C  ; If W > 0 then go to SKIP
	GOTO SKIP
			; Else W <= 0 then W is smaller than v_min
	MOVF INDF,0
	MOVWF v_min     ; v_min=array[v_ptr]
	
SKIP:
	INCF v_ptr,0x1  ; v_ptr=v_ptr+1
	MOVLW c_num     ; W=c_num
	SUBWF v_ptr,0   ; W=W-v_ptr
	BTFSS STATUS,C  ; v_ptr > c_num ?
	GOTO LOOP1      ; no
	                ; yes
	CLRF v_ptr      ; v_ptr=0
	CLRF v_min      ; v_min=0
	end


