# Fase 08 — Carpetas compartidas, NTFS y SMB

## Objetivo

Centralizar documentación por departamento en `SRV01` y aplicar permisos de acceso de forma mantenible.

## Modelo AGDLP

**A**ccounts → **G**lobal Groups → **D**omain **L**ocal Groups → **P**ermissions.

Ejemplo de Desarrollo:

1. Usuario en `GG_Desarrollo`.
2. `GG_Desarrollo` se incorpora al grupo local de dominio autorizado sobre el recurso.
3. Los permisos NTFS se asignan al grupo local de dominio, no usuario a usuario.

Esto facilita las altas, bajas y cambios de departamento.

## Comprobaciones

```powershell
# Revisar autorizaciones en una carpeta de prueba (ajustar ruta real):
Get-Acl 'C:\Compartidos\Desarrollo' | Format-List
# Revisar recursos SMB existentes:
Get-SmbShare | Select-Object Name, Path
Get-SmbShareAccess -Name 'Departamentos'
```

**Importante:** la ruta y el nombre del recurso en estos comandos son ejemplos de inspección y deben ajustarse a la configuración efectiva de SRV01.

## Pruebas funcionales

Se documenta acceso permitido y escritura permitida a documentación de Desarrollo, y acceso denegado a Finanzas desde una cuenta no autorizada. Las capturas corresponden a configuración de herencia, NTFS, grupos de permisos y pruebas positivas/negativas.

No basta con que una carpeta sea visible a través de SMB: el acceso efectivo resulta de la combinación de permisos SMB y NTFS. Validar la identidad usada en cada prueba.
