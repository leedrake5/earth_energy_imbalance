###Prep Dynamical Elipcicity
source("https://raw.githubusercontent.com/leedrake5/sheetCrunch/master/MachineLearning.R")
library(zoo)
library(rlang)
####Set constants for equations
rho_sw = 1.027
rho_fw = 0.9998395
cp_sw = 3.85
L_fw = 334
area_ocean = 361840000000000
#volume_ocean = 18750000 + 310410900 + 264000000 + 669880000 + 71800000
volume_ocean = 1332400000000
area_earth = 509600000000
D = 3682.2
d18Oice = -30

time_derivative <- function(y)
{
    
    n<-length(y)
    
    for(i in 1:(n-1)) {
        y[i] <- y[i+1] - y[i]
        y[1:(n-1)]
        y <- y
    }
    y <- c(0, y[1:(n-1)])
    
    return(y)
}

round_any = function(x, accuracy, f=round){f(x/ accuracy) * accuracy}

###This function assumes a benthic
benthic_eei <- function(benthic_frame, age_column="age", benthic_column="d18o", smooth=1){
    benthic_frame_hold <- benthic_frame
    
    benthic_years <- data.frame(age=seq(min(benthic_frame[,age_column], na.rm=T), max(benthic_frame[,age_column], na.rm=T), 0.5))
    colnames(benthic_years) <- age_column
    benthic_frame <- merge(benthic_frame, benthic_years, by=age_column, all=T, fill=T)
    benthic_frame[,age_column] <- plyr::round_any(benthic_frame[,age_column], 0.5)
    benthic_frame <- as.data.frame(as.data.table(benthic_frame)[, lapply(.SD, base::mean, na.rm=TRUE), by=age_column ])
    benthic_frame <- benthic_frame[rev(order(benthic_frame[,age_column])),]

    benthic_frame <- benthic_frame %>%
            mutate(!!benthic_column := zoo::na.approx(!!parse_quo(benthic_column, env = caller_env())))
            
    if(smooth > 1){
        benthic_frame[,benthic_column] <- TTR::DEMA(benthic_frame[,benthic_column], smooth)
    }
        
        
    ###Assumption: d18O entirly ocean temperature
    benthic_frame$ocean_temperature <- 0.1*(benthic_frame[,benthic_column]^2) - 4.38*benthic_frame[,benthic_column] + 16.9
    benthic_frame$delta_energy_global_ocean_temperature <- ((benthic_frame$ocean_temperature - mean(benthic_frame$ocean_temperature, na.rm=T)) * volume_ocean * rho_sw * cp_sw)/10
    benthic_frame$global_energy_imbalance_ocean_temperature <- time_derivative(benthic_frame$delta_energy_global_ocean_temperature)/area_earth


    ###Assumption: d18O entirly ice volume
    benthic_frame$delta_sea_level <- D/(d18Oice/(benthic_frame[,benthic_column]-mean(benthic_frame[,benthic_column], na.rm=T))+1)-75
    benthic_frame$delta_energy_global_sea_level <- (1.1 * (benthic_frame$delta_sea_level * area_ocean * rho_fw * L_fw))/10000000
    benthic_frame$global_energy_imbalance_ice <- time_derivative(benthic_frame$delta_energy_global_sea_level)/area_earth
    
    return(benthic_frame)
}

