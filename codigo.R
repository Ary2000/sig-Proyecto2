library(tmap)
library(sf)
library(mapview)
library(leaflet)
library(leafpop)

archivo <- st_read('./Distritos/Distritos_CR.shp')

tmap_mode("plot")

mapaAcumulado = tm_shape(archivo) + 
                tm_polygons(col = "ACUMULADOS") +
                tm_layout(legend.outside = TRUE)

mapaRecuperado = tm_shape(archivo) + 
                 tm_polygons(col = "RECUPERADO") +
                 tm_layout(legend.outside = TRUE)

mapaFallecidos = tm_shape(archivo) + 
                 tm_polygons(col = "FALLECIDOS") +
                 tm_layout(legend.outside = TRUE)

mapaActivos = tm_shape(archivo) + 
              tm_polygons(col = "ACTIVOS") +
              tm_layout(legend.outside = TRUE)

tmap_save(mapaAcumulado, "Mapa_Acumulado.png")
tmap_save(mapaRecuperado, "Mapa_Recuperados.png")
tmap_save(mapaFallecidos, "Mapa_Fallecidos.png")
tmap_save(mapaActivos, "Mapa_Activos.png")

#Seccion mapa dinamico

mapaA = mapview::mapview(archivo, zcol = "ACUMULADOS",
                 popup = popupTable(archivo, zcol = c("NOM_PROV","NOM_DIST","ACUMULADOS","RECUPERADO","FALLECIDOS","ACTIVOS")))

mapaB = mapview::mapview(archivo, zcol = "RECUPERADO",
                         popup = popupTable(archivo, zcol = c("NOM_PROV","NOM_DIST","ACUMULADOS","RECUPERADO","FALLECIDOS","ACTIVOS")))

mapaC = mapview::mapview(archivo, zcol = "FALLECIDOS",
                         popup = popupTable(archivo, zcol = c("NOM_PROV","NOM_DIST","ACUMULADOS","RECUPERADO","FALLECIDOS","ACTIVOS")))

mapaD = mapview::mapview(archivo, zcol = "ACTIVOS",
                         popup = popupTable(archivo, zcol = c("NOM_PROV","NOM_DIST","ACUMULADOS","RECUPERADO","FALLECIDOS","ACTIVOS")))

mapaFinal = mapaA + mapaB + mapaC + mapaD

mapshot(mapaFinal, url = paste0(getwd(), "/index.html"))