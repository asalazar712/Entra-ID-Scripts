
###############################################################################################
#Version 1
$NewGroupName = "PERM_EXC_E2E_GBL004"
$SourceGroupName = "User_Exclusion_MFA"


new-azureadgroup -displayName $NewGroupName -SecurityEnabled $true -MailEnabled $false -MailNickName "notset"

$NewGroupObjectID = get-azureadgroup -SearchString $NewGroupName | select  -expandproperty objectid 

$GroupObjectID = get-azureadgroup -SearchString $SourceGroupName | select  -expandproperty objectid 

write-host $GroupObjectID

$UserObjects = Get-AzureADGroupMember -ObjectId $GroupObjectID -All $true

foreach ($User in $UserObjects) {
    Add-AzureADGroupMember -ObjectId $NewGroupObjectID -RefObjectId $User.ObjectID
}


###############################################################################################
#Version2

$sourceGroupName = "<SourceGroupName>"
$destinationGroupName = "<DestinationGroupName>"
$sourceGroup = Get-AzureADGroup -SearchString $sourceGroupName
New-AzureADGroup -DisplayName $destinationGroupName -MailEnabled $false -SecurityEnabled $true -MailNickname $destinationGroupName
$destinationGroup = Get-AzureADGroup -SearchString $destinationGroupName
Get-AzureADGroupMember -ObjectId $sourceGroup.ObjectId | ForEach-Object {Add-AzureADGroupMember -ObjectId $destinationGroup.ObjectId -RefObjectId $_.ObjectId}

