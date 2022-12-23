# Import the Active Directory module
Import-Module ActiveDirectory

# Set the domain name
$domainName = "example.com"

# Set the server hostname
$serverHostname = "DC1"

# Set the IP address of the DNS server
$dnsServerIP = "192.168.1.1"

# Set the IP address of the default gateway
$defaultGatewayIP = "192.168.1.1"

# Set the IP address of the primary DNS server
$primaryDnsIP = "192.168.1.1"

# Set the IP address of the secondary DNS server
$secondaryDnsIP = "192.168.1.2"

# Set the IP address of the network adapter
$networkAdapterIP = "192.168.1.10"

# Set the subnet mask of the network adapter
$subnetMask = "255.255.255.0"

# Set the name of the administrator account
$adminUsername = "Administrator"

# Set the password of the administrator account
$adminPassword = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

# Set the name of the organizational unit (OU) to create
$ouName = "MyOrganizationalUnit"

# Set the name of the user to create
$userName = "JohnDoe"

# Set the password of the user to create
$userPassword = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

# Set the name of the group to create
$groupName = "MyGroup"

# Create a new domain in a new forest
New-ADForest -Name $domainName -DomainMode "Win2012R2" -ForestMode "Win2012R2"

# Promote the current server to a domain controller
Install-ADDSDomainController -DomainName $domainName -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -LogPath "C:\Windows\NTDS" -SysvolPath "C:\Windows\SYSVOL" -InstallDns:$true

# Set the hostname of the server
Rename-Computer -NewName $serverHostname -Restart

# Set the IP address, subnet mask, and default gateway of the network adapter
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $networkAdapterIP -PrefixLength $subnetMask -DefaultGateway $defaultGatewayIP

# Set the DNS servers for the network adapter
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $primaryDnsIP,$secondaryDnsIP

# Set the domain and DNS search suffixes for the network adapter
Set-DnsClientGlobalSetting -SuffixSearchList $domainName

# Set the domain and DNS search suffixes for the network adapter
Set-DnsClientGlobalSetting -ConnectionSpecificSuffixSearchList $domainName

# Wait for AD DS to be initialized
Start-Sleep -Seconds 60

# Set the password for the administrator account
Set-ADAccountPassword -Identity $adminUsername -NewPassword $adminPassword

# Create a new organizational unit (OU)
New-ADOrganizationalUnit -Name $
