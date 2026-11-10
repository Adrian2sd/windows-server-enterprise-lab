# Arquitectura lógica — Nexora Solutions

```mermaid
flowchart TB
    NET["Red interna VirtualBox: NEXORA-LAN<br/>10.20.30.0/24"]
    DC["DC01 · Windows Server 2016<br/>AD DS + DNS<br/>10.20.30.10"]
    SRV["SRV01 · Windows Server 2016<br/>DHCP + archivos SMB/NTFS<br/>10.20.30.20"]
    CL["WIN10-CL01 · Windows 10 Enterprise<br/>IP mediante DHCP"]
    NET --- DC
    NET --- SRV
    NET --- CL
    DC -. "Dominio nexora.test" .-> SRV
    DC -. "Autenticación / DNS / GPO" .-> CL
    SRV -. "DHCP / recursos compartidos" .-> CL
```

La red se diseñó sin adaptador puente ni acceso directo desde estas VM a la LAN doméstica. Un segundo cliente es una ampliación prevista, no una máquina demostrada en el material revisado.
