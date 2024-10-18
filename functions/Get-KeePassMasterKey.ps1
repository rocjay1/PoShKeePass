function Get-KeePassMasterKey {
    [CmdletBinding()]
    param ()

    process {
        $masterKeyRegPath =  'HKCU:\SOFTWARE\PoShKeePass'
        
        $regMasterKey = Get-ItemProperty -Path $masterKeyRegPath -Name 'MasterKey' -ErrorAction SilentlyContinue
        if ($regMasterKey) {
            Write-Output ($regMasterKey.MasterKey | ConvertTo-SecureString)
        } else {
            Write-Error "The master key has not been set" -ErrorAction Stop
        }
    }
}