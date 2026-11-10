# EJEMPLO DIDACTICO, NO EXTRAIDO DE LAS CAPTURAS ORIGINALES
# Se ejecuta en un equipo con el modulo ActiveDirectory y permisos delegados.
# Ejemplo de uso:
# .\New-NexoraEmployee.example.ps1 -GivenName Ana -Surname Garcia -SamAccountName ana.garcia -Department Desarrollo -WhatIf
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param(
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][string]$GivenName,
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][string]$Surname,
    [Parameter(Mandatory)][ValidatePattern('^[a-z0-9._-]{3,20}$')][string]$SamAccountName,
    [Parameter(Mandatory)][ValidateSet('Direccion','RecursosHumanos','Finanzas','Desarrollo','SoporteIT')][string]$Department
)
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory
$domain = 'DC=nexora,DC=test'
$ou = "OU=$Department,OU=Usuarios,OU=Empresa,$domain"
$groups = @{
    Direccion='GG_Direccion'; RecursosHumanos='GG_RRHH'; Finanzas='GG_Finanzas'
    Desarrollo='GG_Desarrollo'; SoporteIT='GG_SoporteIT'
}
if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -ErrorAction SilentlyContinue) {
    throw "La cuenta $SamAccountName ya existe."
}
$group = Get-ADGroup -Identity $groups[$Department]
Get-ADOrganizationalUnit -Identity $ou | Out-Null
if ($PSCmdlet.ShouldProcess($SamAccountName, "Crear empleado en $ou y agregar a $($group.Name)")) {
    $password = Read-Host 'Contraseña inicial temporal (no se almacena)' -AsSecureString
    New-ADUser -Name "$GivenName $Surname" -GivenName $GivenName -Surname $Surname `
        -SamAccountName $SamAccountName -UserPrincipalName "$SamAccountName@nexora.test" `
        -Path $ou -Department $Department -AccountPassword $password `
        -ChangePasswordAtLogon $true -Enabled $true
    Add-ADGroupMember -Identity $group -Members $SamAccountName
    Get-ADUser -Identity $SamAccountName -Properties Department,MemberOf |
        Select-Object Name,SamAccountName,Department,Enabled
}
