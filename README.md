# Health Report System
The whole system will give the user detailed information about their current state of health. The user must enter their weight, height, calorie intake, and distance covered. The whole system is made using EMU8086, which uses 8086 Assembly Language. The UI (User Interface) will ask the user for the number of entries. Then the following information will be taken. After this, a weekly report will be generated along with suggestions regarding of what do next. 

# UI
<img width="382" height="251" alt="Screenshot 2025-09-14 165324" src="https://github.com/user-attachments/assets/847e47fd-3b4a-4860-8076-5d09c422716a" />

## Weight & Height
The weight range that can be input is from 10-999 kg.  The height will also follow the same format for inches. [1 digit] Feet [2 digit] Inch. 

## Steps
The distance covered will be taken as miles, and the format will be [2 digits].[1 digit after decimal].

## Calorie Intake
The calorie count's range should be of [4 digits] in kcal format. The necessary calculations are done in later steps. The reason fot the different constraints is the **software limiation of the EMU8086 software**. 



