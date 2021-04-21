Connect-MicrosoftTeams
$credential = Get-Credential

$PSEmailServer =  #MX endpoint for domain addresses
$SMTPport = 25 #does not work on other SMTP ports
$sendEmail = 'user <email@domain.com>' #change this to your account


#add if statement to check datetime to execute process

$teams = Get-Team

foreach ($team in $teams) {

$teamName = $team.DisplayName

$subject = "Data Owner Report for $teamName" 

$body = "This is an automated message, please do not reply directly`n`n`n$teamName`n--------------------------------------`nOwners:`n"

$owners = Get-TeamUser -GroupId $team.GroupId -Role Owner; 

foreach ($owner in $owners) { 

$name = $owner.Name

$email = $owner.User

$body += "$name`t$email`n"

#clean up later when I understand powershell strings

} 

$body += "`nMembers:`n"; 

$members = Get-TeamUser -GroupId $team.GroupId -Role Member; 

foreach ($member in $members){ 

$name = $member.Name

$email = $member.User

$body += "$name`t$email`n"

#clean these up later

} 

$body += "`n`n`n`tIf you see a member listed here that should no longer have access to your team's files, please remove them. If you wish to remove an entire team please archive your team. A succinct guide on how to manage your
Microsoft Teams is available here:
`nhttps://support.microsoft.com/en-us/office/go-to-guide-for-team-owners-92d238e6-0ae2-447e-af90-40b1052c4547?ui=en-us&rs=en-us&ad=us#:~:text=1%20In%20the%20teams%20list%2C%20go%20to%20the,the%20person%20you%27d%20like%20to%20remove.%20See%20More
`n`nYou can view up to date information about your team anytime through that panel."

Write-Host $subject $body #testing, comment this whole line out in production

#comment out this entire for loop for testing below
#foreach($owner in $owners) {
#$recieveEmail = $owner.User
#Send-MailMessage -From ($sendEmail) -To $recieveEmail -Subject $subject -Body $body -UseSsl -SmtpServer $PSEmailServer -Port $SMTPport
#}
  

} 

