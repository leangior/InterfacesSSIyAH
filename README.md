# InterfacesSSIyAH
Interfaces para la consulta o generación de series temporales sobre la base de las funcionalidades provistas por el Sistema de Información y Alerta Hidrológico de SSIyAH-INA
---
title: "R Notebook. Interfaces SSIyAH-INA"
output: html_notebook
---

Las librerías que se presentan se encuentran en fase experimental de desarrollo. Las mismas son de utilidad para analistas y pronosticadores que deseen ingestar observaciones y previsiones numéricas disonibles en el sistema de manejo y gestión de datos de SSIyAH-INA, en ambiente R.

- 0 Ingresar la información necesaria en el archivo de configuración

El archivo de configuración es un objeto json en donde se deben especificar el usuario (en _database_ campo _user_, la cual ha sido provista por el administrador de sistema), la _url_ de la api (en este repositorio ya aparece configurada). Finalmente, en el campo _token_ debe insertarse la credencial provista por el administrador.  

- 1 Invocar a los procedimientos de ingesta.

Comenzamos asumiendo que el usuario se encuentra en el nivel de carpeta para el cual se ha descargado o clonado este repositorio. 

```{r}
source("InterfacesConsultaSSIyAH.R")
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Ctrl+Shift+K* to preview the HTML file).

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.
