source("benthic_eei_function.r")


###Extensive benthic δ18O records, note that ice-based calcuations irrelevant past 18 mya.
zachos_2001 <- read.csv("inputs/zachos_2001.csv")
zachos_2001$Age <- zachos_2001$Age*1000
#zachos_2001 <- zachos_2001[complete.cases(zachos_2001$d18O.5pt),]

benthic_frame <- benthic_eei(benthic_frame=zachos_2001, age_column="Age", benthic_column="d18O", smooth=30)
colnames(benthic_frame)[1] <- "age"
length(unique(diff(benthic_frame$age)))


temperature_denergy_frame <- data.frame(benthic_frame[c("age", "global_energy_imbalance_ocean_temperature")], Type="Imbalance", group="Temperature")
colnames(temperature_denergy_frame)[2] <- "value"


ice_denergy_frame <- data.frame(benthic_frame[c("age", "global_energy_imbalance_ice")], Type="Imbalance", group="Ice")
colnames(ice_denergy_frame)[2] <- "value"


eei_frame <- as.data.frame(data.table::rbindlist(list(temperature_denergy_frame, ice_denergy_frame)))

energy_imbalance_plot <- ggplot(eei_frame, aes(age/1000, value, colour=group)) +
geom_line() +
scale_colour_manual(breaks=c("Temperature", "Ice"), values=c("red", "blue")) +
scale_x_continuous("Age (mya)", labels=scales::comma) +
scale_y_continuous(expression(paste("EEI (Wm"^-2*")"))) +
theme_light() +
theme(legend.position="bottom") +
ggforce::facet_zoom(xlim = c(50, 60), zoom.size = 0.6)

ggsave("outputs/zachos_petm.jpeg", energy_imbalance_plot, height=5, width=7, device="jpg")
