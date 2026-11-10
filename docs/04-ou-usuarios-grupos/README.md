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
