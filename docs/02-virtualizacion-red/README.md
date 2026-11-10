# Fase 02 — Virtualización y red aislada

## Objetivo

Crear la infraestructura base de **Nexora Solutions** en Oracle VirtualBox sobre un equipo Windows 11, asegurando conectividad entre servidores sin exponer los servicios del laboratorio a la red doméstica.

## Arquitectura y direccionamiento

| Parámetro | DC01 | SRV01 |
|---|---|---|
| Sistema operativo | Windows Server 2016 Standard Evaluation | Windows Server 2016 Standard Evaluation |
| RAM | 4 GB | 4 GB |
| vCPU | 2 | 2 |
| Disco virtual | 50 GB VDI dinámico | 50 GB VDI dinámico |
| IP | `10.20.30.10` | `10.20.30.20` |
| Máscara | `255.255.255.0` | `255.255.255.0` |
| Puerta de enlace | Sin configurar | Sin configurar |
| DNS interno | `10.20.30.10` | `10.20.30.10` |

**Configuración de VirtualBox:** adaptador 1 en modalidad **Red interna**, nombre exacto `NEXORA-LAN`, sin adaptadores adicionales activos durante las pruebas de aislamiento.

## Procedimiento

1. Crear las máquinas `DC01` y `SRV01` con discos VDI de crecimiento dinámico.
2. Instalar Windows Server 2016 con *Desktop Experience*.
3. Configurar el nombre de cada servidor y asignar IP estática.
4. Comprobar la dirección y el nombre con `hostname` e `ipconfig /all`.
5. Probar conectividad en ambos sentidos con `Test-NetConnection`.
6. Ante los primeros fallos ICMP, mantener activo el firewall y añadir una regla de entrada para solicitudes echo IPv4 **limitada a `10.20.30.0/24`**.
7. Repetir ambas pruebas y verificar `PingSucceeded: True`.
8. Comprobar rutas IPv4 con `route print -4` y guardar instantáneas base de las máquinas.

## Pruebas y resultados

| Prueba | Comando | Evidencia observada |
|---|---|---|
| Identidad del servidor | `hostname` | `DC01` y `SRV01` |
| Direccionamiento estático | `ipconfig /all` | `10.20.30.10/24` y `10.20.30.20/24`, DHCP deshabilitado en ambos servidores |
| Conectividad inicial | `Test-NetConnection <IP-del-otro-servidor>` | `PingSucceeded: False` |
| Conectividad tras ajuste del firewall | Mismo comando en ambos sentidos | `PingSucceeded: True` |
| Rutas locales | `route print -4` | Captura de comprobación disponible; revisar contenido antes de afirmar aislamiento completo |

> **Alcance de la prueba:** el ping bidireccional demuestra conectividad entre máquinas virtuales, pero por sí solo no certifica el aislamiento externo. Para ello deben comprobarse también la modalidad Red interna y las rutas del equipo.

## Incidencia 001 — ICMP bloqueado

**Síntoma:** ambos servidores tenían las IP correctas, pero `Test-NetConnection` devolvía `PingSucceeded: False`.

**Intervención:** se creó en cada servidor una regla de firewall de entrada, protocolo ICMPv4 y tipo echo request (8), permitiendo solo orígenes de la subred `10.20.30.0/24`. No se desactivó globalmente Windows Firewall.

```powershell
New-NetFirewallRule `
  -DisplayName "LAB - Permitir ICMPv4 Nexora" `
  -Direction Inbound `
  -Protocol ICMPv4 `
  -IcmpType 8 `
  -RemoteAddress 10.20.30.0/24 `
  -Action Allow `
  -Profile Any
```

**Resultado:** la comunicación entre `DC01` y `SRV01` funcionó en ambos sentidos.

## Evidencias seleccionadas

Se han separado seis capturas para publicar en `screenshots/02-virtualizacion-red/`. **Aún no están adjuntadas en el repositorio**; los enlaces se incorporarán cuando se carguen los PNG.

| Nombre de archivo | Qué acredita |
|---|---|
| `02-03-dc01-windows-server-instalado.png` | Instalación y Server Manager de DC01 |
| `02-04-dc01-ip-estatica.png` | Dirección fija y DNS en DC01 |
| `02-06-srv01-ip-estatica.png` | Dirección fija y DNS en SRV01 |
| `02-08-regla-firewall-icmp.png` | Ajuste limitado de ICMP en ambos servidores |
| `02-09-conectividad-dc01-srv01.png` | Ping bidireccional correcto |
| `02-10-rutas-red-interna.png` | Comprobación de rutas IPv4 |

## Aprendizajes

- Diferencia entre configuración IP y conectividad efectiva.
- Aislamiento por topología de red virtual y ausencia de salida directa.
- Diagnóstico de tráfico ICMP bloqueado sin apagar el firewall.
- Importancia de conservar evidencias del fallo y de la solución.

---

## Guía visual vinculada a las capturas

Esta secuencia relaciona los pasos y decisiones técnicas de la fase con la evidencia obtenida. Las capturas son registros del laboratorio, no instrucciones para copiar configuraciones sin entenderlas.

### 1. Instalación de DC01

Se presenta el servidor con Windows Server 2016 instalado y su consola de administración.

![Instalación de DC01](../../screenshots/02-virtualizacion-red/02-03-dc01-windows-server-instalado.png)

### 2. IP fija de DC01

Se revisa la dirección 10.20.30.10 y el servidor DNS interno previsto.

![IP fija de DC01](../../screenshots/02-virtualizacion-red/02-04-dc01-ip-estatica.png)

### 3. Instalación de SRV01

Se incorpora el segundo Windows Server, separado del controlador de dominio.

![Instalación de SRV01](../../screenshots/02-virtualizacion-red/02-05-srv01-instalado.png)

### 4. IP fija de SRV01

Se comprueba 10.20.30.20 y la pertenencia a la red 10.20.30.0/24.

![IP fija de SRV01](../../screenshots/02-virtualizacion-red/02-06-srv01-ip-estatica.png)

### 5. Regla de firewall ICMP

Tras fallar la comunicación, se permite ICMPv4 desde la subred del laboratorio sin desactivar el firewall.

![Regla de firewall ICMP](../../screenshots/02-virtualizacion-red/02-08-regla-firewall-icmp.png)

### 6. Conectividad entre servidores

Se repite la prueba en ambos sentidos y se documenta la respuesta satisfactoria.

![Conectividad entre servidores](../../screenshots/02-virtualizacion-red/02-09-conectividad-dc01-srv01.png)

### 7. Rutas internas

Se inspecciona el enrutamiento IPv4, que complementa la prueba de aislamiento.

![Rutas internas](../../screenshots/02-virtualizacion-red/02-10-rutas-red-interna.png)

### 8. Instantánea de SRV01

Se conserva un punto de recuperación antes de instalar nuevos roles.

![Instantánea de SRV01](../../screenshots/02-virtualizacion-red/02-11-srv01-snapshot.png)
