
_getInput:

;MyProject.c,6 :: 		int getInput(int count){
;MyProject.c,7 :: 		count = ~count;
	COMF       FARG_getInput_count+0, 1
	COMF       FARG_getInput_count+1, 1
;MyProject.c,8 :: 		while(!PORTA.B4);
L_getInput0:
	BTFSC      PORTA+0, 4
	GOTO       L_getInput1
	GOTO       L_getInput0
L_getInput1:
;MyProject.c,9 :: 		return count;
	MOVF       FARG_getInput_count+0, 0
	MOVWF      R0+0
	MOVF       FARG_getInput_count+1, 0
	MOVWF      R0+1
;MyProject.c,10 :: 		}
L_end_getInput:
	RETURN
; end of _getInput

_main:

;MyProject.c,12 :: 		void main() {
;MyProject.c,13 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;MyProject.c,14 :: 		ADCON1 = 0x07;
	MOVLW      7
	MOVWF      ADCON1+0
;MyProject.c,15 :: 		TRISA.B4 = 1;
	BSF        TRISA+0, 4
;MyProject.c,16 :: 		TRISA.B0 = 1;
	BSF        TRISA+0, 0
;MyProject.c,17 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;MyProject.c,18 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,19 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,20 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;MyProject.c,21 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,22 :: 		while(PORTA.B4 == 1);
L_main2:
	BTFSS      PORTA+0, 4
	GOTO       L_main3
	GOTO       L_main2
L_main3:
;MyProject.c,23 :: 		while(1){
L_main4:
;MyProject.c,24 :: 		while(PORTA.B4 == 0){
L_main6:
	BTFSC      PORTA+0, 4
	GOTO       L_main7
;MyProject.c,25 :: 		push_count = 1;
	MOVLW      1
	MOVWF      _push_count+0
	MOVLW      0
	MOVWF      _push_count+1
;MyProject.c,26 :: 		}
	GOTO       L_main6
L_main7:
;MyProject.c,27 :: 		while(push_count){
L_main8:
	MOVF       _push_count+0, 0
	IORWF      _push_count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main9
;MyProject.c,28 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,29 :: 		if(PORTA.B0 == 1){
	BTFSS      PORTA+0, 0
	GOTO       L_main10
;MyProject.c,30 :: 		if(PORTD.B0 == 1 && PORTD.B5 == 1){
	BTFSS      PORTD+0, 0
	GOTO       L_main13
	BTFSS      PORTD+0, 5
	GOTO       L_main13
L__main65:
;MyProject.c,31 :: 		PORTD.B5 = 0;
	BCF        PORTD+0, 5
;MyProject.c,32 :: 		PORTD.B4 = 1;
	BSF        PORTD+0, 4
;MyProject.c,33 :: 		Delay_ms(375);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      207
	MOVWF      R12+0
	MOVLW      1
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
	NOP
;MyProject.c,34 :: 		PORTD.B4 = 0;
	BCF        PORTD+0, 4
;MyProject.c,35 :: 		PORTD.B0 = 0;
	BCF        PORTD+0, 0
;MyProject.c,36 :: 		PORTD.B2 = 1;
	BSF        PORTD+0, 2
;MyProject.c,37 :: 		PORTD.B3 = 1;
	BSF        PORTD+0, 3
;MyProject.c,38 :: 		}
	GOTO       L_main15
L_main13:
;MyProject.c,39 :: 		else if(PORTD.B2 == 1 && PORTD.B3 == 1){
	BTFSS      PORTD+0, 2
	GOTO       L_main18
	BTFSS      PORTD+0, 3
	GOTO       L_main18
L__main64:
;MyProject.c,40 :: 		PORTD.B2 = 0;
	BCF        PORTD+0, 2
;MyProject.c,41 :: 		PORTD.B1 = 1;
	BSF        PORTD+0, 1
;MyProject.c,42 :: 		for(man_state = 0; man_state <= 3; man_state++) Delay_ms(125);
	CLRF       _man_state+0
	CLRF       _man_state+1
L_main19:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _man_state+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVF       _man_state+0, 0
	SUBLW      3
L__main68:
	BTFSS      STATUS+0, 0
	GOTO       L_main20
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
	NOP
	NOP
	INCF       _man_state+0, 1
	BTFSC      STATUS+0, 2
	INCF       _man_state+1, 1
	GOTO       L_main19
L_main20:
;MyProject.c,43 :: 		PORTD.B1 = 0;
	BCF        PORTD+0, 1
;MyProject.c,44 :: 		PORTD.B0 = 1;
	BSF        PORTD+0, 0
;MyProject.c,45 :: 		PORTD.B3 = 0;
	BCF        PORTD+0, 3
;MyProject.c,46 :: 		PORTD.B5 = 1;
	BSF        PORTD+0, 5
;MyProject.c,47 :: 		}
L_main18:
L_main15:
;MyProject.c,48 :: 		}
L_main10:
;MyProject.c,49 :: 		while(PORTA.B4 == 0){
L_main23:
	BTFSC      PORTA+0, 4
	GOTO       L_main24
;MyProject.c,50 :: 		if(push_count) push_count = 0;
	MOVF       _push_count+0, 0
	IORWF      _push_count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	CLRF       _push_count+0
	CLRF       _push_count+1
L_main25:
;MyProject.c,51 :: 		}
	GOTO       L_main23
L_main24:
;MyProject.c,52 :: 		}
	GOTO       L_main8
L_main9:
;MyProject.c,53 :: 		while(!push_count){
L_main26:
	MOVF       _push_count+0, 0
	IORWF      _push_count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main27
;MyProject.c,54 :: 		PORTC = 0X0F;
	MOVLW      15
	MOVWF      PORTC+0
;MyProject.c,59 :: 		if(PORTD.B0 && PORTD.B5) state = 0;
	BTFSS      PORTD+0, 0
	GOTO       L_main30
	BTFSS      PORTD+0, 5
	GOTO       L_main30
L__main63:
	CLRF       _state+0
	CLRF       _state+1
	GOTO       L_main31
L_main30:
;MyProject.c,60 :: 		else if(PORTD.B2 && PORTD.B3) state = 1;
	BTFSS      PORTD+0, 2
	GOTO       L_main34
	BTFSS      PORTD+0, 3
	GOTO       L_main34
L__main62:
	MOVLW      1
	MOVWF      _state+0
	MOVLW      0
	MOVWF      _state+1
L_main34:
L_main31:
;MyProject.c,61 :: 		switch(state){
	GOTO       L_main35
;MyProject.c,62 :: 		case 0:
L_main37:
;MyProject.c,63 :: 		PORTD = 0x21;
	MOVLW      33
	MOVWF      PORTD+0
;MyProject.c,64 :: 		count = 14;
	MOVLW      14
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
;MyProject.c,65 :: 		break;
	GOTO       L_main36
;MyProject.c,66 :: 		case 1:
L_main38:
;MyProject.c,67 :: 		PORTD = 0x0C;
	MOVLW      12
	MOVWF      PORTD+0
;MyProject.c,68 :: 		count = 22;
	MOVLW      22
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
;MyProject.c,69 :: 		break;
	GOTO       L_main36
;MyProject.c,70 :: 		}
L_main35:
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVLW      0
	XORWF      _state+0, 0
L__main69:
	BTFSC      STATUS+0, 2
	GOTO       L_main37
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVLW      1
	XORWF      _state+0, 0
L__main70:
	BTFSC      STATUS+0, 2
	GOTO       L_main38
L_main36:
;MyProject.c,71 :: 		for(; count >= 0; count--){
L_main39:
	MOVLW      128
	XORWF      _count+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVLW      0
	SUBWF      _count+0, 0
L__main71:
	BTFSS      STATUS+0, 0
	GOTO       L_main40
;MyProject.c,73 :: 		if(push_count) break;
	MOVF       _push_count+0, 0
	IORWF      _push_count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main42
	GOTO       L_main40
L_main42:
;MyProject.c,74 :: 		PORTB = count_arr[count];
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _count_arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,75 :: 		if(count <= 2 && state == 0) PORTD = 0x11;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVF       _count+0, 0
	SUBLW      2
L__main72:
	BTFSS      STATUS+0, 0
	GOTO       L_main45
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      0
	XORWF      _state+0, 0
L__main73:
	BTFSS      STATUS+0, 2
	GOTO       L_main45
L__main61:
	MOVLW      17
	MOVWF      PORTD+0
	GOTO       L_main46
L_main45:
;MyProject.c,76 :: 		else if(count <= 2 && state == 1) PORTD = 0x0A;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVF       _count+0, 0
	SUBLW      2
L__main74:
	BTFSS      STATUS+0, 0
	GOTO       L_main49
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVLW      1
	XORWF      _state+0, 0
L__main75:
	BTFSS      STATUS+0, 2
	GOTO       L_main49
L__main60:
	MOVLW      10
	MOVWF      PORTD+0
L_main49:
L_main46:
;MyProject.c,77 :: 		for(i = 0; i < 125; i++){
	CLRF       _i+0
	CLRF       _i+1
L_main50:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVLW      125
	SUBWF      _i+0, 0
L__main76:
	BTFSC      STATUS+0, 0
	GOTO       L_main51
;MyProject.c,78 :: 		while(!PORTA.B4){
L_main53:
	BTFSC      PORTA+0, 4
	GOTO       L_main54
;MyProject.c,79 :: 		push_count = getInput(push_count);
	MOVF       _push_count+0, 0
	MOVWF      FARG_getInput_count+0
	MOVF       _push_count+1, 0
	MOVWF      FARG_getInput_count+1
	CALL       _getInput+0
	MOVF       R0+0, 0
	MOVWF      _push_count+0
	MOVF       R0+1, 0
	MOVWF      _push_count+1
;MyProject.c,80 :: 		}
	GOTO       L_main53
L_main54:
;MyProject.c,81 :: 		Delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main55:
	DECFSZ     R13+0, 1
	GOTO       L_main55
	DECFSZ     R12+0, 1
	GOTO       L_main55
	NOP
	NOP
;MyProject.c,77 :: 		for(i = 0; i < 125; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,82 :: 		}
	GOTO       L_main50
L_main51:
;MyProject.c,71 :: 		for(; count >= 0; count--){
	MOVLW      1
	SUBWF      _count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _count+1, 1
;MyProject.c,83 :: 		}
	GOTO       L_main39
L_main40:
;MyProject.c,84 :: 		if(push_count) break;
	MOVF       _push_count+0, 0
	IORWF      _push_count+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main56
	GOTO       L_main27
L_main56:
;MyProject.c,85 :: 		if(state == 0) state = 1;
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main77
	MOVLW      0
	XORWF      _state+0, 0
L__main77:
	BTFSS      STATUS+0, 2
	GOTO       L_main57
	MOVLW      1
	MOVWF      _state+0
	MOVLW      0
	MOVWF      _state+1
	GOTO       L_main58
L_main57:
;MyProject.c,86 :: 		else if(state == 1) state = 0;
	MOVLW      0
	XORWF      _state+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main78
	MOVLW      1
	XORWF      _state+0, 0
L__main78:
	BTFSS      STATUS+0, 2
	GOTO       L_main59
	CLRF       _state+0
	CLRF       _state+1
L_main59:
L_main58:
;MyProject.c,87 :: 		}
	GOTO       L_main26
L_main27:
;MyProject.c,88 :: 		}
	GOTO       L_main4
;MyProject.c,89 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
