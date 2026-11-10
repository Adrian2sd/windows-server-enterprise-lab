# EJEMPLO DIDACTICO. Revisar y adaptar antes de usar en el laboratorio.
# Este script no borra cuentas: deshabilita la cuenta y la mueve a una OU de bajas EXISTENTE.
# Ejemplo: .\Disable-NexoraEmployee.example.ps1 -SamAccountName usuario.prueba -WhatIf
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)][ValidatePattern('^[a-z0-9._-]{3,20}$')][string]$SamAccountName
)
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory
$target = 'OU=Bajas,OU=Usuarios,OU=Empresa,DC=nexora,DC=test'
$user = Get-ADUser -Identity $SamAccountName
Get-ADOrganizationalUnit -Identity $target | Out-Null
if ($PSCmdlet.ShouldProcess($user.DistinguishedName, "Deshabilitar y mover a $target")) {
    Disable-ADAccount -Identity $user
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $target
    Get-ADUser -Identity $SamAccountName | Select-Object Name,Enabled,DistinguishedName
}
# Retirada de permisos y sesiones activas: revisar por separado con procedimientos aprobados.
