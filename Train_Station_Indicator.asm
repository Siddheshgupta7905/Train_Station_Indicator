ORG 0000H

; LCD control pin definitions (connected to P2.0, P2.1, P2.2)
RS EQU P2.0
RW EQU P2.1
EN EQU P2.2

; Delay subroutine
DELAY: 
    MOV R1, #0FFH
D1: MOV R2, #0FFH
D2: DJNZ R2, D2
    DJNZ R1, D1
    RET

; Send Command to LCD
LCD_CMD: 
    CLR RS         ; RS = 0 for command
    CLR RW         ; RW = 0 for write
    SETB EN        ; EN = 1
    ACALL DELAY
    CLR EN         ; EN = 0
    ACALL DELAY
    RET

; Send Data to LCD
LCD_DATA:
    SETB RS        ; RS = 1 for data
    CLR RW         ; RW = 0 for write
    SETB EN        ; EN = 1
    ACALL DELAY
    CLR EN         ; EN = 0
    ACALL DELAY
    RET

; LCD Initialization
LCD_INIT:
    MOV A, #38H    ; Function set: 2 lines, 5x7 matrix
    MOV P1, A
    ACALL LCD_CMD

    MOV A, #0CH    ; Display ON, cursor OFF
    MOV P1, A
    ACALL LCD_CMD

    MOV A, #06H    ; Entry mode set: increment cursor
    MOV P1, A
    ACALL LCD_CMD

    MOV A, #01H    ; Clear display
    MOV P1, A
    ACALL LCD_CMD

    MOV A, #80H    ; Cursor at beginning of 1st line
    MOV P1, A
    ACALL LCD_CMD
    RET

MAIN:
    ACALL LCD_INIT

    ; Display "BORIVALI"
    MOV A, #'B'
    MOV P1, A
    ACALL LCD_DATA

    MOV A, #'O'
    MOV P1, A
    ACALL LCD_DATA

    MOV A, #'R'
    MOV P1, A
    ACALL LCD_DATA

    MOV A, #'I'
    MOV P1, A
    ACALL LCD_DATA

    MOV A, #'V'
    MOV P1, A
    ACALL LCD_DATA

    MOV A, #'A'
    MOV P1, A
    ACALL LCD_DATA

    MOV A, #'L'
    MOV P1, A
    ACALL LCD_DATA

    MOV A, #'I'
    MOV P1, A
    ACALL LCD_DATA

    SJMP $

END
