
crimes <- data.frame(state=tolower(rownames(USArrests)),USArrests)
crimes

library(maps)


states_map <- map_data("state")
plot(states_map)



################################################




ggplot(crimes,aes(map_id = state,group=group,fill=Assault)) + 
   geom_polygon(colour="black") + 
   coord_map("polyconic")   

################################################

ggplot(crimes,aes(map_id = state,fill=Assault)) + 
   geom_map(maps=states_map) + 
   scale_fill_gradient2(low="#599999",mid="grey90",high="#BB650B",  

      midpoint=median(crime$Assault)
   expand_limits(x= states_map$long, y=states_map$lat) + 
   coord_map("polyconic")

################################################

ggplot(crimes,aes(map_id = state,fill=Assault)) + 
   geom_map(maps=states_map) + 
   expand_limits(x= states_map$long, y=states_map$lat) + 
   coord_map("polyconic")
