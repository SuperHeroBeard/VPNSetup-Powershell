$Status = Get-VpnConnection -Name $vpnname 
function VPNCreation {
    Add-VpnConnection -Name (Read-Host -Prompt "Enter Company Name") -ServerAddress (Read-Host -Prompt "Enter Router or domain address") -TunnelType "l2tp" -L2tpPsk (Read-Host -Prompt "Enter L2TP Password") -EncryptionLevel "Required" -AuthenticationMethod MSChapv2 -SplitTunneling -PassThru
}
VPNCreation

function ConnectVPN {
$vpnName = Read-Host -Prompt "Enter VPN Name"
$vpn = Get-VpnConnection -Name $vpnName;
if($vpn.ConnectionStatus -eq "Disconnected"){
rasdial $vpnName (Read-Host -Prompt "Enter VPN Username") (Read-Host -Prompt "Enter Password")
}
}
ConnectVPN

