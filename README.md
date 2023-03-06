# InterfacesSSIyAH
Interfaces para la consulta o generación de series temporales sobre la base de las funcionalidades provistas por el Sistema de Información y Alerta Hidrológico de SSIyAH-INA
---
title: "R Notebook. Interfaces SSIyAH-INA"
---

Las librerías que se presentan se encuentran en fase experimental de desarrollo. Las mismas son de utilidad para analistas y pronosticadores que deseen ingestar observaciones y previsiones numéricas disonibles en el sistema de manejo y gestión de datos de SSIyAH-INA, en ambiente R.

- Ingresar la información necesaria en el archivo de configuración ("Config.json")

El archivo de configuración es un _objeto json_ en donde se deben especificar el usuario (en _database_ campo _user_, provisto por el administrador, por defecto el usuario de e-mail que solicitó credenciales) y la _url_ de la api (en este repositorio ya aparece configurada). Asimismo, en el campo _token_ debe insertarse la credencial provista por el administrador.  

- Abrir sesión de R e invocar a los procedimientos de ingesta.

Comenzamos asumiendo que el usuario se encuentra en el nivel de carpeta para el cual se ha descargado o clonado este repositorio. 

```{r}
source("InterfacesConsultaSSIyAH.R")
```

- Función getDBPointSerie(Id,Start,End,Agg,Fill,configFile)

Esta función
