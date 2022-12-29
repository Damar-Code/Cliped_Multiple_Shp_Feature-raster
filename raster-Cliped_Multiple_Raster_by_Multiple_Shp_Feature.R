lapply(c("raster","rgdal","lidR","sf"), 
       require, character.only = TRUE)

# Read File
shp <- st_read("path/raster/")
raster <- raster("path/shp/")
OutputPath = "path/output/"

Ras.Clip.by.Multi.Feature <- function(shp, raster) {
  for (i in Plot@data$Plot) {
    #try to finish all loop ignoring the error
    tryCatch({
      feature <- Plot[(Plot@data$Plot==i),]
      feature = sp::spTransform(feature, raster::crs(raster))
      mask <- raster::mask(raster,feature) 
      crop <- raster::crop(mask,feature) # Extance Adjusment
      writeRaster(crop, paste(OutputPath,i,".tif",sep=""))
      print(paste(i,"Raster already Created",sep=" "))
      
    }, 
    #Print error if any 
    error=function(e){cat(i,conditionMessage(e), "/n")})
  }
}
Ras.Clip.by.Multi.Feature(shp,raster)

