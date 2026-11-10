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

---

## Guía visual vinculada a las capturas

Esta secuencia relaciona los pasos y decisiones técnicas de la fase con la evidencia obtenida. Las capturas son registros del laboratorio, no instrucciones para copiar configuraciones sin entenderlas.

### 1. Resolución DNS del servidor miembro

Antes de unir SRV01, se comprueba que localiza los servicios del dominio.

![Resolución DNS del servidor miembro](../../screenshots/05-dhcp-servidor-miembro/05-01-srv01-resolucion-dns.png)

### 2. SRV01 unido a dominio

Se evidencia la incorporación del servidor miembro a nexora.test.

![SRV01 unido a dominio](../../screenshots/05-dhcp-servidor-miembro/05-06-srv01-unido-dominio.png)

### 3. Canal seguro

Se comprueba el canal de confianza del equipo con AD DS.

![Canal seguro](../../screenshots/05-dhcp-servidor-miembro/05-07-canal-seguro-srv01.png)

### 4. OU de servidores

SRV01 se organiza en el contenedor de servidores miembros.

![OU de servidores](../../screenshots/05-dhcp-servidor-miembro/05-08-srv01-ou-servidores.png)

### 5. Selección del rol DHCP

Se instala DHCP en SRV01, no en el controlador.

![Selección del rol DHCP](../../screenshots/05-dhcp-servidor-miembro/05-09-rol-dhcp-srv01.png)

### 6. Instalación de DHCP

Se comprueba el resultado de instalación del servicio.

![Instalación de DHCP](../../screenshots/05-dhcp-servidor-miembro/05-10-dhcp-instalado.png)

### 7. Servidor DHCP operativo

Se presenta la consola de DHCP configurada.

![Servidor DHCP operativo](../../screenshots/05-dhcp-servidor-miembro/05-13-dhcp-srv01-instalado.png)

### 8. Autorización en AD

Se autoriza el servidor DHCP para operar en el dominio.

![Autorización en AD](../../screenshots/05-dhcp-servidor-miembro/05-14-dhcp-autorizado-ad.png)

### 9. Validación de autorización

Se comprueba que el servidor aparece entre los DHCP autorizados.

![Validación de autorización](../../screenshots/05-dhcp-servidor-miembro/05-15-verificacion-autorizacion-dhcp.png)

### 10. Ámbito IPv4

Se define el rango que recibirá Windows 10 y las opciones del cliente.

![Ámbito IPv4](../../screenshots/05-dhcp-servidor-miembro/05-16-rango-dhcp.png)

### 11. Validación del ámbito

Se comprueba el estado de la configuración IPv4 del servidor DHCP.

![Validación del ámbito](../../screenshots/05-dhcp-servidor-miembro/05-18-verificacion-ambito-dhcp.png)
