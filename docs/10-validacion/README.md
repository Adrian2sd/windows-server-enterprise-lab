# Fase 10 — Validación del laboratorio

## Objetivo

Confirmar los servicios mediante pruebas reproducibles, con capturas de resultados y anotación de incidencias.

| Área | Verificación recomendada | Evidencias disponibles |
|---|---|---|
| AD DS | `Get-ADDomain`, `dcdiag` | Validación AD (2 capturas) |
| DNS | `Get-DnsServerZone`, `Resolve-DnsName` registro A/SRV | Zonas y registros |
| DHCP | `Get-DhcpServerv4Scope`, cliente `ipconfig /all` | Validación DHCP |
| GPO equipo | `gpresult /r` y bloqueo de sesión | Política 600 s |
| GPO usuario | `gpresult /r` y restricción Panel de control | Política de usuario |
| SMB/NTFS | Acceso permitido y denegado con usuarios distintos | Capturas en fase 08 |

## Criterio de aceptación

Una fase está validada cuando se registra **configuración + comando o procedimiento de prueba + resultado esperado + resultado observado**. La presencia de las imágenes no reemplaza la descripción de los comandos ni la revisión del resultado real.

## Limitaciones

- El proyecto es un laboratorio educativo aislado.
- No se ha implementado alta disponibilidad ni redundancia de controladores de dominio.
- Los sistemas operativos pertenecen a generaciones anteriores y no deben presentarse como arquitectura recomendada de producción.
