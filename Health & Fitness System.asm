.MODEL SMALL    

;-----------------------------------------------------------MACRO-1: LINE SKIP----------------------------------------------------------------

SKIP MACRO
    MOV AH, 2
    MOV DL, 10
    INT 21H
    MOV AH, 2
    MOV DL, 13
    INT 21H
ENDM
 
.STACK 100H

.DATA

MES DW "WELCOME TO YOUR WEEKLY FITNESS REPORT SYSTEM$"  
NO DW "How many entries you want to make? $"  
WE DW "Weight: $"
HE DW "Height: $"
ST_W DW "Steps Walked: $"
CAL DW "Daily Calorie Intake: $" 
FT DW " Feet $"
INCH DW " Inch$"   
RE DW "-------------------$"  
RE1 DW " REPORT $"


WEIGHT DW 7 DUP(0) 

HEIGHT DB 1 DUP(0) 
HEIGHT_1 DB 1 DUP(0) 

STEP DW 7 DUP(0)
CALORIE DW 7 DUP(0)


.CODE
MAIN PROC

MOV AX,@DATA
MOV DS,AX    



;--------------------------------------------------------------------UI-----------------------------------------------------------------------
MOV CX, 45       
l1:        
MOV AH, 2
MOV DL, "-"
INT 21H
LOOP l1 
  
SKIP 
SKIP
SKIP

MOV AH, 9
LEA DX, MES
INT 21H 

SKIP
SKIP
SKIP

MOV CX, 46       
l2:        
MOV AH, 2
MOV DL, "-"
INT 21H
LOOP l2 

SKIP 
SKIP  



;----------------------------------------------------------HEIGHT CALCULATION-----------------------------------------------------------------

MOV SI, 0

LEA DX, HE
MOV AH, 9
INT 21H

MOV AH, 1
INT 21H

SUB AL, '0'  

MOV HEIGHT[SI], AL

LEA DX, FT
MOV AH, 9
INT 21H

MOV AH, 1
INT 21H 

SUB AL, '0'

MOV BL, 10
MUL BL
MOV BL, AL

MOV AH, 1
INT 21H

SUB AL, '0'
ADD BL, AL 

MOV HEIGHT_1[SI], BL

LEA DX, INCH
MOV AH, 9
INT 21H  

SKIP
SKIP     


LEA DX, NO 
MOV AH, 9
INT 21H
SKIP

MOV AH, 1
INT 21H

SUB AL, '0'
MOV CL, AL

MOV CH, 0

SKIP
SKIP  

MOV SI, 0

MAINLOOP:

;-------------------------------------------------------WEIGHT CALCULATION--------------------------------------------------------------------
 
 
LEA DX, RE
MOV AH, 9
INT 21H

LEA DX, RE1
MOV AH, 9
INT 21H    

LEA DX, RE
MOV AH, 9
INT 21H

SKIP
SKIP

LEA DX, WE
MOV AH, 9
INT 21H


limit:
MOV AH, 1
INT 21H
MOV AH, 0
CMP AL, 13
JE end

JMP limit

end: 


;---------------------------------------------------------STEPS CALCULATION------------------------------------------------------------------

SKIP
SKIP
LEA DX, ST_W
MOV AH, 9
INT 21H

SKIP
SKIP

;------------------------------------------------------CALORIE CALCULATION--------------------------------------------------------------------

LEA DX, CAL
MOV AH, 9
INT 21H 

SKIP 
SKIP

LOOP MAINLOOP
             
MOV AX,4C00H
INT 21H

MAIN ENDP
END MAIN
