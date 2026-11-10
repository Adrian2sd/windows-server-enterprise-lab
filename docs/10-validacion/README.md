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

---

## Guía práctica ilustrada

Cada paso combina **acción**, **justificación** y **comprobación**. Las capturas se presentan junto a su explicación: las pruebas de mayor valor quedan visibles y los pasos preparatorios pueden desplegarse al pulsar «Ver captura».

## Servicios de directorio y resolución DNS

### Paso 1 — Validación de AD DS

**Qué hicimos.** Ejecutamos una primera tanda de pruebas de Active Directory.

**Por qué.** Las comprobaciones de servicio permiten detectar fallos no visibles en ADUC.

**Cómo lo verificamos.** Distinguir estado de servicio de salud completa del directorio.

<details>
<summary>📷 Ver evidencia — Validación de AD DS</summary>

![Validación de AD DS](../../screenshots/10-validacion/10-01-validacion-ad-parte1.png)

</details>

### Paso 2 — Validación de AD DS

**Qué hicimos.** Completamos la validación de AD DS con una segunda captura.

**Por qué.** Dividir salidas extensas mejora la legibilidad de las pruebas.

**Cómo lo verificamos.** Relacionar ambas capturas con los comandos ejecutados, sin dar por aprobado un test no legible.

![Validación de AD DS](../../screenshots/10-validacion/10-01-validacion-ad-parte2.png)

### Paso 3 — Registro A

**Qué hicimos.** Consultamos el registro A del controlador de dominio.

**Por qué.** La resolución de nombres de host permite encontrar servidores internos.

**Cómo lo verificamos.** Verificar dirección 10.20.30.10 y servidor DNS utilizado.

<details>
<summary>📷 Ver evidencia — Registro A</summary>

![Registro A](../../screenshots/10-validacion/10-02-validacion-registros-a.png)

</details>

### Paso 4 — Zonas y SRV

**Qué hicimos.** Comprobamos las zonas y los registros SRV de localización de AD.

**Por qué.** Los clientes se apoyan en el registro SRV para descubrir el servicio LDAP.

**Cómo lo verificamos.** Esperado: _ldap._tcp.dc._msdcs.nexora.test → DC01.nexora.test.

![Zonas y SRV](../../screenshots/10-validacion/10-02-validacion-zonas-srv.png)

## DHCP y comportamiento del cliente

### Paso 5 — Validación de DHCP

**Qué hicimos.** Verificamos la configuración y el estado de DHCP.

**Por qué.** La disponibilidad de un ámbito debe complementarse con una concesión real al cliente.

**Cómo lo verificamos.** Comprobar ausencia de DHCP conflictivo en NEXORA-LAN.

![Validación de DHCP](../../screenshots/10-validacion/10-03-validacion-dhcp.png)

### Paso 6 — Validación de bloqueo

**Qué hicimos.** Probamos la política de bloqueo después de 600 segundos.

**Por qué.** La configuración administrativa debe demostrar efecto en una sesión de prueba.

**Cómo lo verificamos.** Registrar si se bloquea sin cerrar la sesión.

<details>
<summary>📷 Ver evidencia — Validación de bloqueo</summary>

![Validación de bloqueo](../../screenshots/10-validacion/10-04-validacion-bloqueo-600s.png)

</details>

## Aplicación de directivas

### Paso 7 — Resultado de políticas de equipo

**Qué hicimos.** Generamos el resultado de políticas de equipo.

**Por qué.** gpresult distingue Computer Settings y User Settings.

**Cómo lo verificamos.** Confirmar el contexto Equipo para la GPO de bloqueo.

<details>
<summary>📷 Ver evidencia — Resultado de políticas de equipo</summary>

![Resultado de políticas de equipo](../../screenshots/10-validacion/10-05-gpresult-equipo.png)

</details>

### Paso 8 — Resultado de políticas de usuario

**Qué hicimos.** Generamos el resultado de políticas de usuario.

**Por qué.** Las restricciones a Desarrollo solo son relevantes para las cuentas a las que se aplican.

**Cómo lo verificamos.** Confirmar usuario, OU y nombre de GPO.

<details>
<summary>📷 Ver evidencia — Resultado de políticas de usuario</summary>

![Resultado de políticas de usuario](../../screenshots/10-validacion/10-05-validacion-gpo-usuario.png)

</details>

### Paso 9 — Validación final de GPO

**Qué hicimos.** Finalizamos la revisión de la GPO aplicada al equipo.

**Por qué.** La validación final debe asociar configuración, política recibida y comportamiento.

**Cómo lo verificamos.** Si faltan resultados de NTFS/SMB o DNS, consultar las fases de implementación.

![Validación final de GPO](../../screenshots/10-validacion/10-06-validacion-gpo-equipo.png)

---

### Resultado y límites de la fase

**Interpretación:** la captura acredita el paso indicado en el entorno de laboratorio. La validez del servicio completo requiere además las verificaciones descritas en esta fase.

[↑ Volver a la portada](../../README.md) · [Consultar el inventario de evidencias](../evidencias.md)
