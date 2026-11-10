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
