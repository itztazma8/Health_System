# Health Report System
The whole system will give the user detailed information about their current state of health. The user must enter their weight, height, calorie intake, and distance covered. The whole system is made using EMU8086, which uses 8086 Assembly Language. The UI (User Interface) will ask the user for the number of entries. Then the following information will be taken. After this, a weekly report will be generated along with suggestions regarding what to do next. The system will also work **dynamically** as the user is not limited to enter a history of 7 days. They can also enter history 3 or 2 days, and so on.  

# UI
<img width="382" height="251" alt="Screenshot 2025-09-14 165324" src="https://github.com/user-attachments/assets/847e47fd-3b4a-4860-8076-5d09c422716a" />

## Weight & Height
The weight range that can be input is from 10-999 kg.  The height will also follow the same format for inches. [1 digit] Feet [2 digit] Inch. 

## Steps
The distance covered will be taken as miles, and the format will be [2 digits].[1 digit after decimal].

## Calorie Intake
The calorie count's range should be of [4 digits] in kcal format. The necessary calculations are done in later steps. The reason fot the different constraints is the **software limiation of the EMU8086 software**. 

# Report 

<img width="371" height="164" alt="image" src="https://github.com/user-attachments/assets/b20c9b0f-1da8-4804-8465-537951794e6f" />

## Average Weight
The first feature is self-explanatory which is the sum of the weights divided by the number of entries.

## Calorie Intake Status
The calorie intake status will track the ratio of calories burned with respect to the amount of calories taken. Either it will be surplus or deficient in amount to make the user known about current dietary habits.

## Efficiency
This shows the actual ratio of calories burned and calories taken for those who are curious. 

## BMI
In terms of BMI, first we consider the **BMR as 1600 calories**. The formula that has been used here is also less precise due to **Hardware Constraints**. The height is rounded down to two digits only. The weight is multiplied by 100 instead of 1000. So the formula is **[Weight X 100 // Height X Height]**.

## BMI Category
Based on the calculations done in the BMI section, the category is mentioned as to make sure the user understands his/her current state of physical health.


**N.B:** The weight calculation does have a minor bug for calculating 3-digit weight. Fix will come soon!





