function Set-KeePassMasterKey {
    [CmdletBinding()]
    param (
       [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
       [SecureString]$MasterKey = $(Read-Host -Prompt "Enter the master key" -AsSecureString) 
    )

    process {
        if ($MasterKey.Length -eq 0) {
            Write-Error "The master key cannot be empty" -ErrorAction Stop
        }
        
        $masterKeyRegPath =  'HKCU:\SOFTWARE\PoShKeePass'
        if (-not(Test-Path $masterKeyRegPath)) {
            New-Item -Path $masterKeyRegPath -Force | Out-Null
        }
        New-ItemProperty -Path $masterKeyRegPath -PropertyType String -Name 'MasterKey' -Value ($MasterKey | ConvertFrom-SecureString) -Force | Out-Null
        
        Write-Information "Master key has been set successfully" -InformationAction Continue
    }
}