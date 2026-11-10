# Fase 05 — Servidor miembro y DHCP

## Objetivo

Integrar `SRV01` en el dominio `nexora.test` y centralizar la entrega de parámetros IP mediante DHCP.

## Diseño

- Controlador de dominio/DNS: `DC01` (`10.20.30.10`).
- Servidor DHCP: `SRV01` (`10.20.30.20`).
- Subred: `10.20.30.0/24`.
- Rango DHCP previsto en el diseño: `10.20.30.100`–`10.20.30.199`.
- DNS que deben recibir los clientes: `10.20.30.10`.
- Sufijo DNS corporativo: `nexora.test`.
- Sin puerta de enlace si se mantiene la red interna aislada y no hay router.

**No configurar otro DHCP** en el mismo segmento (por ejemplo, uno del hipervisor): puede interferir con el ámbito corporativo.

## Procedimiento y pruebas

Las capturas disponibles muestran resolución DNS desde SRV01, proceso de unión al dominio, una incidencia de SID, canal seguro, ubicación en OU, instalación y autorización del rol DHCP y creación/validación de ámbito.

```powershell
# Desde SRV01, tras unirlo al dominio:
Test-ComputerSecureChannel
Get-DhcpServerInDC

# En SRV01, para inspeccionar la configuración:
Get-DhcpServerv4Scope
Get-DhcpServerv4OptionValue -ScopeId 10.20.30.0
Get-DhcpServerv4Lease -ScopeId 10.20.30.0
```

Los nombres, el intervalo efectivo y las opciones DHCP deben cotejarse con el sistema y las capturas antes de convertir esta configuración prevista en especificación definitiva.

## Seguridad

La autorización DHCP en Active Directory evita que un servidor DHCP Windows no autorizado reparta direcciones dentro del dominio. La autorización no sustituye al aislamiento de red.

## Incidencia

Existe evidencia de un error SID durante la unión de SRV01 y de su posterior incorporación correcta. Se documenta como incidencia diferenciada en [troubleshooting](../troubleshooting/003-union-srv01.md).
