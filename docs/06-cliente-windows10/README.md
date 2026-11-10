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
