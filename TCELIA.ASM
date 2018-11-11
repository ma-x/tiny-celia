SETGRP  equ     007EH
FILVRM  equ     0056H
LDIRVM  equ     005CH

PAT1    equ     0000H
PAT2    equ     0800H
PAT3    equ     1000H
NAM1    equ     1800H
COL1    equ     2000H
COL2    equ     2800H
COL3    equ     3000H
SPR     equ     3800H

        org     0A000H - 7

        db      0FEH                    ; Header for MSX binary file
        dw      MAIN
        dw      BOTTOM - MAIN
        dw      MAIN

MAIN:
        call    SETGRP                  ; Set VDP to graphics mode

        ld      hl,COL1                 ; Fill color table #1~#3
        ld      bc,01800H
        ld      a,0F0H
        call    FILVRM

        ld      hl,sprite               ; Set sprite genarator table
        ld      de,SPR
        ld      bc,sprite_end-sprite
        call    LDIRVM

        ld      hl,pattern              ; Set pattern generator table #1
        ld      de,PAT1+(8*080H)
        ld      bc,pattern_end-pattern
        call    LDIRVM
        ld      hl,pattern              ; #2
        ld      de,PAT2+(8*080H)
        ld      bc,pattern_end-pattern
        call    LDIRVM
        ld      hl,pattern              ; #3
        ld      de,PAT3+(8*080H)
        ld      bc,pattern_end-pattern

        call    LDIRVM
        ld      hl,color                ; Set color table #1
        ld      de,COL1+(8*080H)
        ld      bc,color_end-color
        call    LDIRVM
        ld      hl,color                ; #2
        ld      de,COL2+(8*080H)
        ld      bc,color_end-color
        call    LDIRVM
        ld      hl,color                ; #3
        ld      de,COL3+(8*080H)
        ld      bc,color_end-color
        call    LDIRVM

        ld      b,16                    ; draw map
        ld      hl,map
        ld      de,NAM1
_1:     push    bc
        push    hl
        push    de
        ld      bc,16
        call    LDIRVM
        ld      bc,16
        pop     hl
        add     hl,bc
        add     hl,bc
        ex      de,hl
        pop     hl
        add     hl,bc
        pop     bc
        djnz    _1

        ret

sprite:
        db      000H, 03CH, 06EH, 05EH, 07EH, 07EH, 03CH, 000H  ; Crystal ball
        db      03CH, 0BDH, 05AH, 03CH, 03CH, 07EH, 024H, 024H  ; Celia
sprite_end:

pattern:
        db      0FFH, 0FFH, 0E0H, 0C0H, 0C0H, 0C0H, 0C3H, 0C3H  ; 80: Wooden block
        db      0FFH, 0FFH, 007H, 003H, 003H, 003H, 0C3H, 0C3H  ; 81
        db      0C3H, 0C3H, 0C0H, 0C0H, 0C0H, 0E0H, 0FFH, 0FFH  ; 82
        db      0C3H, 0C3H, 003H, 003H, 003H, 007H, 0FFH, 0FFH  ; 83
        db      0FFH, 0FFH, 000H, 000H, 000H, 000H, 0FFH, 0FFH  ; 84
        db      0C3H, 0C3H, 0C3H, 0C3H, 0C3H, 0C3H, 0C3H, 0C3H  ; 85
        db      0C3H, 0C3H, 000H, 000H, 000H, 000H, 0C3H, 0C3H  ; 86
        db      0FFH, 0FFH, 0FFH, 0FFH, 0FFH, 0FFH, 0FFH, 0FFH  ; 87

        db      0FFH, 0FFH, 0E0H, 0C0H, 0C0H, 0C0H, 0C3H, 0C3H  ; 88: Rock block
        db      0FFH, 0FFH, 007H, 003H, 003H, 003H, 0C3H, 0C3H  ; 89
        db      0C3H, 0C3H, 0C0H, 0C0H, 0C0H, 0E0H, 0FFH, 0FFH  ; 8A
        db      0C3H, 0C3H, 003H, 003H, 003H, 007H, 0FFH, 0FFH  ; 8B
        db      0FFH, 0FFH, 000H, 000H, 000H, 000H, 0FFH, 0FFH  ; 8C
        db      0C3H, 0C3H, 0C3H, 0C3H, 0C3H, 0C3H, 0C3H, 0C3H  ; 8D
        db      0C3H, 0C3H, 000H, 000H, 000H, 000H, 0C3H, 0C3H  ; 8E
        db      0FFH, 0FFH, 0FFH, 0FFH, 0FFH, 0FFH, 0FFH, 0FFH  ; 8F

        db      000H, 000H, 000H, 000H, 000H, 000H, 000H, 000H  ; 90: Floor
        db      000H, 03CH, 07EH, 07EH, 07EH, 07EH, 03CH, 000H  ; 91: Hole
        db      0FFH, 0DFH, 0C7H, 0C1H, 0DFH, 0DFH, 08FH, 0FFH  ; 92: Goal flag
        db      000H, 000H, 000H, 000H, 000H, 000H, 000H, 000H  ; 93:
