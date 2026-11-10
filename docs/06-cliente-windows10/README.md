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

## Guía práctica ilustrada

Cada paso combina **acción**, **justificación** y **comprobación**. Las capturas se presentan junto a su explicación: las pruebas de mayor valor quedan visibles y los pasos preparatorios pueden desplegarse al pulsar «Ver captura».

## Conectividad y configuración automática

### Paso 1 — Red interna del cliente

**Qué hicimos.** Conectamos el adaptador de WIN10-CL01 a NEXORA-LAN.

**Por qué.** La red interna permite comunicar el cliente con DNS/DHCP sin usar la red física.

**Cómo lo verificamos.** Verificar que coincide exactamente el nombre de red con DC01 y SRV01.

<details>
<summary>📷 Ver evidencia — Red interna del cliente</summary>

![Red interna del cliente](../../screenshots/06-windows10-cliente%2A/06-01-win10-red-interna.png)

</details>

### Paso 2 — Asignación DHCP

**Qué hicimos.** Obtenemos una dirección mediante el DHCP de SRV01 y consultamos ipconfig /all.

**Por qué.** La concesión automática comprueba el servicio DHCP desde el lado del cliente.

**Cómo lo verificamos.** Verificar IP del rango, DNS 10.20.30.10 y ausencia de gateway no previsto.

![Asignación DHCP](../../screenshots/06-windows10-cliente%2A/06-02-win10-ip-dhcp.png)

### Paso 3 — Resolución DNS

**Qué hicimos.** Realizamos una consulta DNS desde el cliente.

**Por qué.** AD DS necesita registros de localización; resolver solo una IP no basta para autenticar.

**Cómo lo verificamos.** Comprobar resolución del dominio y, si procede, el registro SRV LDAP.

<details>
<summary>📷 Ver evidencia — Resolución DNS</summary>

![Resolución DNS](../../screenshots/06-windows10-cliente%2A/06-03-win10-resolucion-dns.png)

</details>

## Unión y autenticación en Active Directory

### Paso 4 — Unión al dominio

**Qué hicimos.** Unimos WIN10-CL01 a nexora.test y reiniciamos cuando lo solicita Windows.

**Por qué.** La unión crea una cuenta de equipo en el directorio y establece confianza.

**Cómo lo verificamos.** Confirmar que el equipo reconoce el dominio al volver a iniciar.

<details>
<summary>📷 Ver evidencia — Unión al dominio</summary>

![Unión al dominio](../../screenshots/06-windows10-cliente%2A/06-04-win10-unido-dominio.png)

</details>

### Paso 5 — Inicio de sesión corporativo

**Qué hicimos.** Iniciamos sesión con la identidad ficticia ana.garcia.

**Por qué.** La autenticación de un usuario de dominio es una prueba funcional desde el cliente.

**Cómo lo verificamos.** Distinguir el usuario de dominio de una cuenta local.

![Inicio de sesión corporativo](../../screenshots/06-windows10-cliente%2A/06-05-inicio-sesion-ana-garcia.png)

### Paso 6 — OU Estaciones

**Qué hicimos.** Colocamos el objeto WIN10-CL01 en la OU Estaciones.

**Por qué.** Las GPO dirigidas a esa OU se aplicarán según vínculos y filtros configurados.

**Cómo lo verificamos.** Confirmar el objeto en ADUC y después usar gpresult.

<details>
<summary>📷 Ver evidencia — OU Estaciones</summary>

![OU Estaciones](../../screenshots/06-windows10-cliente%2A/06-06-win10-ou-estaciones.png)

</details>

---

### Resultado y límites de la fase

**Interpretación:** la captura acredita el paso indicado en el entorno de laboratorio. La validez del servicio completo requiere además las verificaciones descritas en esta fase.

[↑ Volver a la portada](../../README.md) · [Consultar el inventario de evidencias](../evidencias.md)
