data segment
    ; add your data here!
    question1 db "21 * 11 = ?", 10, "1) 111    2) 131    3) 231    4) 141", 13, 10, "$"
    question2 db "105 * 5 = ?", 10, "1) 525    2) 515    3) 505    4) 535", 13, 10, "$"
    question3 db "70 * 35 = ?", 10, "1) 1050    2) 2450    3) 1450    4) 3450", 13, 10, "$"
    question4 db "50 * 50 = ?", 10, "1) 250    2) 25000    3) 12500    4) 2500", 13, 10 , "$"
    question5 db "621 * 3 = ?", 10, "1) 1863    2) 1083    3) 1683    4) 1283", 13, 10 , "$"
    question6 db "10 * 31 = ?", 10, "1) 3100    2) 310    3) 3010    4) 30100", 13, 10 , "$"
    question7  db "11 * 51 = ?", 10, "1) 511    2) 561    3) 161    4) 431", 13, 10 , "$"
    question8 db "111 * 3 = ?", 10, "1) 343    2) 323    3) 303    4) 333", 13, 10 , "$"
    question9 db "29 * 50 = ?", 10, "1) 450    2) 1550    3) 1450    4) 550", 13, 10 , "$"
    colors db 2, 4, 3, 4, 9, 2, 4, 3, 4
    answers db 3, 1, 2, 4, 1, 2, 2, 4, 3
    TA dw 0
    WA dw 0
    ResultTrueAnswers db 13, 10, "Number of True answers: $"  
    ResultWrongAnswers db 13, 10, "Number of Wrong answers: $"
ends

stack segment
    dw   128  dup(0)
ends

code segment
main proc far
    start:
        mov ax, data
        mov ds, ax
        mov es, ax
        
        lea ax, Question9
        push ax
        lea ax, Question8
        push ax
        lea ax, Question7
        push ax
        lea ax, Question6
        push ax
        lea ax, Question5
        push ax
        lea ax, Question4
        push ax
        lea ax, Question3
        push ax
        lea ax, Question2
        push ax
        lea ax, Question1 
        push ax
        
        mov di, 0 ; = TA
        mov si, 0
        ask:
            mov cx, 11
            pop dx
            call print_color
            checkKeyboard: 
                mov ah, 1
                int 16h
            jz checkKeyboard
            ; if a key has been pressed
            mov ah, 0
            int 16h ; get the pressed key ascii value
            sub al, '0'
            
            cmp al, 1
                jl checkKeyboard
            cmp al, 4
                jg checkKeyboard
            
            mov dl, answers[si]
            cmp al, dl
            jne wrongAnswer

                mov di, TA
                inc di    
                mov TA, di
            jmp nextQuestion

            wrongAnswer:
                mov di, WA
                inc di
                mov WA, di
            nextQuestion:
                inc si
        cmp si, 9
        jl ask ;loop
        
        mov si, 0
        mov cx, 24
        lea dx, ResultTrueAnswers
        call print_color
        mov di, TA
        add di, '0'
        mov dh, 0
        mov dx, di 
        mov ah, 2 
        int 21h
        
        mov si, 1 
        lea dx, ResultWrongAnswers
        ;call print_color
        mov ah, 9
        int 21h
        mov di, WA
        add di, '0'
        mov dh, 0
        mov dx, di 
        mov ah, 2
        int 21h 
        
        mov ax, 4c00h ; exit to operating system.
        int 21h
endp

print_color proc near
    mov ah, 09
    mov bl, colors[si]
    mov bh, 00
    int 10h
    mov ah, 9
    int 21h
    ret
endp

ends

end start ; set entry point and stop the assembler.