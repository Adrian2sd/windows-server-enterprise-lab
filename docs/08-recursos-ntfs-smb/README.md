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

---

## Guía visual vinculada a las capturas

Esta secuencia relaciona los pasos y decisiones técnicas de la fase con la evidencia obtenida. Las capturas son registros del laboratorio, no instrucciones para copiar configuraciones sin entenderlas.

### 1. Carpetas departamentales

Se estructura el almacenamiento de documentos en SRV01.

![Carpetas departamentales](../../screenshots/08-permisos-ntfs-smb/08-01-carpetas-departamentales.png)

### 2. Grupo local de dominio

Se separa pertenencia departamental de los permisos sobre recursos.

![Grupo local de dominio](../../screenshots/08-permisos-ntfs-smb/08-02-grupo-local-dominio.png)

### 3. Grupos para permisos

Se preparan identidades de autorización para carpetas.

![Grupos para permisos](../../screenshots/08-permisos-ntfs-smb/08-03-grupos-permisos-departamentales.png)

### 4. Relación AGDLP

Se vincula el grupo global de Desarrollo con un grupo local de permisos.

![Relación AGDLP](../../screenshots/08-permisos-ntfs-smb/08-04-agdlp-desarrollo.png)

### 5. Verificación AGDLP

Se comprueba la pertenencia entre grupos.

![Verificación AGDLP](../../screenshots/08-permisos-ntfs-smb/08-05-verificacion-grupos-agdlp.png)

### 6. Herencia NTFS

Se revisan las opciones de herencia del directorio Desarrollo.

![Herencia NTFS](../../screenshots/08-permisos-ntfs-smb/08-06-herencia-ntfs-desarrollo.png)

### 7. Permisos NTFS

Se aplica la autorización correspondiente a la carpeta.

![Permisos NTFS](../../screenshots/08-permisos-ntfs-smb/08-07-permisos-ntfs-desarrollo.png)

### 8. Permisos SMB

Se comprueba la configuración del recurso compartido.

![Permisos SMB](../../screenshots/08-permisos-ntfs-smb/08-09-permisos-smb-departamentos.png)

### 9. Permisos de la raíz

Se analiza el acceso al directorio compartido principal.

![Permisos de la raíz](../../screenshots/08-permisos-ntfs-smb/08-10-permisos-raiz-departamentos.png)

### 10. Acceso autorizado

Se verifica que Desarrollo puede acceder a su carpeta.

![Acceso autorizado](../../screenshots/08-permisos-ntfs-smb/08-11-acceso-desarrollo-permitido.png)

### 11. Escritura autorizada

Se realiza una prueba de modificación de contenido.

![Escritura autorizada](../../screenshots/08-permisos-ntfs-smb/08-12-escritura-desarrollo-permitida.png)

### 12. Acceso denegado

Se documenta que una identidad sin permiso no accede a Finanzas.

![Acceso denegado](../../screenshots/08-permisos-ntfs-smb/08-13-acceso-finanzas-denegado.png)

### 13. Protección de la raíz

Se revisa el endurecimiento del directorio principal.

![Protección de la raíz](../../screenshots/08-permisos-ntfs-smb/08-13-proteccion-carpeta-principal.png)
