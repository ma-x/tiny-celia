100 ' vector table
110 DATA 0,-1, 1,0, 0,1, -1,0
120 ' direction table ( 0:up 1:left 2:down 3:left 9:N/A )
130 ' (next)
140 DATA 1,3,9,9,9,0,0,9
150 DATA 9,2,9,0,1,9,1,9
160 DATA 9,9,1,3,9,2,2,9
170 DATA 2,9,0,9,3,9,3,9
180 ' (bound)
190 DATA 9,9,1,3,9,2,2,9
200 DATA 2,9,0,9,3,9,3,9
210 DATA 1,3,9,9,9,0,9,0
220 DATA 9,2,9,0,1,9,1,9
300 ' stage data: celia(x,y), crystal(x,y,dir)
310 DATA 1,1,2,2,1
1000 ' INIT SCREEN
1010 COLOR 15,1,1:SCREEN 1,0,0:WIDTH 32:KEY OFF:DEF USR=&H9000
1020 DIM VX(3),VY(3):FOR I=0 TO 3:READ VX(I),VY(I):NEXT
1030 DIM ND(31):FOR I=0 TO 31:READ ND(I):NEXT
1040 DIM BD(31):FOR I=0 TO 31:READ BD(I):NEXT
2000 ' DRAW STAGE
2010 CLS:RESTORE 310:READ X,Y,CX,CY,CD:A=USR(0)
3000 ' MAIN
3010 CT=0:W=0:ON INTERVAL=5 GOSUB 4000:INTERVAL ON
3020 PUT SPRITE 0,(8*CX,8*CY-1),5,0:PUT SPRITE 1,(8*X,8*Y-1),13,1
3030 IF W=0 THEN 3030 ELSE W=0
3100 ' CELIA
3110 S=STICK(0) OR STICK(1):IF S=0 OR S MOD 2=0 THEN 3200
3120 S=INT((S-1)/2):TX=X+VX(S):TY=Y+VY(S):V1=&H1800+32*TY+TX:V2=&H1800+32*(TY+VY(S))+TX+VX(S)
3130 C1=VPEEK(V1)
3140 IF C1=&H90 THEN X=TX:Y=TY:GOTO 3200
3150 IF C1>=&H88 THEN 3200
3160 C2=VPEEK(V2)
3170 IF C2<>&H90 AND C2<>&H91 THEN 3200
3180 VPOKE V1,&H90:IF C2=&H90 THEN VPOKE V2,C1 ELSE VPOKE V2,&H90
3190 X=TX:Y=TY:IF CX=TX AND CY=TY THEN CX=TX+VX(S):CY=TY+VY(S):IF C2=&H91 THEN 5000
3200 ' CRYSTAL
3210 CT=CT+1:IF CT=12 THEN CT=0 ELSE 3020
3220 TX=CX+VX(CD):TY=CY+VY(CD):C=VPEEK(&H1800+32*TY+TX)
3230 IF C=&H92 THEN 5000 ELSE IF C>=&H90 THEN 6000
3240 TD=ND(CD*8+C MOD 8)
3250 IF TD<>9 THEN CX=TX:CY=TY:CD=TD ELSE C=VPEEK(&H1800+32*CY+CX):CD=BD(CD*8+C MOD 8):PLAY "t150v15o3c16"
3260 ' END OF MAIN LOOP
3270 GOTO 3020
4000 ' INTERVAL
4010 INTERVAL OFF:W=1:INTERVAL ON:RETURN
5000 ' CLEAR
5010 LOCATE 17,1:PRINT "CLEAR":PLAY "t80v15o4l8cdefg2":GOTO 7000
6000 ' GAME OVER
6010 LOCATE 17,1:PRINT "GAME OVER":PLAY "t80v15o4l8gfedc2":GOTO 7000
7000 ' PUSH TRIGGER
7010 LOCATE 18,3:PRINT "PUSH SPACE":LOCATE 18,4:PRINT "OR TRIGGER"
7020 T=STRIG(0) OR STRIG(1) OR STRIG(3):IF T=0 THEN 7020
7030 GOTO 2000
