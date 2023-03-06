library(jsonlite)
library(httr)
library(xts)
#Interfaces de consulta apra la obtención de series puntuales/areales de observaciones y pronósticos, generadas por el Sistema de Información y Alerta Hidrológico de CdP (INA).
#Interfaz para la obtención de serie de datos puntuales a través de API SSIyAH-INA. Requiere Id de Serie en DB meteorology, fecha de inicio y fecha de fin y nivel de agregación (opcional). Devuelve un objeto TimeSeries (xts R). Admite agregación diaria, semanal y mensual ('Daily','Weekly','Monthly').  
getDBPointSerie<-function(Id,Start,End,Agg='none',Fill='yes',configFile='Config.json'){
  data=list()  
  config=fromJSON(configFile)
  URI=paste0(config$api$url,"/obs/puntual/series/",Id,"/observaciones?timestart=",as.Date(Start),"&timeend=",as.Date(End)+1)
  request=GET(URI,add_headers("Authorization"=config$api$token),accept_json())
  x=fromJSON(content(request,"text"))
  data=xts(x=x$valor,order.by=as.Date(x$timestart)) #transforma consulta a objeto ts
  if(Agg!='none'){
    data=AggTimeSeries(data,Agg)
  }
  if(Fill=='yes'){
    return(na.approx(data))
  }
  else{
    return(data)
  }
}
#Interfaz para la obtención de serie de datos puntuales a través de API SSIyAH-INA. Requiere Id de Serie en DB meteorology, fecha de inicio y fecha de fin y nivel de agregación (opcional). Devuelve un objeto TimeSeries (xts R). Admite agregación diaria, semanal y mensual ('Daily','Weekly','Monthly').  
getDBArealSerie<-function(Id,Start,End,Agg='none',Fill='yes',configFile='Config.json'){
  data=list()  
  config=fromJSON(configFile)
  URI=paste0(config$api$url,"/obs/areal/series/",Id,"?timestart=",as.Date(Start),"&timeend=",as.Date(End)+1)
  request=GET(URI,add_headers("Authorization"=config$api$token),accept_json())
  x=fromJSON(content(request,"text"))
  data=xts(x=x$observaciones$valor,order.by=as.Date(x$observaciones$timestart)) #transforma consulta a objeto ts
  if(Agg!='none'){
    data=AggTimeSeries(data,Agg)
  }
  if(Fill=='yes'){
    return(na.approx(data))
  }
  else{
    return(data)
  }
}
#Rutina para la obtención de corridas (previsiones/simulaciones). VarId: 4 (caudal) 2 (nivel)  
getDBLastForecast<-function(StId,CalId,RunId,Start=Sys.Date()+1,End=Sys.Date()+15,Agg='none',Fill='yes',configFile='Config.json',VarId=4,Qualy='main'){
  data=list()  
  config=fromJSON(configFile)
  URI=paste0(config$api$url,"/sim/calibrados/",CalId,"/corridas/last?estacion_id=",StId,"&var_id=",VarId,"&qualifier=",Qualy,sep="")
  request=GET(URI,add_headers("Authorization"=config$api$token),accept_json())
  x=fromJSON(content(request,"text"))
  data=xts(x=as.numeric(x$series$pronosticos[[1]][,3]),order.by=as.Date(x$series$pronosticos[[1]][,1])) #transforma consulta a objeto ts
  if(Agg!='none'){
    data=AggTimeSeries(data,Agg)
  }
  if(Fill=='yes'){
    return(na.approx(data))
  }
  else{
    return(data)
  }
}
