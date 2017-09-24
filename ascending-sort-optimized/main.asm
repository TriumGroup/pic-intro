
;------------------------------------------------------
; EMBEDDED SYSTEMS
; Practical Work #1
;------------------------------------------------------
#include "p16f84.inc" 

c_array_base set 0x10
c_elements_count set 0xA

v_max_ptr equ 0x0C
v_ptr equ 0x0D

v_previous equ 0x0E
v_swap_tmp equ 0x0F

BEGIN:
	BCF STATUS, RP0
	MOVLW c_elements_count-1
	MOVWF v_max_ptr

MAIN_LOOP:
	MOVF v_max_ptr, W
	MOVWF v_ptr
	MOVLW c_array_base-1
	MOVWF FSR

INNER_LOOP:
	INCF FSR, F

	MOVF INDF, W   
	MOVWF v_previous

	INCF FSR
	MOVF INDF, W
	SUBWF v_previous,W

	BTFSS STATUS,C
	GOTO SKIP

SWAP:
	MOVF INDF, W
	MOVWF v_swap_tmp
	MOVF v_previous, W
	MOVWF INDF

	DECF FSR
	MOVF v_swap_tmp, W
	MOVWF INDF

SKIP:
	DECFSZ v_ptr, F
	GOTO INNER_LOOP

MAIN_LOOP_END:
	DECFSZ v_max_ptr, F
	
	GOTO MAIN_LOOP

	END
