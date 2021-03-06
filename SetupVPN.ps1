function VPNCreation {
    Add-VpnConnection -Name (Read-Host -Prompt "Enter Company Name") -ServerAddress (Read-Host -Prompt "Enter Router or domain address") -TunnelType "l2tp" -L2tpPsk (Read-Host -Prompt "Enter L2TP Password") -EncryptionLevel "Required" -AuthenticationMethod MSChapv2 -SplitTunneling -PassThru
}
VPNCreation

$VPNConnection = Get-VpnConnection | Select-Object
function VPNTunnel {
    Add-VPNConnectionRoute -ConnectionName $VPNConnection.Name -DestinationPrefix (Read-Host -Prompt "Enter Subnet Prefix i.e 10.10.0.0/24")
}
VPNTunnel

function ConnectVPN {
$vpnName = $VPNConnection.Name
$vpn = Get-VpnConnection -Name $vpnName;
if($vpn.ConnectionStatus -eq "Disconnected"){
rasdial $vpnName (Read-Host -Prompt "Enter VPN Username") (Read-Host -Prompt "Enter Password")
}
}
ConnectVPN

function DomainSetup {
    param (
        $DomainSetup = Read-Host -Prompt "Do you want to add this device to a domain?"
        if ($DomainSetup -eq [Yy]) {

            Add-Computer -DomainName (Read-Host -Prompt "Enter Domain Name") -DomainCredential (Read-Host -Prompt "Enter Domain Username")
            
        }
        DomainSetup
    )
    
}