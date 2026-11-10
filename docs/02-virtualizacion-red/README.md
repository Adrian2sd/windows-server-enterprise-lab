# Fase 02 — Virtualización y red

## Objetivo

Montar una infraestructura aislada en Oracle VirtualBox sobre un anfitrión Windows 11, sin interferir con la red física.

## Diseño

- Red interna VirtualBox: `NEXORA-LAN` (`10.20.30.0/24`).
- `DC01`: Windows Server 2016, IP `10.20.30.10`, DNS previsto `10.20.30.10`.
- `SRV01`: Windows Server 2016, IP `10.20.30.20`, DNS `10.20.30.10`.
- Sin puerta de enlace para las interfaces internas.
- Adaptadores adicionales deshabilitados durante las pruebas de aislamiento.

## Pruebas registradas

Se verificó el direccionamiento con `hostname` e `ipconfig /all`. Las primeras pruebas `Test-NetConnection` entre los servidores fallaron por ICMP. Se añadieron reglas limitadas al rango `10.20.30.0/24`, manteniendo el firewall activo. Las pruebas posteriores mostraron `PingSucceeded: True` en ambos sentidos.

## Evidencia pendiente

Vincular capturas de la configuración de VirtualBox, direcciones IP y pruebas de conectividad. Añadir comprobación de rutas `route print -4` cuando se revise la selección final.
