# Diseño empresarial y decisiones de arquitectura

## Contexto

Nexora Solutions es una empresa ficticia de servicios tecnológicos con unos 60 empleados distribuidos en Dirección (5), Recursos Humanos (8), Finanzas (7), Desarrollo (25) y Soporte IT (15).

Se busca administrar identidades, aplicar políticas de seguridad, compartir documentos con permisos por departamento y asignar parámetros IP a estaciones.

## Decisiones

| Decisión | Justificación |
|---|---|
| Bosque único `nexora.test` | Suficiente para una sede y un laboratorio aislado |
| `DC01` (AD DS + DNS) | DNS integrado permite localizar el controlador |
| `SRV01` (DHCP + archivos) | Separación del controlador y práctica de servidor miembro |
| Cliente Windows 10 Enterprise | Pruebas reales de unión, autenticación y GPO |
| OU por usuarios y equipos | Políticas diferenciadas sin confundir OU con permisos |
| Grupos globales y locales de dominio | Modelo AGDLP para autorización |
| Red interna VirtualBox | Minimiza el riesgo para otras redes |

## Limitaciones

Un solo controlador de dominio no ofrece redundancia ni alta disponibilidad. El laboratorio utiliza versiones heredadas de Windows, por lo que **no se recomienda reproducirlo en producción**. No se han desplegado 60 estaciones: el personal se representa lógicamente mediante identidades ficticias.

## Diagrama

Ver [arquitectura lógica](../../diagrams/arquitectura.md).
