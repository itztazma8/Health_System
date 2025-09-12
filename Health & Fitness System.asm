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
WE DW "Weight: $"
HE DW "Height: $"
ST_W DW "Steps Walked: $"
CAL DW "Daily Calorie Intake: $" 
FT DW " Feet $"
INCH DW " Inch$"

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

MOV CX, 45       
l2:        
MOV AH, 2
MOV DL, "-"
INT 21H
LOOP l2 

SKIP  

;----------------------------------------------------------WEIGHT CALCULATION-----------------------------------------------------------------

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

SKIP   
SKIP

;-------------------------------------------------------HEIGHT CALCULATION--------------------------------------------------------------------

LEA DX, HE
MOV AH, 9
INT 21H

MOV AH, 1
INT 21H

LEA DX, FT
MOV AH, 9
INT 21H

MOV AH, 1
INT 21H
MOV AH, 1
INT 21H

LEA DX, INCH
MOV AH, 9
INT 21H

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
               
MOV AX,4C00H
INT 21H

MAIN ENDP
END MAIN