pattern_end:

color:
        db      091H, 091H, 091H, 091H, 091H, 091H, 091H, 091H  ; 80
        db      091H, 091H, 091H, 091H, 091H, 091H, 091H, 091H  ; 81
        db      091H, 091H, 091H, 091H, 091H, 091H, 091H, 091H  ; 82
        db      091H, 091H, 091H, 091H, 091H, 091H, 091H, 091H  ; 83
        db      091H, 091H, 091H, 091H, 091H, 091H, 091H, 091H  ; 84
        db      091H, 091H, 091H, 091H, 091H, 091H, 091H, 091H  ; 85
        db      091H, 091H, 091H, 091H, 091H, 091H, 091H, 091H  ; 86
        db      091H, 091H, 091H, 091H, 091H, 091H, 091H, 091H  ; 87
        db      0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H  ; 88
        db      0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H  ; 89
        db      0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H  ; 8A
        db      0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H  ; 8B
        db      0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H  ; 8C
        db      0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H  ; 8D
        db      0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H  ; 8E
        db      0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H, 0E1H  ; 8F
        db      01CH, 01CH, 01CH, 01CH, 01CH, 01CH, 01CH, 01CH  ; 90
        db      01CH, 01CH, 01CH, 01CH, 01CH, 01CH, 01CH, 01CH  ; 91
        db      0CAH, 0CAH, 0CAH, 0CAH, 0CAH, 0CAH, 0CAH, 0CAH  ; 92
        db      000H, 000H, 000H, 000H, 000H, 000H, 000H, 000H  ; 93
color_end:

map:
        db      08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH
        db      08FH, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08FH
        db      08FH, 08FH, 08CH, 08CH, 08CH, 08CH, 08CH, 089H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08FH
        db      08FH, 090H, 090H, 090H, 090H, 090H, 090H, 08DH, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08FH
        db      08FH, 090H, 090H, 090H, 090H, 090H, 090H, 08DH, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08FH
        db      08FH, 090H, 090H, 090H, 090H, 090H, 091H, 087H, 090H, 085H, 090H, 090H, 090H, 090H, 090H, 08FH
        db      08FH, 090H, 090H, 090H, 090H, 090H, 090H, 08DH, 090H, 090H, 090H, 090H, 081H, 090H, 090H, 08FH
        db      08FH, 090H, 090H, 090H, 088H, 08CH, 08CH, 08EH, 08CH, 08CH, 08CH, 08CH, 090H, 090H, 090H, 08FH
        db      08FH, 090H, 090H, 090H, 08DH, 090H, 091H, 085H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08FH
        db      08FH, 090H, 090H, 090H, 08DH, 090H, 090H, 08DH, 090H, 090H, 090H, 090H, 092H, 090H, 090H, 08FH
        db      08fH, 090H, 090H, 090H, 08DH, 08FH, 090H, 085H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08FH
        db      08FH, 090H, 090H, 090H, 08AH, 08CH, 08BH, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08fH
        db      08FH, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08fH
        db      08FH, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 090H, 08fH
        db      08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH, 08FH

BOTTOM:

        end