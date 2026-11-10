# Windows Server Enterprise Lab

> **Estado:** proyecto de portfolio en documentación. Laboratorio educativo aislado en VirtualBox con Windows Server 2016 y Windows 10 Enterprise. Estas versiones no se recomiendan para nuevos despliegues de producción.

## Objetivo

Construir y documentar la infraestructura Windows de **Nexora Solutions**, una empresa ficticia con cinco departamentos. El laboratorio abarca administración de identidades, DNS, DHCP, directivas de grupo, recursos compartidos, permisos NTFS y PowerShell.

## Arquitectura

| Equipo | Sistema operativo | Función | Dirección |
|---|---|---|---|
| `DC01` | Windows Server 2016 | AD DS, DNS | `10.20.30.10/24` |
| `SRV01` | Windows Server 2016 | DHCP, archivos, servidor miembro | `10.20.30.20/24` |
| `WIN10-CL01` | Windows 10 Enterprise | Cliente de pruebas del dominio | DHCP |

**Dominio:** `nexora.test` · **NetBIOS:** `NEXORA` · **Red VirtualBox:** `NEXORA-LAN` (red interna aislada).

## Fases documentadas con capturas

1. Virtualización, red aislada y conectividad.
2. Promoción a controlador de dominio y resolución DNS.
3. Unidades organizativas, usuarios y grupos.
4. Servidor miembro y configuración DHCP.
5. Unión de Windows 10 Enterprise al dominio.
6. Aplicación de GPO.
7. Carpetas compartidas, permisos NTFS y SMB.
8. Automatización y casos de administración con PowerShell.
9. Validación de servicios.

Las capturas están en proceso de selección y clasificación. **La existencia de una captura no sustituye a una prueba reproducible**: incorporaremos procedimientos de verificación por fase y los scripts `.ps1` originales cuando estén revisados.

## Incidencia: creación del dominio y DNS

La promoción inicial del bosque `ad.nexora.example` produjo ausencia de zonas DNS y errores `WIN32 123` al intentar crearlas. Se investigaron eventos del servicio DNS (incluido el 4013), particiones de Active Directory y distintas pruebas de creación de zonas. Tras restaurar una instantánea anterior a AD DS se creó el bosque `nexora.test`, donde se verificaron zonas integradas en AD y registros SRV.

**La causa raíz del fallo original no quedó demostrada.** Documentaremos el síntoma, las pruebas, la decisión de recuperación y la validación final sin atribuir una causa no comprobada.

## Seguridad y alcance

Laboratorio aislado de redes domésticas y servicios reales. No publicar credenciales, secretos, discos virtuales, copias de seguridad ni información privada. La infraestructura representa un entorno de aprendizaje de tecnologías heredadas, no una referencia de despliegue productivo moderno.

## Pendiente

- Incorporar capturas seleccionadas, ordenadas por fase.
- Redactar los procedimientos y resultados verificables.
- Incorporar scripts PowerShell revisados.
- Añadir diagrama y matriz de permisos.
