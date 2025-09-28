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

;---------------------------------------------------------------TEXT SETUP-------------------------------------------------------------------

MES DW "WELCOME TO YOUR WEEKLY FITNESS REPORT SYSTEM$"
MES1 DW "-------------THIS IS YOUR REPORT--------------$" 
MES2 DW "Calorie Intake Status: $" 
MES3 DW "Calorie Surplus!$"
MES4 DW "Calorie Deficit!$"  
MES5 DW "Efficiency: $"
MES6 DW " %$"      
MES7 DW "BMI: $"   
MES9 DW "BMI Category: $"  
MES10 DW "Underweight!$"
MES11 DW "Doing fine!$"
MES12 DW "Overweight!$"


NO DW "How many entries you want to make? $"  
WE DW "Weight: $"  
WE1 DW "Average Weight: $"

HE DW "Height: $"
ST_W DW "Steps Walked: $"   
DOT DW ".$"  
MILES DW " miles$"
CA DW " calories$"  


CAL DW "Calorie Intake: $" 
FT DW " Feet $"
INCH DW " Inch$"   
RE DW "-------------------$"  
RE1 DW " REPORT $"

;------------------------------------------------------------VARIABLE AND ARRAY SETUP--------------------------------------------------------

WE_CALC DB 7 DUP(0)

AVG DW 1 DUP(0)
HEIGHT DB 1 DUP(0) 
HEIGHT_1 DB 1 DUP(0)   
CONT DW 1 DUP(0)

WEIGHT DW 7 DUP(0) 
STEP DW 7 DUP(0)
CALORIE DW 7 DUP(0)    
     

BURN DW 7 DUP(0)   
EFFICIENCY DW 7 DUP(0)


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



;------------------------------------------------------------HEIGHT SECTION--------------------------------------------------------------------

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

;---------------------------------------------------------HEIGHT CALCULATION-----------------------------------------------------------------

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

MOV DI, 0  



MAINLOOP:

;-----------------------------------------------------------WEIGHT SECTION--------------------------------------------------------------------
 
 
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

MOV SI, 0

limit:
MOV AH, 1
INT 21H
MOV AH, 0
CMP AL, 13
JE end

SUB AL, '0'
MOV WE_CALC[SI], AL
INC SI

JMP limit

end:  

;----------------------------------------------------------WEIGHT CALCULATION----------------------------------------------------------------

MOV SI, 2
CMP WE_CALC[SI], 0
JNE new_calc
 
MOV SI, 0      
MOV AL, WE_CALC[SI] 
MOV AH, 0
MOV BX, 10    
MUL BX

MOV BX, AX

MOV SI, 1
MOV AL, WE_CALC[SI]
MOV AH, 0

ADD BX, AX  

JMP calc_end

new_calc: 

MOV SI, 0      
MOV AL, WE_CALC[SI] 
MOV AH, 0
MOV BX, 100    
MUL BX

MOV BX, AX

MOV SI, 1  
MOV AL, WE_CALC[SI] 
MOV AH, 0
MOV DX, 10    
MUL DX

ADD BX, AX

MOV SI, 2
MOV AL, WE_CALC[SI]
MOV AH, 0

ADD BX, AX 

calc_end:

MOV WEIGHT[DI], BX
 

;---------------------------------------------------------STEPS CALCULATION------------------------------------------------------------------

SKIP
SKIP
LEA DX, ST_W
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
MOV BH, 0

MOV AX, BX
MOV BX, 2000
MUL BX

MOV BX, AX


LEA DX, DOT
MOV AH, 9
INT 21H

MOV AH, 1
INT 21H 

SUB AL, '0' 
MOV AH, 0
MOV DX, 200
MUL DX

ADD BX, AX

MOV STEP[DI], BX

LEA DX, MILES
MOV AH, 9
INT 21H

SKIP
SKIP

;------------------------------------------------------CALORIE CALCULATION--------------------------------------------------------------------

LEA DX, CAL
MOV AH, 9
INT 21H 




MOV AH, 1
INT 21H

SUB AL, '0'
MOV BX, 1000
MOV AH, 0
MUL BX

MOV SI, 0
ADD CONT[SI], DX  
ADD CONT[SI], AX

MOV AH, 1
INT 21H

SUB AL, '0'  
MOV BX, 100
MOV AH, 0
MUL BX


ADD CONT[SI], AX

MOV AH, 1
INT 21H

SUB AL, '0'   
MOV AH, 0
MOV BX, 10
MUL BX

ADD CONT[SI], AX

MOV AH, 1
INT 21H  

SUB AL, '0'
MOV AH, 0

ADD CONT[SI], AX

MOV BX, CONT[SI]
MOV CALORIE[DI], BX


LEA DX, CA
MOV AH, 9
INT 21H

SKIP 
SKIP   

;----------------------------------------------------------------NET BURN CALC---------------------------------------------------------------

MOV AX, STEP[DI]
MOV BX, 4
MUL BX

MOV BX, 100
DIV BX

MOV BX, CALORIE[DI]

ADD AX, 1600

CMP BX, AX
JG GREATER

CMP BX, AX
JLE LESS

GREATER:
MOV BURN[DI], 1

JMP EEE

LESS:

MOV BURN[DI], 2

EEE:   

MOV DX, 100
MUL DX

DIV BX

MOV EFFICIENCY[DI], AX

ADD DI, 2

LOOP MAINLOOP     


;--------------------------------------------------------REPORT GENERATION-------------------------------------------------------------------

  
SKIP 
SKIP
SKIP

MOV AH, 9
LEA DX, MES1
INT 21H 

SKIP
SKIP
SKIP

