# Fase 09 — Administración con PowerShell

## Objetivo

Simular operaciones habituales del ciclo de vida de empleados y demostrar cómo reducir tareas repetitivas: alta, cambio de departamento y baja lógica.

## Escenarios con evidencias

- Alta de usuario y comprobación posterior.
- Cambio de departamento y revisión de su pertenencia/ubicación.
- Creación de OU de bajas y retirada del acceso.
- Validación de los cambios con PowerShell y ADUC.

## Buenas prácticas

- Scripts parametrizados y ejecución con permisos mínimos.
- `-WhatIf` en operaciones compatibles y comprobaciones previas.
- No almacenar contraseñas en texto plano.
- No borrar cuentas definitivamente en una práctica de bajas: deshabilitar y mover a OU de bajas según política.
- Registrar cada cambio y su resultado.
- Comprobar grupos de origen y destino al mover empleados.

El ZIP contiene **capturas de código y ejecución**, pero no los archivos `.ps1` originales. No se han reconstruido como si fueran scripts ejecutados. La carpeta `scripts/powershell/` contendrá ejemplos auditables separados claramente de los originales.

---

## Guía práctica ilustrada

Cada paso combina **acción**, **justificación** y **comprobación**. Las capturas se presentan junto a su explicación: las pruebas de mayor valor quedan visibles y los pasos preparatorios pueden desplegarse al pulsar «Ver captura».

## Alta de empleados

### Paso 1 — Script de alta

**Qué hicimos.** Preparamos un script de alta de usuarios de dominio.

**Por qué.** La automatización estandariza atributos y ubicación, reduciendo errores repetitivos.

**Cómo lo verificamos.** No publicar contraseñas ni confundir captura del código con el archivo fuente original.

<details>
<summary>📷 Ver evidencia — Script de alta</summary>

![Script de alta](../../screenshots/09-powershell-casos/09-01-script-alta-empleado.png)

</details>

### Paso 2 — Ejecución de alta

**Qué hicimos.** Ejecutamos el flujo de alta con una identidad ficticia.

**Por qué.** La ejecución sirve para validar el script en un entorno realista.

**Cómo lo verificamos.** Antes de operar sobre usuarios existentes, añadir validación y control de errores.

<details>
<summary>📷 Ver evidencia — Ejecución de alta</summary>

![Ejecución de alta](../../screenshots/09-powershell-casos/09-02-ejecucion-alta-empleado.png)

</details>

### Paso 3 — Verificación del alta

**Qué hicimos.** Comprobamos en AD que se creó la identidad esperada.

**Por qué.** Un script no debe considerarse exitoso solo porque termine sin error visible.

**Cómo lo verificamos.** Revisar nombre de cuenta, OU y grupo departamental.

![Verificación del alta](../../screenshots/09-powershell-casos/09-03-verificacion-alta-empleado.png)

## Cambio de departamento

### Paso 4 — Script de traslado

**Qué hicimos.** Preparamos el traslado de un empleado entre departamentos.

**Por qué.** Cambiar OU o atributo Department no actualiza por sí solo los permisos; se deben revisar grupos.

**Cómo lo verificamos.** Documentar tanto la salida del grupo anterior como el alta en el nuevo.

<details>
<summary>📷 Ver evidencia — Script de traslado</summary>

![Script de traslado](../../screenshots/09-powershell-casos/09-04-script-cambio-departamento.png)

</details>

### Paso 5 — Verificación del traslado

**Qué hicimos.** Verificamos el nuevo departamento y las pertenencias resultantes.

**Por qué.** La prueba debe comprobar ausencia de privilegios sobrantes.

**Cómo lo verificamos.** Confirmar que se retiraron autorizaciones que dejaron de estar justificadas.

![Verificación del traslado](../../screenshots/09-powershell-casos/09-05-verificacion-cambio-departamento.png)

## Baja lógica y conservación de evidencia

### Paso 6 — OU de bajas

**Qué hicimos.** Creamos una OU para cuentas de baja.

**Por qué.** Una baja lógica conserva la trazabilidad sin borrar inmediatamente la identidad.

**Cómo lo verificamos.** Proteger la OU y evitar que reciba GPO innecesarias.

<details>
<summary>📷 Ver evidencia — OU de bajas</summary>

![OU de bajas](../../screenshots/09-powershell-casos/09-06-ou-bajas.png)

</details>

### Paso 7 — Script de baja

**Qué hicimos.** Preparamos la deshabilitación y el traslado a la OU de bajas.

**Por qué.** Deshabilitar impide nuevas autenticaciones, pero conviene revisar sesiones y accesos delegados.

**Cómo lo verificamos.** No almacenar contraseñas, secretos o identificadores personales en scripts.

<details>
<summary>📷 Ver evidencia — Script de baja</summary>

![Script de baja](../../screenshots/09-powershell-casos/09-07-script-baja-empleado.png)

</details>

### Paso 8 — Verificación de baja

**Qué hicimos.** Comprobamos el estado final de la cuenta dada de baja.

**Por qué.** La validación evita confundir mover una cuenta con deshabilitarla realmente.

**Cómo lo verificamos.** Revisar Enabled=False y OU de destino.

![Verificación de baja](../../screenshots/09-powershell-casos/09-08-verificacion-baja-empleado.png)

---

### Resultado y límites de la fase

**Interpretación:** la captura acredita el paso indicado en el entorno de laboratorio. La validez del servicio completo requiere además las verificaciones descritas en esta fase.

[↑ Volver a la portada](../../README.md) · [Consultar el inventario de evidencias](../evidencias.md)
