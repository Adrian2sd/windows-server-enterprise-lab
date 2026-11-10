# Windows Server Enterprise Lab

**Portfolio ASIR · Administración de sistemas Windows · Laboratorio virtual aislado**

Proyecto práctico para diseñar, desplegar, administrar y validar la infraestructura informática de **Nexora Solutions**, una empresa ficticia de servicios tecnológicos. El escenario representa cinco departamentos y 60 empleados; el laboratorio utiliza un número reducido de máquinas virtuales para reproducir sus servicios de infraestructura.

> **Estado del repositorio:** documentación y scripts de ejemplo publicados; archivo fotográfico clasificado, **capturas PNG pendientes de carga al repositorio remoto**. Este README diferencia las pruebas documentadas de las ampliaciones previstas. Sistemas heredados para fines educativos; no es una arquitectura recomendada para producción.

## Arquitectura

| Máquina | Sistema | Rol | Red |
|---|---|---|---|
| `DC01` | Windows Server 2016 | Active Directory Domain Services y DNS | `10.20.30.10/24` |
| `SRV01` | Windows Server 2016 | DHCP y servidor de archivos | `10.20.30.20/24` |
| `WIN10-CL01` | Windows 10 Enterprise | Cliente de pruebas y aplicación de GPO | DHCP |

**Dominio** `nexora.test` · **NetBIOS** `NEXORA` · **VirtualBox** `NEXORA-LAN` (red interna).

[Diagrama de arquitectura](diagrams/arquitectura.md) · [Diseño empresarial](docs/01-diseno/README.md) · [Inventario de evidencias](docs/evidencias.md)

## Implementación por fases

| Fase | Objetivo | Documentación |
|---|---|---|
| 02 | Instalar VM, configurar IP y probar conectividad | [Virtualización y red](docs/02-virtualizacion-red/README.md) |
| 03 | Desplegar AD DS, DNS y validar registros SRV | [Active Directory y DNS](docs/03-active-directory-dns/README.md) |
| 04 | Crear OU, usuarios y grupos | [Estructura empresarial](docs/04-ou-usuarios-grupos/README.md) |
| 05 | Unir SRV01 al dominio y configurar DHCP | [Servidor miembro y DHCP](docs/05-servidor-miembro-dhcp/README.md) |
| 06 | Incorporar Windows 10 Enterprise | [Cliente Windows 10](docs/06-cliente-windows10/README.md) |
| 07 | Aplicar y comprobar GPO de usuario y equipo | [GPO](docs/07-gpo/README.md) |
| 08 | Aplicar AGDLP y verificar permisos NTFS/SMB | [Archivos y permisos](docs/08-recursos-ntfs-smb/README.md) |
| 09 | Simular altas, cambios y bajas | [PowerShell](docs/09-powershell-operaciones/README.md) |
| 10 | Revisar resultados e incidencias | [Validación](docs/10-validacion/README.md) |

## Pruebas destacadas

- Comunicación IP bidireccional entre DC01 y SRV01 tras configurar reglas ICMP específicas sin desactivar el firewall.
- Zonas DNS `nexora.test` y `_msdcs.nexora.test` integradas en AD; respuesta SRV `_ldap._tcp.dc._msdcs.nexora.test` hacia `DC01.nexora.test`.
- Evidencias clasificadas de servidor DHCP autorizado, unión de cliente Windows 10, GPO de bloqueo de sesión a 600 segundos y restricciones a usuarios de Desarrollo.
- Casos documentados de permisos permitidos y denegados entre carpetas departamentales.

Los procedimientos incluyen comandos de verificación; **las evidencias por pantalla no sustituyen las pruebas funcionales**. El material fotográfico y el inventario están preparados, pero aún no publicados aquí.

## Incidencias y recuperación

| Caso | Resumen |
|---|---|
| [001 — ICMP entre servidores](docs/troubleshooting/001-icmp-firewall.md) | El ping fallaba por las reglas del firewall; se permitió ICMPv4 para la subred interna |
| [002 — Zonas DNS del primer bosque](docs/troubleshooting/002-dns-zonas.md) | Errores de creación WIN32 123, diagnóstico y recuperación desde instantánea |
| [003 — Incorporación de SRV01](docs/troubleshooting/003-union-srv01.md) | Evidencia de error SID y posterior unión; causa exacta pendiente de documentar |

La primera promoción con `ad.nexora.example` no generó correctamente las zonas DNS. El entorno se recuperó a una instantánea pre-AD DS y se creó `nexora.test`. **No se ha demostrado la causa raíz del error original**.

## Scripts

Los archivos en [`scripts/powershell/`](scripts/powershell/README.md) incluyen **plantillas didácticas**, identificadas explícitamente como ejemplos, para alta y baja lógica. Las capturas de automatizaciones originales no equivalen a disponer de los scripts originales `.ps1`.

## Seguridad y límites

- Laboratorio aislado de redes reales mediante red interna de VirtualBox.
- No publicar credenciales, claves privadas, discos de VM, ISOs ni datos de personas.
- Solo hay un controlador de dominio: **no existe alta disponibilidad**.
- Windows Server 2016 y Windows 10 Enterprise convencional son plataformas heredadas; las prácticas son educativas y no deben trasladarse sin rediseño a una empresa real.

## Pendiente de publicación

Cargar las **101 capturas clasificadas** que acompañan a esta documentación. El inventario y la estructura están preparados para preservar trazabilidad de las pruebas.
