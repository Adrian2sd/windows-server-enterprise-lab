# Fase 04 — Estructura organizativa, usuarios y grupos

## Objetivo

Organizar las identidades de Nexora Solutions en Active Directory, diferenciando contenedores organizativos de grupos de autorización.

## Estructura propuesta

```text
nexora.test
└── OU=Empresa
    ├── OU=Usuarios
    │   ├── OU=Direccion
    │   ├── OU=RecursosHumanos
    │   ├── OU=Finanzas
    │   ├── OU=Desarrollo
    │   └── OU=SoporteIT
    ├── OU=Equipos
    │   ├── OU=Estaciones
    │   └── OU=Servidores
    ├── OU=Grupos
    └── OU=CuentasServicio
```

Las OU organizan objetos y permiten vincular GPO o delegar gestión; **no conceden por sí solas permisos sobre carpetas**. Los grupos globales de seguridad representan pertenencia a departamentos.

## Grupos departamentales

| Grupo | Función |
|---|---|
| `GG_Direccion` | Identidades de Dirección |
| `GG_RRHH` | Recursos Humanos |
| `GG_Finanzas` | Finanzas |
| `GG_Desarrollo` | Desarrollo |
| `GG_SoporteIT` | Soporte técnico |

La nomenclatura `GG_` identifica grupos de ámbito global. Los grupos locales de dominio destinados a permisos se documentan en la fase 08.

## Comprobaciones reproducibles

```powershell
Get-ADOrganizationalUnit -SearchBase 'OU=Empresa,DC=nexora,DC=test' -Filter * |
    Select-Object Name, DistinguishedName | Sort-Object DistinguishedName

Get-ADGroup -SearchBase 'OU=Grupos,OU=Empresa,DC=nexora,DC=test' -Filter * |
    Select-Object Name, GroupScope, GroupCategory

Get-ADUser -Filter * -SearchBase 'OU=Usuarios,OU=Empresa,DC=nexora,DC=test' |
    Select-Object Name, SamAccountName, Enabled
```

## Evidencias del laboratorio

El lote de capturas contiene la creación de OU, verificación de su ubicación, grupos departamentales, creación de la primera cuenta y revisión de pertenencias. La lista íntegra de archivos queda en [índice de evidencias](../evidencias.md).

> **Pendiente de verificación exhaustiva:** contrastar nombres y estados de todas las cuentas ficticias con el directorio vivo antes de afirmar que los 60 empleados están creados.

---

## Guía visual vinculada a las capturas

Esta secuencia relaciona los pasos y decisiones técnicas de la fase con la evidencia obtenida. Las capturas son registros del laboratorio, no instrucciones para copiar configuraciones sin entenderlas.

### 1. OU principal Empresa

Se crea el contenedor lógico de la organización, con protección contra borrado accidental.

![OU principal Empresa](../../screenshots/04-usuarios-ou-grupos/04-01-ou-empresa.png)

### 2. Comprobación del DN

PowerShell identifica el DistinguishedName de la OU recién creada.

![Comprobación del DN](../../screenshots/04-usuarios-ou-grupos/04-02-verificacion-ou-empresa.png)

### 3. OU principales

Se separan Usuarios, Equipos, Grupos y CuentasServicio.

![OU principales](../../screenshots/04-usuarios-ou-grupos/04-03-estructura-principal-ou.png)

### 4. Departamentos

Se crean las OU de Dirección, RRHH, Finanzas, Desarrollo y Soporte IT.

![Departamentos](../../screenshots/04-usuarios-ou-grupos/04-04-ou-departamentos.png)

### 5. Verificación jerárquica

Se comprueba la ubicación de las OU con PowerShell.

![Verificación jerárquica](../../screenshots/04-usuarios-ou-grupos/04-05-verificacion-estructura-ou.png)

### 6. Clasificación de equipos

Se distinguen Estaciones y Servidores; DC01 permanece en Domain Controllers.

![Clasificación de equipos](../../screenshots/04-usuarios-ou-grupos/04-06-ou-equipos.png)

### 7. Grupos departamentales

Se crean grupos globales de seguridad para separar identidades de permisos.

![Grupos departamentales](../../screenshots/04-usuarios-ou-grupos/04-08-grupos-departamentales.png)

### 8. Ámbito y categoría

Se verifican los grupos con las propiedades Global y Security.

![Ámbito y categoría](../../screenshots/04-usuarios-ou-grupos/04-09-verificacion-grupos.png)

### 9. Primer usuario

Se documenta la creación de la cuenta ficticia de Dirección.

![Primer usuario](../../screenshots/04-usuarios-ou-grupos/04-10-creacion-usuario-laura.png)

### 10. Pertenencia a grupo

Se asocia la cuenta de Dirección a su grupo global.

![Pertenencia a grupo](../../screenshots/04-usuarios-ou-grupos/04-11-laura-grupo-direccion.png)

### 11. Consulta de usuario

Se comprueba su registro mediante herramientas de Active Directory.

![Consulta de usuario](../../screenshots/04-usuarios-ou-grupos/04-12-verificacion-usuario-laura.png)

### 12. Cuentas por departamento

Se amplía el directorio con identidades de prueba.

![Cuentas por departamento](../../screenshots/04-usuarios-ou-grupos/04-13-usuarios-departamentales.png)

### 13. Verificación de empleados

Se consulta la estructura de usuarios y las cuentas creadas.

![Verificación de empleados](../../screenshots/04-usuarios-ou-grupos/04-14-verificacion-usuarios-ad.png)

### 14. Relaciones usuario-grupo

Se revisa la correspondencia entre identidades y grupos departamentales.

![Relaciones usuario-grupo](../../screenshots/04-usuarios-ou-grupos/04-15-verificacion-grupos-usuarios.png)
