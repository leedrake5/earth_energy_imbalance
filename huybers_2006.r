source("benthic_eei_function.r")


###Strict Age Model, no elliptical corrections
huybers_2006 <- read.csv("inputs/huybers_2006.csv")

###Adjust Huybers average to expected range (just adding a scalar)
huybers_2006$Benthic_adjust <- huybers_2006$Benthic+3.94

benthic_frame <- benthic_eei(benthic_frame=huybers_2006, age_column="Age", benthic_column="Benthic_adjust")
colnames(benthic_frame)[1] <- "age"
length(unique(diff(benthic_frame$age)))


temperature_denergy_frame <- data.frame(benthic_frame[c("age", "global_energy_imbalance_ocean_temperature")], Type="Imbalance", group="Temperature")
colnames(temperature_denergy_frame)[2] <- "value"


ice_denergy_frame <- data.frame(benthic_frame[c("age", "global_energy_imbalance_ice")], Type="Imbalance", group="Ice")
colnames(ice_denergy_frame)[2] <- "value"


eei_frame <- as.data.frame(data.table::rbindlist(list(temperature_denergy_frame, ice_denergy_frame)))

energy_imbalance_plot <- ggplot(eei_frame, aes(age, value, colour=group)) +
geom_line() +
scale_colour_manual(breaks=c("Temperature", "Ice"), values=c("red", "blue")) +
scale_x_continuous("Age (ka)", labels=scales::comma) +
scale_y_continuous(expression(paste("EEI (Wm"^-2*")"))) +
theme_light() +
theme(legend.position="bottom") +
ggforce::facet_zoom(xlim = c(110, 180), zoom.size = 0.6)

ggsave("outputs/huybers_mis05.jpeg", energy_imbalance_plot, height=5, width=7, device="jpg")


energy_imbalance_plot <- ggplot(eei_frame, aes(age, value, colour=group)) +
geom_line() +
scale_colour_manual(breaks=c("Temperature", "Ice"), values=c("red", "blue")) +
scale_x_continuous("Age (ka)", labels=scales::comma) +
scale_y_continuous(expression(paste("EEI (Wm"^-2*")"))) +
theme_light() +
theme(legend.position="bottom") +
ggforce::facet_zoom(xlim = c(0, 150), zoom.size = 0.6)

ggsave("outputs/huybers_recent.jpeg", energy_imbalance_plot, height=5, width=7, device="jpg")
