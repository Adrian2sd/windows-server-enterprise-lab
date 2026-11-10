# EJEMPLO DIDACTICO, NO EXTRAIDO DE CAPTURAS ORIGINALES.
# Simula un traslado entre departamentos. Ejecutar primero con -WhatIf.
# .\Move-NexoraEmployee.example.ps1 -SamAccountName empleado.prueba -NewDepartment Finanzas -WhatIf
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)][ValidatePattern('^[a-z0-9._-]{3,20}$')][string]$SamAccountName,
    [Parameter(Mandatory)][ValidateSet('Direccion','RecursosHumanos','Finanzas','Desarrollo','SoporteIT')][string]$NewDepartment
)
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory
$groups = @{
    Direccion = 'GG_Direccion'; RecursosHumanos = 'GG_RRHH'
    Finanzas = 'GG_Finanzas'; Desarrollo = 'GG_Desarrollo'
    SoporteIT = 'GG_SoporteIT'
}
$user = Get-ADUser -Identity $SamAccountName -Properties Department,MemberOf
$target = "OU=$NewDepartment,OU=Usuarios,OU=Empresa,DC=nexora,DC=test"
Get-ADOrganizationalUnit -Identity $target | Out-Null
$newGroup = Get-ADGroup -Identity $groups[$NewDepartment]
# Revisar previamente la pertenencia a grupos; NO eliminar otros grupos no departamentales.
$oldDepartment = $user.Department
if ($PSCmdlet.ShouldProcess($user.DistinguishedName, "Mover a $target, actualizar departamento y grupos")) {
    if ($groups.ContainsKey($oldDepartment) -and $oldDepartment -ne $NewDepartment) {
        $oldGroup = Get-ADGroup -Identity $groups[$oldDepartment]
        if ($user.MemberOf -contains $oldGroup.DistinguishedName) {
            Remove-ADGroupMember -Identity $oldGroup -Members $user -Confirm:$false
        }
    }
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $target
    Set-ADUser -Identity $SamAccountName -Department $NewDepartment
    $updated = Get-ADUser -Identity $SamAccountName -Properties MemberOf
    if ($updated.MemberOf -notcontains $newGroup.DistinguishedName) {
        Add-ADGroupMember -Identity $newGroup -Members $SamAccountName
    }
    Get-ADUser -Identity $SamAccountName -Properties Department |
        Select-Object Name,SamAccountName,Department,DistinguishedName
}
