# Ensure TLS is allowed
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
# Toggle Array Play
# This code is an advanced version of FIFO. 
# We have 7 food items which we will toggle between users. These users will eat those items from a certain date to a certain date.
# This code helps to interact with Slack and allows to send an email as well.
# This code can be executed as a scheduled task


# Declare Date
$DAY = (get-date).Date

# Declare Empty Arrays
$FoodArray1 = @()
$FoodArray2 = @()
$newfoodarr = @()
$newfoodarr2 = @()


$FoodArray1 = @(Get-Content ".\foodarray1.txt")
Clear-Content .\oldfoodarray1.txt
Clear-Content .\oldfoodarray2.txt

foreach($itm1 in $FoodArray1)
{Add-Content .\oldfoodarray1.txt "$itm1"
}
$FoodArray2 =@(Get-Content ".\foodarray2.txt")

foreach ($itm2 in $FoodArray2)
{
Add-Content .\oldfoodarray2.txt "$itm2"
}

$first30, $rest30 = $FoodArray2
$first15, $rest= $FoodArray1

$newfoodarr = @($FoodArray1[1],$FoodArray1[2],$FoodArray1[3],$FoodArray1[4],$FoodArray1[5],$FoodArray1[6],$first15)
$newfoodarr2 = @($FoodArray2[1],$FoodArray2[2],$FoodArray2[3],$FoodArray2[4],$FoodArray2[5],$FoodArray2[6],$first30)


$temp11 = $FoodArray1[0]
$Temp21 = $FoodArray1[1]
$Temp31 = $FoodArray1[2]
$Temp41 = $FoodArray1[3]
$Temp51 = $FoodArray1[4]
$Temp61 = $FoodArray1[5]
$Temp71 = $FoodArray1[6]

$Temp12 = $FoodArray2[0]
$Temp22 = $FoodArray2[1]
$Temp32 = $FoodArray2[2]
$Temp42 = $FoodArray2[3]
$Temp52 = $FoodArray2[4]
$Temp62 = $FoodArray2[5]
$Temp72 = $FoodArray2[6]

$fdate = Get-Date -Format MM/dd/yyyy
$tdate = "{0:mm/dd/yyyy}" -f (Get-Date).AddDays(10)
$fdate2 = "{0:mm/dd/yyyy}" -f (Get-Date).AddDays(11)
$tdate2 = "{0:mm/dd/yyyy}" -f (Get-Date).AddDays(20)

$tableoutput = @()
$d = "$fdate to $tdate"
$d2 = "$fdate2 to $tdate2"

$tableoutput += [pscustomobject]@{Item = "Item 1"; User = "User A"; $d = "$temp11"; $d2 = "$temp12"}
$tableoutput += [pscustomobject]@{Item = "Item 2"; User = "User B"; $d = "$temp21"; $d2 = "$temp22"}
$tableoutput += [pscustomobject]@{Item = "Item 3"; User = "User C"; $d = "$temp31"; $d2 = "$temp32"}
$tableoutput += [pscustomobject]@{Item = "Item 4"; User = "User D"; $d = "$temp41"; $d2 = "$temp42"}
$tableoutput += [pscustomobject]@{Item = "Item 5"; User = "User E"; $d = "$temp51"; $d2 = "$temp52"}
$tableoutput += [pscustomobject]@{Item = "Item 6"; User = "User F"; $d = "$temp61"; $d2 = "$temp62"}
$tableoutput += [pscustomobject]@{Item = "Item 7"; User = "User G"; $d = "$temp71"; $d2 = "$temp72"}



            
$text = "| Item | User | $fdate to $tdate | $fdate2 to $tdate2 |
| :--------------- | :---------------| :---------------| :---------------|
|Item 1 | User A | ` $Temp11 | ` $Temp12 |
|Item 2 | User B | ` $Temp21 | ` $Temp22 |
|Item 3 | User C | ` $Temp31 | ` $Temp32 |
|Item 4 | User D | ` $Temp41 | ` $Temp42 |
|Item 5 | User E | ` $Temp51 | ` $Temp52 |
|Item 6 | User F | ` $Temp61 | ` $Temp62 |
|Item 7 | User G | ` $Temp71 | ` $Temp72 |"


############################
# How to Send an email out
$style = @"
<style>
BODY{font-family:Calibri;font-size:12pt;}
TABLE{border-width: 1px;border-style: solid;border-color:black;border-collapse: collapse; padding-right:5px}
TH{border-width: 1px;pading: 5px;border-style: solid; border-color:black;color:black;background-color:#FFFFFF }
TH{border-width: 1px;pading: 5px;border-style: solid; border-color:black;background-color:green}
TH{border-width: 1px;pading: 5px;border-style: solid; border-color:black}
</style>
"@


#### How to send to Slack Bot
#$Webhook = "place the URL here"
#$UserProfile = "I am a bot"
#$payload = @{text= $text; username=$UserProfile}
invoke-restmethod -Uri $Webhook -Method Post -ContentType 'application/json' -Body (ConvertTo-Json $payload)
####


# Send your data with an email
$emailres = @(
@{Item="Item 1"; User="User A";$d=$Temp11;$d2 =$Temp12},
@{Item ="Item 2"; User="User B";$d=$Temp21;$d2 =$Temp22},
@{Item ="Item 3"; User="User C";$d=$Temp31;$d2 =$Temp32},
@{Item ="Item 4"; User="User D";$d=$Temp41;$d2 =$Temp42},
@{Item ="Item 5"; User="User E";$d=$Temp51;$d2 =$Temp52},
@{Item ="Item 6"; User="User F";$d=$Temp61;$d2 =$Temp62},
@{Item ="Item 7"; User="User G";$d=$Temp71;$d2 =$Temp72}) | % {New-Object object | Add-Member -NotePropertyMembers $_ -PassThru}
$emailres = $emailres | select Item, user, $d, $d2
$emailres | convertto-Html -Body "<H2> Fruits Dedicated Monthly Chart </H2>" -Head $style | out-file -filepath .\res.txt


$body = [System.IO.File]::ReadAllText(".\res.txt")
$From = "blablabla@blabla.com"
$to = "blablabla@blabla.com"
$subject = "Fruits Monthly Dedicated Chart"
$smtpServer = "abcd.abcd.com"

$mailmessage = @{
To = $to,$toadd
From = $from
Subject = $subject
Body = "$Body"
# Priority = "High"
smtpserver = $smtpServer
ErrorAction = "silentlycontinue"
}
Send-MailMessage @mailmessage -BodyAsHtml

# Empty Array Out
Clear-Content .\foodarray1.txt

foreach($inventory1 in $newfoodarr)
{
Add-Content .\foodarray1.txt "$inventory1"
}

# Empty Array Out
Clear-Content .\foodarray2.txt

foreach($inventory2 in $newfoodarr2)
{
Add-Content .\foodarray2.txt "$inventory2"
}

