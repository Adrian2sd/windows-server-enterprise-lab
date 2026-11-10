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

## Guía visual vinculada a las capturas

Esta secuencia relaciona los pasos y decisiones técnicas de la fase con la evidencia obtenida. Las capturas son registros del laboratorio, no instrucciones para copiar configuraciones sin entenderlas.

### 1. GPO para estaciones

Se crea y vincula una política específica para ordenadores.

![GPO para estaciones](../../screenshots/07-gpo/07-01-gpo-estaciones-creada.png)

### 2. Bloqueo a 600 segundos

Se configura una política de bloqueo por inactividad.

![Bloqueo a 600 segundos](../../screenshots/07-gpo/07-02-gpo-bloqueo-600s.png)

### 3. Aplicación de política

Se verifica el procesamiento de la GPO en Windows 10.

![Aplicación de política](../../screenshots/07-gpo/07-03-gpo-aplicada-win10.png)

### 4. Bloqueo de sesión

Se aporta evidencia del efecto visible de la política.

![Bloqueo de sesión](../../screenshots/07-gpo/07-04-verificacion-bloqueo-sesion.png)

### 5. GPO para Desarrollo

Se prepara una directiva destinada al departamento técnico.

![GPO para Desarrollo](../../screenshots/07-gpo/07-05-gpo-desarrollo-creada.png)

### 6. Restricción del Panel de control

Se configura la limitación a nivel de usuario.

![Restricción del Panel de control](../../screenshots/07-gpo/07-06-restriccion-panel-control.png)

### 7. Resultado gpresult

Se comprueba qué política recibió la identidad de Desarrollo.

![Resultado gpresult](../../screenshots/07-gpo/07-08-gpresult-usuario-desarrollo.png)

### 8. Prueba de restricción

Se observa el efecto de la directiva en el cliente.

![Prueba de restricción](../../screenshots/07-gpo/07-09-restriccion-panel-funcionando.png)
