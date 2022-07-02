; multi-segment executable file template.

data segment
    ; add your data here!
    welcome db "**************************** Welcome ****************************", 10, 10, 13, "$"
    soalha db "1- Kodam register 16 biti nist?", 9, "a)AX b)DI c)BH d)CX", 10, 10, 13
        db "2- Kodam yek mitavanad dar jayeh khali gharar begirad? MOV AL, ...", 10, 13, 9, "a)AL b)BX c)AX d)ECX", 10, 10, 13
        db "3- Pas az ejrayeh dastooreh DIV, baghimandeh dar kodam zakhireh mishavad?", 10, 13, 9, " a)AX b)BX c)CX d)DX", 10, 10, 13
        db "4- 'A' + 32 = ", 9, "a)'a' b)'Z' c)'x' d)'X'", 10, 10, 13
        db "5- '1' - 48 = ", 9, "a)'!' b)1 c)0 d)Hichkodam", 10, 10, 13
        db "6- Natijeyeh ebarateh roberoh kodam ast? XOR AX,AX", 10, 13, 9, "a)AX b)0 c)1 d)EAX", 10, 10, 13
        db "7- MOV AL, 05", 10, 13, 9, "NOT AL", 10, 13, 9, "Hasel kodam ast?(HEX)", 9, "a)0 b)FF c)FA d)50", 10, 13, "$"
    pasokhnameh_matn db  "************************** Pasokhnameh **************************", 10, 10, 13, "$"
    pasokhnameh db '1', 'c', 'C'
         db '2', 'a', 'A'
         db '3', 'd', 'D'
         db '4', 'a', 'A'
         db '5', 'b', 'B'
         db '6', 'b', 'B'
         db '7', 'c', 'C'
    nomreh db 0
    endl db 10, 13, "$"
    payan_matn db  "***************************** Payan *****************************", 10, 10, 13, "$"
    nomreh_matn db "Nomreyeh Shoma: $"
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    mov bh, 0
    mov cx, 65
    mov bl, 46
    mov ah, 9
    int 10h
    lea dx, welcome
    mov ah, 9
    int 21h

    lea dx, soalha
    mov ah, 9
    int 21h
    
    mov bh, 0
    mov cx, 65
    mov bl, 41
    mov ah, 9
    int 10h
    lea dx, pasokhnameh_matn
    mov ah, 9
    int 21h
    
    mov si, 0
    ; loop L1 start {
        L1:
        mov dx, 0
        ; print shomare soal be range abi
        mov ah, 9
        mov bl, 9
        mov bh, 0
        mov cx, 1
        int 10h
        mov dl, [pasokhnameh + si]
        mov ah, 02
        int 21h
        
        ; print : abi kam rang
        mov ah, 9
        mov bl, 3
        mov cx, 1
        int 10h
        mov dl, ':'
        mov ah, 2
        int 21h    
        
        ; input javabeh karbar be range sorati
        mov al, 0
        mov ah, 9
        mov bl, 5
        mov cx, 1
        int 10h       
        mov ah, 1
        int 21h ; javabeh karbar dar al gharar migirad
        
        if1:
        ; start if1 {
            cmp al, [pasokhnameh + si + 1]
            jne if2
            ; javab dorost: +3 nomreh
            ; nemitavan mostaghim motagheyereh nomreh raa taghyir dad!
            ; dh vaseteh 
            mov dh, [nomreh]
            add dh, 3
            mov [nomreh], dh
            jmp endif
        ; } end if1
        if2:
        ; start if2 {
            cmp al, [pasokhnameh + si + 2]
            jne nomreh_manfi
            ; javab dorost: +3 nomreh
            ; nemitavan mostaghim motagheyereh nomreh raa taghyir dad!
            ; dh vaseteh 
            mov dh, [nomreh]
            add dh, 3
            mov [nomreh], dh
            jmp endif
        ; } end if2
        nomreh_manfi:
        ; start else {
            mov dh, [nomreh]
            cmp dh, 0
            je endif ; nomreh hamvareh veyneh 0 va 20
            ; agar nomreh az 0 bishtar bod yeki kam kon
            dec dh
            mov [nomreh], dh
        ; } end else

        endif:
        add si, 3 ; raften be addresseh shomareh soal badi dar [pasokhanmeh]
        ; raftan be khate bad        
        lea dx, endl
        mov ah, 9
        int 21h
        
        cmp si, 21
        jl L1
    ; } loop L1 end
    ; emteheneh yek nomreyeh jayezeh darad (3*7 = 21)
    ; agar nomreh az 20 bishtar shod haman 20 raa elam kon
    mov dh, [nomreh]
    cmp dh, 20
    jle payan
    mov dh, 20
    mov [nomreh], 20
    
    payan:
    mov bh, 0
    mov cx, 65
    mov bl, 48
    mov ah, 9
    int 10h
    
    lea dx, payan_matn
    mov ah, 9
    int 21h

    mov dx, 0
    ; nomreh yek adad 2 raghami
    mov ax, 0
    mov al, [nomreh]
    cmp al, 10
    jl fail
    pass:
    mov bl, 2 ; barayeh pass shodan natijeh sabz rang
    jmp elam_nomreh

    fail:
    mov bl, 4 ;  barayeh fail shodan natijeh ghermez rang

    elam_nomreh:
    mov si, 10
    div si
    ; ax => dahgan, dx => yekan
    mov di, dx
    add di, 48
    mov si, ax
    add si, 48
    ; si => charactereh dahgan, di => charactereh yekan
    mov cx, 18 ; matneh natijeh kollan 18 character ast => cx=18 yani tolid 18 charactereh rangi
    
    mov ah, 9
    int 10h
    lea dx, nomreh_matn
    mov ah, 9
    int 21h
    ; print do raghameh nomreh
    mov dx, si
    mov ah, 2
    int 21h
    mov dx, di
    int 21h

    lea dx, endl
    mov ah, 9
    int 21h
    ; code end
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.