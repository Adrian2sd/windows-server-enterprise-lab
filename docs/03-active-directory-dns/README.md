# Fase 03 — Active Directory y DNS

## Diseño final

- Primer controlador de dominio: `DC01`.
- Bosque y dominio: `nexora.test`.
- Nombre NetBIOS: `NEXORA`.
- Nivel funcional: Windows Server 2016.
- DNS instalado en el controlador de dominio, con zonas integradas en AD.

## Verificación documentada

Se observó la zona `nexora.test` y la zona `_msdcs.nexora.test`, ambas integradas en Active Directory. La consulta de DNS para `_ldap._tcp.dc._msdcs.nexora.test` devolvió el registro SRV de `DC01.nexora.test` y la dirección `10.20.30.10`.

## Incidencia durante el despliegue

La primera promoción con el nombre `ad.nexora.example` presentó ausencia de zonas DNS y el error `WIN32 123` al crearlas. El dominio se recuperó restaurando la instantánea anterior y creando `nexora.test`. Véase [incidencia DNS](../troubleshooting/002-dns-zonas.md).

## Pendiente

Relacionar las capturas definitivas y adjuntar resultados legibles de `dcdiag` para cerrar la validación de salud del controlador.

---

## Guía visual vinculada a las capturas

Esta secuencia relaciona los pasos y decisiones técnicas de la fase con la evidencia obtenida. Las capturas son registros del laboratorio, no instrucciones para copiar configuraciones sin entenderlas.

### 1. Selección de AD DS

Se añade el rol AD DS en el controlador inicial.

![Selección de AD DS](../../screenshots/03-active-directory-dns/03-01-instalacion-rol-adds.png)

### 2. Rol instalado

El servidor queda listo para iniciar la promoción a controlador de dominio.

![Rol instalado](../../screenshots/03-active-directory-dns/03-02-rol-adds-instalado.png)

### 3. Diseño del bosque inicial

Se documenta el primer intento de bosque, anterior a la recuperación final.

![Diseño del bosque inicial](../../screenshots/03-active-directory-dns/03-03-creacion-bosque.png)

### 4. Opciones del controlador

Se configuran nivel funcional 2016, catálogo global, DNS y DSRM.

![Opciones del controlador](../../screenshots/03-active-directory-dns/03-04-opciones-controlador-dominio.png)

### 5. Nombre NetBIOS

Se utiliza NEXORA como identificador corto del dominio.

![Nombre NetBIOS](../../screenshots/03-active-directory-dns/03-06-nombre-netbios.png)

### 6. Revisión de la primera promoción

Se conserva evidencia histórica de la configuración que presentó la incidencia DNS.

![Revisión de la primera promoción](../../screenshots/03-active-directory-dns/03-08-revision-configuracion-dominio.png)

### 7. Inicio de sesión en dominio

Se comprueba el contexto de autenticación tras la primera promoción.

![Inicio de sesión en dominio](../../screenshots/03-active-directory-dns/03-10-inicio-sesion-dominio.png)

### 8. Consulta de Active Directory

Se revisan datos devueltos por el directorio durante la investigación.

![Consulta de Active Directory](../../screenshots/03-active-directory-dns/03-11-verificacion-active-directory.png)

### 9. Promoción recuperada

Se crea el dominio definitivo nexora.test tras restaurar la instantánea.

![Promoción recuperada](../../screenshots/03-active-directory-dns/03-34-nueva-promocion-dc01.png)

### 10. DNS recuperado

Se verifican zonas integradas y resolución del registro SRV de LDAP.

![DNS recuperado](../../screenshots/03-active-directory-dns/03-35-dns-zonas-srv-funcionando.png)
