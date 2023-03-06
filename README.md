# InterfacesSSIyAH
Interfaces para la consulta o generación de series temporales sobre la base de las funcionalidades provistas por el Sistema de Información y Alerta Hidrológico de SSIyAH-INA
---
"Interfaces R/SSIyAH-INA"
---

Las librerías que se presentan se encuentran en fase experimental de desarrollo. Las mismas son de utilidad para analistas y pronosticadores que deseen ingestar observaciones y previsiones numéricas disonibles en el sistema de manejo y gestión de datos de SSIyAH-INA, en ambiente R.

- Ingresar la información necesaria en el archivo de configuración ("Config.json")

El archivo de configuración es un _objeto json_ en donde se deben especificar el usuario (en _database_ campo _user_, provisto por el administrador, por defecto el usuario de e-mail que solicitó credenciales) y la _url_ de la api (en este repositorio ya aparece configurada). Asimismo, en el campo _token_ de _api_ debe insertarse la credencial provista por el administrador.  

- Abrir sesión de R e invocar a los procedimientos de ingesta.

Comenzamos asumiendo que el usuario se encuentra en el nivel de carpeta para el cual se ha descargado o clonado este repositorio. 

```{r}
source("InterfacesConsultaSSIyAH.R")
```

- Función getDBPointSerie(Id,Start,End,Agg,Fill,configFile)

Id es el identificador de la serie en el sistema de informacíón (cada serie está definida para un punto, mediante una variable,procedimiento de cómputo y unidades utilizadas. El identificador resume esto. asume un valor entero). Así, por ejemplo, podremos ver que 1006 es la serie que corresponde al caudal estimado en Asunción. Luego debe brindarse una fecha de inicio (_Start_) y una fecha de fin (_End_). Por otro lado, _Agg_ es el nivel de agregación: se obtiene una serie a paso nativo, si no se especifica este parámetro (no es recomendable), diario (_Daily_), semanal ('Weekly') o menusal ('Monthly'), si se especifica. El algoritmo devuelve un objeto 'xts', por lo que se sugiere trabajar al menos a paso diario.   

Para este ejemplo, la línea de comando 

```{r}
serie=getDBPointSerie(1006,"2023-01-01","2023-06-06",Agg='Daily')
```

Devuelve la serie diaria de caudales en Asunción, iniciando el 1 de enero de 2023 y finalizando el 6 de marzo de 2023-

Si se utilizara 

```{r}
serie=getDBPointSerie(1006,"2023-01-01","2023-06-06",Agg='Weekly')
```

se obtendría la serie semanal. En ambos casos puede consultarse la gráfica de la serie temproal mediante:

```{r}
plot(serie)
```

El parámetro _Fill_ por defecto asume el nivel 'yes', lo cual significa que si hay datos faltantes serán rellenados por na.approx(). Si no se desea que las series se rellenen por este algoritmo debe especificarse 'no' o cualquier otro nivel distinto de 'yes'.

- Función getDBArealSerie(Id,Start,End,Agg,Fill,configFile)

Esta función es semejante a la anterior, con la diferencia que la consulta es sobre una serie areal. Por ejemplo, el identificador de la serie de precipitación media areal diaria para un sector del abanico aluvial del Pilcomayo es 3950 (puede consultarse a través del mapa web). Así, la ejecución:

```{r}
pma=getDBArealSerie(3950,"2023-01-01","2023-06-06")
```

Nos devuelve la serie temporal de pma diaria para este sector, como objeto xts.

- Función getDBLastForecast(StId,CalId,varId,Qualy)

Esta función devuelve las últimas previsiones _on-line_ para un sitio con identificador _StId_ (entero) por el modelo operativo con identificador _CalId_ (entero), para la variable VarId (entero, por defecto varId=4 es caudal) y de acuerdo a la configuración _Qualy_ del modelo (Qualy='main' suele ser la configuración de tendencia central y es el nivel asumido por defecto). Por ejemplo, si se desean las previsiones de caudal en Asunción (_StId=157_), para la tendencia central de acuerdo al modelo de memoria (_Calid=286_,_Qualy=main_), debe ejecutarse:  

```{r}
forecast=getDBLastForecast(157,286)
```
Asimismo, mediante

```{r}
plot(forecast)
```
puede evaluarse la gráfica de la serie obtenida
