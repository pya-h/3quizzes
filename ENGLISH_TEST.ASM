.STACK
    DW 256 DUB(?)

.DATA
    STRING_WELCOME DB "Welcome to English Test Program", 0DH, 0AH, "$"
    STRING_HOME DB 0DH, 0AH,"Ali ... to home.", 0DH, 0AH, "a.go  b.is going  c.is go  d.to going", 0DH, 0AH, "--------------------------------------------$"
    STRING_SLEEP DB 0DH, 0AH,"Yesterday I was so ... that i fell sleep at 9 PM.", 0DH, 0AH, "a.depressed b.good c.tired  d.awake", 0DH, 0AH, "--------------------------------------------$"
    STRING_OPTION DB 0DH, 0AH,"... is my only option, failure is not.", 0DH, 0AH, "a.Success b.Failure c.Running  d.None", 0DH, 0AH, "--------------------------------------------$"
    STRING_MATCH DB 0DH, 0AH,"He was trying so hard and finally he ... the match", 0DH, 0AH, "a.won b.win c.will win  d.was winning", 0DH, 0AH, "--------------------------------------------$"
    STRING_SYNONYM DB 0DH, 0AH,"The word 'buy' is a synonym for ... .", 0DH, 0AH, "a.borrow b.lend c.sell d.purchase ", 0DH, 0AH, "--------------------------------------------$"
    STRING_TEST_POINT DB 0DH, 0AH,"YOUR TEST POINT IS: $"

.CODE
    .STARTUP

        MOV AH, 09H
        MOV BL, 03H
        MOV BH, 00H
        MOV CX, 32D
        INT 10H
        
        WELCOME:
        MOV DX, OFFSET STRING_WELCOME
        MOV AH, 09H
        INT 21H
        
        MOV DI, 48D ; = 48 AS FOR ZERO CHARACTER DIGIT
        QUESTION_HOME:
        MOV DX, OFFSET STRING_HOME
        MOV AH, 09H
        INT 21H
        
        GET_KB_1: 
            MOV AH, 01H
            INT 16H
        JZ GET_KB_1
        MOV AH, 00H
        INT 16H
        MOV DX, AX
        MOV AH, 02
        INT 21H
        CMP AL, 98D
        JZ CORRECT_1
        JNZ WRONG_1
        CORRECT_1:
        INC DI
        JMP QUESTION_SLEEP
        WRONG_1:
        DEC DI
    
        QUESTION_SLEEP:
        MOV DX, OFFSET STRING_SLEEP
        MOV AH, 09H
        INT 21H
        GET_KB_2: 
            MOV AH, 01H
            INT 16H
        JZ GET_KB_2
        MOV AH, 00H
        INT 16H
        MOV DX, AX
        MOV AH, 02
        INT 21H
        CMP AL, 99D
        JZ CORRECT_2
        JNZ WRONG_2
        CORRECT_2:
        INC DI
        JMP QUESTION_OPTION
        WRONG_2:
        DEC DI
        
        QUESTION_OPTION:
        MOV DX, OFFSET STRING_OPTION
        MOV AH, 09H
        INT 21H
        GET_KB_3: 
            MOV AH, 01H
            INT 16H
        JZ GET_KB_3
        MOV AH, 00H
        INT 16H
        MOV DX, AX
        MOV AH, 02
        INT 21H
        CMP AL, 97D
        JZ CORRECT_3
        JNZ WRONG_3
        CORRECT_3:
        INC DI
        JMP QUESTION_MATCH
        WRONG_3:
        DEC DI
    
        QUESTION_MATCH:
        MOV DX, OFFSET STRING_MATCH
        MOV AH, 09H
        INT 21H
        GET_KB_4: 
            MOV AH, 01H
            INT 16H
        JZ GET_KB_4
        MOV AH, 00H
        INT 16H
        MOV DX, AX
        MOV AH, 02
        INT 21H
        CMP AL, 97D
        JZ CORRECT_4
        JNZ WRONG_4
        CORRECT_4:
        INC DI
        JMP QUESTION_SYNONYM
        WRONG_4:
        DEC DI
    
        QUESTION_SYNONYM:
        MOV DX, OFFSET STRING_SYNONYM
        MOV AH, 09H
        INT 21H
        GET_KB_5: 
            MOV AH, 01H
            INT 16H
        JZ GET_KB_5
        MOV AH, 00H
        INT 16H
        MOV DX, AX
        MOV AH, 02
        INT 21H
        CMP AL, 100D
        JZ CORRECT_5
        JNZ WRONG_5
        CORRECT_5:
        INC DI
        JMP TEST_POINT
        WRONG_5:
        DEC DI
    
        TEST_POINT:
        MOV AH, 09H
        MOV BL, 02H
        MOV BH, 00H
        MOV AL, 0
        MOV CX, 22D
        INT 10H
        MOV AH, 09H
        MOV BL, 03H
        MOV BH, 00H
        MOV CX, 22D
        INT 10H
        MOV DX, OFFSET STRING_TEST_POINT
        MOV AH, 09H
        INT 21H
        CMP DI, 48D
        JL NEGATIVE_POINT
        
        POSITIVE_POINT:
        MOV AH, 09H
        MOV BL, 02H
        MOV BH, 00H
        MOV CX, 01H 
        INT 10H
        JMP PRINT_POINT
        NEGATIVE_POINT:
        MOV AX, 48D
        SUB AX, DI
        MOV DI, AX
        ADD DI, 48D
        
        MOV AH, 09H
        MOV BL, 04H
        MOV BH, 00H
        MOV CX, 02H 
        INT 10H
        MOV DX, 45D
        MOV AH, 02H
        INT 21H
        
        PRINT_POINT:
        MOV DX, DI
        MOV AH, 02H
        INT 21H
        
        MOV AH, 4CH
        INT 21H
    .EXIT
END