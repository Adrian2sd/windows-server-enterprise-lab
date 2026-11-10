# Fase 06 — Cliente Windows 10 Enterprise

## Objetivo

Validar que un equipo cliente recibe configuración IP, resuelve DNS, se une al dominio `nexora.test` e inicia sesión con una identidad corporativa.

## Equipo

`WIN10-CL01`, Windows 10 Enterprise, conectado a la red interna `NEXORA-LAN`.

## Secuencia de pruebas

1. Verificar que VirtualBox utiliza la red interna correcta.
2. Comprobar asignación DHCP con `ipconfig /all`.
3. Comprobar que el servidor DNS es `10.20.30.10`.
4. Consultar un registro de localización de Active Directory:
   ```powershell
   nslookup -type=SRV _ldap._tcp.dc._msdcs.nexora.test
   ```
5. Unir el equipo al dominio, reiniciar e iniciar sesión con un usuario de prueba.
6. Comprobar la ubicación del objeto equipo en `OU=Estaciones`.

## Validación

El lote de capturas incluye DHCP, resolución DNS, unión al dominio, inicio de sesión de `ana.garcia` y ubicación de la estación en Active Directory. Son evidencias visuales que deberán acompañarse de las pruebas ejecutables al publicar las imágenes.

> No usar Windows 10 Enterprise convencional sin soporte como cliente de producción. Este entorno está aislado y es exclusivamente educativo.

---

## Guía visual vinculada a las capturas

Esta secuencia relaciona los pasos y decisiones técnicas de la fase con la evidencia obtenida. Las capturas son registros del laboratorio, no instrucciones para copiar configuraciones sin entenderlas.

### 1. Red interna del cliente

El adaptador del cliente se asocia al mismo segmento NEXORA-LAN.

![Red interna del cliente](../../screenshots/06-windows10-cliente%2A/06-01-win10-red-interna.png)

### 2. Asignación DHCP

Se comprueba la dirección dinámica que recibe Windows 10.

![Asignación DHCP](../../screenshots/06-windows10-cliente%2A/06-02-win10-ip-dhcp.png)

### 3. Resolución DNS

El cliente consulta el DNS interno para localizar el dominio.

![Resolución DNS](../../screenshots/06-windows10-cliente%2A/06-03-win10-resolucion-dns.png)

### 4. Unión al dominio

Se incorpora Windows 10 Enterprise a nexora.test.

![Unión al dominio](../../screenshots/06-windows10-cliente%2A/06-04-win10-unido-dominio.png)

### 5. Inicio de sesión corporativo

Se utiliza la cuenta ficticia ana.garcia en el cliente.

![Inicio de sesión corporativo](../../screenshots/06-windows10-cliente%2A/06-05-inicio-sesion-ana-garcia.png)

### 6. OU Estaciones

Se organiza el objeto de equipo en la OU correspondiente.

![OU Estaciones](../../screenshots/06-windows10-cliente%2A/06-06-win10-ou-estaciones.png)
