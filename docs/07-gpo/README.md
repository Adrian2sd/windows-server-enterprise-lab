# Fase 07 — Directivas de grupo (GPO)

## Objetivo

Administrar políticas Windows desde Active Directory y demostrar su aplicación tanto a equipos como a usuarios.

## Escenarios registrados

- Política sobre estaciones para bloquear la sesión tras un período de inactividad: la evidencia disponible hace referencia a **600 segundos**.
- Política específica del departamento Desarrollo para restringir el acceso al Panel de control.
- Comprobación de aplicación con `gpresult` y pruebas visibles desde el cliente.

## Comandos de verificación

```powershell
gpupdate /force
gpresult /r
gpresult /h C:\Windows\Temp\resultado-gpo.html
```

`gpresult /r` distingue las directivas aplicadas al usuario y al equipo; conviene verificar el contexto (sesión y OU) antes de atribuir efectos a una GPO concreta.

## Principios de diseño

- Enlazar las políticas a la OU adecuada: equipo vs usuario.
- Mantener separados los escenarios de política de seguridad y restricciones de interfaz.
- Comprobar herencia, filtrado de seguridad y actualización de políticas.
- Documentar valor configurado **y** comportamiento observado.

## Evidencias

Capturas de creación de GPO, configuración de bloqueo a 600 s, prueba aplicada a Windows 10, política de Desarrollo, `gpresult` y restricción del Panel de control. Véase [índice](../evidencias.md).

---

## Guía práctica ilustrada

Cada paso combina **acción**, **justificación** y **comprobación**. Las capturas se presentan junto a su explicación: las pruebas de mayor valor quedan visibles y los pasos preparatorios pueden desplegarse al pulsar «Ver captura».

## GPO de equipo: bloqueo por inactividad

### Paso 1 — GPO para estaciones

**Qué hicimos.** Creamos y vinculamos una GPO a la OU Estaciones.

**Por qué.** Una GPO puede contener ajustes de usuario o equipo, pero debe aplicarse al ámbito adecuado.

**Cómo lo verificamos.** Distinguir el vínculo de OU del contenido de la política.

<details>
<summary>📷 Ver evidencia — GPO para estaciones</summary>

![GPO para estaciones](../../screenshots/07-gpo/07-01-gpo-estaciones-creada.png)

</details>

### Paso 2 — Bloqueo a 600 segundos

**Qué hicimos.** Configuramos el límite de inactividad de la sesión a 600 segundos.

**Por qué.** La medida reduce sesiones desatendidas en estaciones compartidas.

**Cómo lo verificamos.** Comprobar valor y configuración de equipo; no equivale a un tiempo de espera de pantalla genérico.

<details>
<summary>📷 Ver evidencia — Bloqueo a 600 segundos</summary>

![Bloqueo a 600 segundos](../../screenshots/07-gpo/07-02-gpo-bloqueo-600s.png)

</details>

### Paso 3 — Aplicación de política

**Qué hicimos.** Actualizamos las directivas en el cliente y verificamos su aplicación.

**Por qué.** Crear la GPO en el servidor no prueba que el cliente la haya recibido.

**Cómo lo verificamos.** Usar gpupdate /force y gpresult para confirmar la política aplicable.

<details>
<summary>📷 Ver evidencia — Aplicación de política</summary>

![Aplicación de política](../../screenshots/07-gpo/07-03-gpo-aplicada-win10.png)

</details>

### Paso 4 — Bloqueo de sesión

**Qué hicimos.** Comprobamos el bloqueo visible tras el intervalo definido.

**Por qué.** Una prueba funcional complementa las capturas de configuración.

**Cómo lo verificamos.** Registrar resultado observado sin confundir bloqueo con cierre de sesión.

![Bloqueo de sesión](../../screenshots/07-gpo/07-04-verificacion-bloqueo-sesion.png)

## GPO de usuario: restricciones de Desarrollo

### Paso 5 — GPO para Desarrollo

**Qué hicimos.** Creamos una GPO para las cuentas del departamento Desarrollo.

**Por qué.** Las restricciones de usuario deben vincularse a la OU correspondiente o utilizar filtrado adecuado.

**Cómo lo verificamos.** Comprobar el ámbito de usuario y la OU objetivo.

<details>
<summary>📷 Ver evidencia — GPO para Desarrollo</summary>

![GPO para Desarrollo](../../screenshots/07-gpo/07-05-gpo-desarrollo-creada.png)

</details>

### Paso 6 — Restricción del Panel de control

**Qué hicimos.** Configuramos la restricción de acceso al Panel de control.

**Por qué.** Es un ejemplo demostrativo de gobierno centralizado de equipos Windows.

**Cómo lo verificamos.** La directiva no sustituye una configuración completa de seguridad del cliente.

<details>
<summary>📷 Ver evidencia — Restricción del Panel de control</summary>

![Restricción del Panel de control](../../screenshots/07-gpo/07-06-restriccion-panel-control.png)

</details>

### Paso 7 — Resultado gpresult

**Qué hicimos.** Ejecutamos gpresult desde la sesión de un usuario de Desarrollo.

**Por qué.** gpresult ayuda a demostrar qué GPO se aplicaron realmente.

**Cómo lo verificamos.** Buscar el nombre de la GPO en el contexto correcto de usuario.

![Resultado gpresult](../../screenshots/07-gpo/07-08-gpresult-usuario-desarrollo.png)

### Paso 8 — Prueba de restricción

**Qué hicimos.** Intentamos abrir el Panel de control como el usuario afectado.

**Por qué.** La denegación de acceso demuestra el efecto práctico de la GPO.

**Cómo lo verificamos.** Confirmar la restricción sin atribuirla a otra política no verificada.

![Prueba de restricción](../../screenshots/07-gpo/07-09-restriccion-panel-funcionando.png)

---

### Resultado y límites de la fase

**Interpretación:** la captura acredita el paso indicado en el entorno de laboratorio. La validez del servicio completo requiere además las verificaciones descritas en esta fase.

[↑ Volver a la portada](../../README.md) · [Consultar el inventario de evidencias](../evidencias.md)
