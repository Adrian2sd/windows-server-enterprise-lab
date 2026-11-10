# Inventario y estado de las evidencias

Las 104 capturas originales se recibieron en el archivo `capturas.zip`. Se preparó una selección clasificada de **101 PNG**: 87 evidencias principales y 14 imágenes de diagnóstico/incidencias. Tres capturas quedaron en reserva o se descartaron como duplicadas.

**Estado en GitHub:** las **101 capturas PNG están publicadas** en `screenshots/`. Las imágenes de cada fase se enlazan desde sus documentos y las de diagnóstico desde las incidencias.

| Directorio | Imágenes preparadas | Alcance |
|---|---:|---|
| `screenshots/02-virtualizacion-red/` | 8 | Instalación, direccionamiento, firewall, conectividad, instantánea |
| `screenshots/03-active-directory-dns/` | 10 | AD DS, promoción, bosque definitivo, DNS |
| `screenshots/04-usuarios-ou-grupos/` | 14 | OU, grupos, cuentas y pertenencias |
| `screenshots/05-dhcp-servidor-miembro/` | 11 | Servidor miembro, canal seguro, DHCP |
| `screenshots/06-windows10-cliente/` | 6 | DHCP, DNS, unión y sesión cliente |
| `screenshots/07-gpo/` | 8 | Políticas, gpresult y restricciones |
| `screenshots/08-permisos-ntfs-smb/` | 13 | AGDLP, recursos compartidos, permisos y acceso |
| `screenshots/09-powershell-casos/` | 8 | Altas, cambios y bajas |
| `screenshots/10-validacion/` | 9 | Evidencias de validación de servicios |
| `screenshots/troubleshooting/` | 14 | Diagnóstico de errores DNS y otros problemas |
| **Total** | **101** | |

## Criterios de selección

- Mantener la evidencia que demuestre una configuración concreta y otra que muestre el resultado.
- Conservar errores relevantes en `troubleshooting`, sin presentarlos como configuraciones finales.
- No afirmar que un comando se ejecutó si solo aparece el código fuente en una captura.
- Revisar información sensible antes de publicar imágenes o scripts.
- Evitar imágenes repetidas, recortes poco legibles y datos locales personales.

## Índice de documentación

- [Virtualización y red](02-virtualizacion-red/README.md)
- [AD DS y DNS](03-active-directory-dns/README.md)
- [OU, usuarios y grupos](04-ou-usuarios-grupos/README.md)
- [Servidor miembro y DHCP](05-servidor-miembro-dhcp/README.md)
- [Windows 10](06-cliente-windows10/README.md)
- [GPO](07-gpo/README.md)
- [NTFS y SMB](08-recursos-ntfs-smb/README.md)
- [PowerShell](09-powershell-operaciones/README.md)
- [Validación](10-validacion/README.md)
- [Incidencias](troubleshooting/001-icmp-firewall.md)

> Este inventario facilita la revisión de las evidencias; no es una certificación de que todas las pruebas estén validadas en un entorno productivo.