;------------------------------------------------------------AVERAGE WEIGHT CALCULATION------------------------------------------------------

LEA DX, WE1
MOV AH, 9
INT 21H


MOV CX, 7
MOV DI, 0   

MOV AX, 0
MOV BX, 0 
MOV DL, 0

WE_LOOP:      
MOV BX, WEIGHT[DI]
CMP BX, 0
JE BR1
ADD AX, BX
ADD DL, 1
ADD DI, 2


LOOP WE_LOOP
BR1:  

MOV SI, 0

  
MOV BX, 0
MOV BL, DL
DIV BL


MOV AH, 0
MOV AVG[SI], AX

MOV AH, 0

CMP AX, 100
JL N1
JMP N2

;-------------------------------------------------------------TWO DIGIT AVG------------------------------------------------------------------

N1:
MOV BL, 10
DIV BL

MOV CL, AH
ADD CL, '0'

ADD AL, '0'

MOV AH, 2   
MOV DL, AL
INT 21H

MOV AH, 2
MOV DL, CL
INT 21H

JMP N3

;-----------------------------------------------------------THREE DIGIT AVG------------------------------------------------------------------

N2:

MOV BL, 100  
DIV BL

ADD AL, '0'


MOV DL, AL
MOV AH, 2
INT 21H

MOV AL, AH
MOV AH, 0

MOV BL, 10



DIV BL

MOV CL, AH


ADD AL, '0'


MOV DL, AL
MOV AH, 2   
INT 21H

ADD CL, '0'
MOV DL, CL
MOV AH, 2
INT 21H

N3: 

SKIP
SKIP
;---------------------------------------------------------CALORIE BURN-----------------------------------------------------------------------

LEA DX, MES2
MOV AH, 9 
INT 21H


MOV CX, 7

MOV AX, 0
MOV BX, 0 
MOV SI, 0

BU_LOOP:    
MOV AX, BURN[SI]
CMP AX, 0
JE BU_END   

CMP AX, 1
JE GG    

ADD BL, 1
JMP JK

GG:
ADD BH, 1

JK:
ADD SI, 2

LOOP BU_LOOP


BU_END:

CMP BH, BL
JG SURREN

LEA DX, MES4
MOV AH, 9
INT 21H  

JMP JK1

SURREN:
LEA DX, MES3
MOV AH, 9
INT 21H

JK1: 

SKIP
SKIP
 
;------------------------------------------------------------------EFFICIENCY----------------------------------------------------------------

LEA DX, MES5
MOV AH, 9
INT 21H


MOV CX, 7
MOV SI, 0
MOV DX, 0
MOV BX, 0

EF_LOOP:
MOV AX, EFFICIENCY[SI]  
CMP AX, 0
JE GO1

ADD BX, AX 
ADD DX, 1
ADD SI, 2

LOOP EF_LOOP

GO1:      

MOV AX, BX 
MOV CX, DX
MOV DX, 0

DIV CX




CMP AX, 100
JL N11
JMP N22

;-------------------------------------------------------------TWO DIGIT AVG------------------------------------------------------------------

N11:
MOV BL, 10
DIV BL

MOV CL, AH
ADD CL, '0'

ADD AL, '0'

MOV AH, 2   
MOV DL, AL
INT 21H

MOV AH, 2
MOV DL, CL
INT 21H

JMP N33

;-----------------------------------------------------------THREE DIGIT AVG------------------------------------------------------------------

N22:

MOV BL, 100  
DIV BL

ADD AL, '0'

MOV AH, 2
MOV DL, AL
INT 21H

MOV AL, AH
MOV AH, 0

MOV BL, 10



DIV BL

MOV CL, AH
ADD CL, '0'

ADD AL, '0'

MOV AH, 2   
MOV DL, AL
INT 21H

MOV AH, 2
MOV DL, CL
INT 21H

N33: 

LEA DX, MES6
MOV AH, 9
INT 21H 


SKIP
SKIP  

;-----------------------------------------------------------------HEIGHT---------------------------------------------------------------------
MOV SI, 0

MOV AL, HEIGHT[SI]
MOV AH, 0
MOV BX, 12
MUL BX

MOV BL, HEIGHT_1[SI]
MOV BH, 0
ADD AX, BX  
MOV BX, 254
MUL BX

MOV BX, 1000
DIV BX


;---------------------------------------------------------------BMI SCORE--------------------------------------------------------------------



MOV BX, AX
MUL BX

MOV CX, AX

LEA DX, MES7
MOV AH, 9
INT 21H    

MOV AX, 0
MOV DX, 0
MOV BX, 0

MOV SI, 0
MOV AX, AVG[SI]
MOV BX, 100
MUL BX

DIV CX 

MOV DX, AX

N111:
MOV BL, 10
DIV BL

MOV CL, AH
ADD CL, '0'

ADD AL, '0'

MOV AH, 2   
MOV DL, AL
INT 21H

MOV AH, 2
MOV DL, CL
INT 21H



;---------------------------------------------------------------CATEGORY OF WEIGHT-----------------------------------------------------------
SKIP
SKIP

MOV CX, DX 

LEA DX, MES9
MOV AH, 9
INT 21H

CMP CX, 18
JLE UNDER  

CMP CX, 24
JLE NORMAL  

CMP CX, 24
JG OVER



UNDER:
LEA DX, MES10
MOV AH, 9
INT 21H

JMP BREXIT

NORMAL:
LEA DX, MES11
MOV AH, 10
INT 21H

JMP BREXIT

OVER:
LEA DX, MES12
MOV AH, 9
INT 21H


BREXIT:
             
MOV AX,4C00H
INT 21H  


MAIN ENDP
END MAIN
