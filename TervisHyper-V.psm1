function Find-VMSNeedingVMVersionUpgrade {
    $nodes = Get-ClusterNode -Cluster hypervcluster5 | select -ExpandProperty Name 
    foreach ($node in $nodes) {
        $updated += Get-VM -ComputerName $Node | where version -ne '8.0' | where state -eq running
    }
    $updated | Sort Name
    $updated | measure | Select Count 
}

function Update-VMSNeedingVMVersionUpgrade {
    $nodes = Get-ClusterNode -Cluster hypervcluster5 | select -ExpandProperty Name
    foreach ($node in $nodes) {
        Get-VM -ComputerName $Node | Where State -eq Off | where version -ne '8.0' | Update-VMVersion -Confirm:$false
    }
}