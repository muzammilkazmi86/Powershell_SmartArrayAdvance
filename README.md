# Purpose

- This program teaches you how you can use FIFO on arrays and then email the result as well as send the output to Slack, if needed.

## Pre-Requisite

- For new users who are running powershell the first time around:
	- Ensure that you have the ability to run powershell scripts
	- If you do not know what i meant, on a machine with admin priveleges, type Powershell in admin mode: Set-ExecutionPolicy -ExecutionPolicy Unrestricted

## Execute
- Run command: .\foodarray_advance.ps1
- Each run toggles the Array value.
- Each run will generate an email to the people you have added in line 123 and 124.
- Each run can be allowed the ability to communicate with a slack webhook. As a bonus this code is available for playing but will need to be uncommented out.

## Sample Output
- First Run Sample
    Item   User   01/17/2022 to 30/27/2022 30/28/2022 to 30/06/2022
    ----   ----   ------------------------ ------------------------
    Item 1 User A Banana                   Apple                   
    Item 2 User B Strawberry               Banana                  
    Item 3 User C Cherry                   Strawberry              
    Item 4 User D Watermelon               Cherry                  
    Item 5 User E pineapple                lemon                   
    Item 6 User F lemon                    Watermelon              
    Item 7 User G Apple                    pineapple               

- Second Run Sample after first run:
    Item   User   01/17/2022 to 35/27/2022 35/28/2022 to 35/06/2022
    ----   ----   ------------------------ ------------------------
    Item 1 User A Strawberry               Banana                  
    Item 2 User B Cherry                   Strawberry              
    Item 3 User C Watermelon               Cherry                  
    Item 4 User D pineapple                lemon                   
    Item 5 User E lemon                    Watermelon              
    Item 6 User F Apple                    pineapple               
    Item 7 User G Banana                   Apple                 
