# Incidencia 001 — ICMP entre DC01 y SRV01

**Síntoma:** las pruebas `Test-NetConnection` devolvían `PingSucceeded: False` pese a tener direcciones IPv4 de la misma subred.

**Diagnóstico:** se verificaron el direccionamiento estático y la red interna compartida. El tráfico ICMP de entrada estaba restringido por el firewall.

**Solución:** reglas de entrada ICMPv4 (echo request, tipo 8), limitadas a `10.20.30.0/24`, sin desactivar el firewall.

**Resultado:** `PingSucceeded: True` en ambos sentidos.

**Lección:** un ping fallido no demuestra por sí solo que dos máquinas estén en redes diferentes. Verificar capa de red y reglas de host antes de ampliar permisos.
