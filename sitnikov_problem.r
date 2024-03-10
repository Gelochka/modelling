library("deSolve")
library(ggplot2)
library("rjson") 

read_parameters <- function( ){
  
params <- fromJSON(file="parameters.json")

z_00 <- params$z_0;  e <- params$e; n <- params$n; dz<-params$dz
intial_parameters = data.frame(z_00,   e, n,dz)
print(paste("Добрый день. Вот параметры, которые вы ввели:"))
print(paste("Высота, с которой падает:", z_00))
print(paste("Скорость, с которой падает:", 0))
print(paste("Шаг по высоте:", dz))
print(paste("Эксцентриситет:", e))
print(paste("Число периодов:", n))
return(intial_parameters)
}
f1 = function(E,z,e){  
  r = 1/2* (1 - e * cos(E)) 
  fz0 =  2 * r* z[2]         #dz/dE
  fz1 = -z[1] *2 *r /  (r^2 + z[1]^2)^(3/2) #dv/dE 
  
  return(list(c(fz0, fz1)))
}
integrator <- function(z_0, E,e){
  
  yini <- c(y0 = z_0 , y1 = 0)
  stiff <- data.frame(ode(y = yini, func = f1, times = E, parms = e )) 
  
  return(stiff)
  
}




intial_parameters = read_parameters()
data = data.frame(E = 2*pi* seq(0, intial_parameters$n,1 ))
#grid setting, then integration parameters are set here as well
 


graf <- function(){
z_0= 0
i = 0 


z_V <-  ggplot(data = data) + theme_bw() + 
                xlim(-intial_parameters$z_00 -1 , intial_parameters$z_00 + 1) 

 while (z_0 < intial_parameters$z_00 ){
  
 z_0 <- z_0 +intial_parameters$dz 
  
 stiff <- integrator(z_0, E=data$E, intial_parameters$e)
 data = cbind(data, stiff)
 names(data)[names(data) == "y0"] <- "z"#paste("z",i,sep="")
 names(data)[names(data) == "y1"] <- "v"#paste("v",i,sep="") 
 #data$z_0 = as.factor(z_0)
 
 z_V <- z_V + ggtitle(paste("A phase portrait for e =", 
                             intial_parameters$e, sep=" ")) + 
   geom_point(data =  data, aes(z, v),size=1) + #, col =  z_0
             # geom_path(data =  data, aes(z, v),size=1,col = "red") +
               theme(axis.text.y= element_text(size =rel(3)),axis.text.x= element_text(size =rel(3),angle=0), 
               axis.title.y= element_text(size =rel(3)),
               axis.title.x= element_text(size =rel(3)),plot.title = element_text(size=rel(3))) 
 
 
 
 data <- subset(data, select = - c(z,v,time))
 
 i = i+1
 }
print(z_V) 
ggsave(z_V,  filename=paste("phase_space","_e_",intial_parameters$e,"_z_0_",intial_parameters$z_00,".png",sep=""),
       width = 8.5,height = 8.5) #save phase space into a file
}
graf()
