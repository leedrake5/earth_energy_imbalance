###Prep Dynamical Elipcicity
source("benthic_eii_function.r")

lisiecki_stern_2016 <- read.csv("inputs/lisiecki_stern_2016.csv")

benthic_frame <- benthic_eei(benthic_frame=lisiecki_stern_2016, age_column="Age", benthic_column="Global_d18O")
colnames(benthic_frame)[1] <- "age"

####EnergyCheck
temperature_frame <- data.frame(benthic_frame[c("age", "ocean_temperature")], Type="Earth State", group="Temperature")
colnames(temperature_frame)[2] <- "value"

temperature_energy_frame <- data.frame(benthic_frame[c("age", "delta_energy_global_ocean_temperature")], Type="Energy", group="Temperature")
colnames(temperature_energy_frame)[2] <- "value"

temperature_denergy_frame <- data.frame(benthic_frame[c("age", "global_energy_imbalance_ocean_temperature")], Type="Imbalance", group="Temperature")
colnames(temperature_denergy_frame)[2] <- "value"

ice_frame <- data.frame(benthic_frame[c("age", "delta_sea_level")], Type="Earth State", group="Ice")
colnames(ice_frame)[2] <- "value"

ice_energy_frame <- data.frame(benthic_frame[c("age", "delta_energy_global_sea_level")], Type="Energy", group="Ice")
colnames(ice_energy_frame)[2] <- "value"

ice_denergy_frame <- data.frame(benthic_frame[c("age", "global_energy_imbalance_ice")], Type="Imbalance", group="Ice")
colnames(ice_denergy_frame)[2] <- "value"

en_frame <- as.data.frame(data.table::rbindlist(list(temperature_frame, temperature_energy_frame, temperature_denergy_frame, ice_frame, ice_energy_frame, ice_denergy_frame)))

en_plot <- ggplot(en_frame, aes(age, value, colour=group)) +
geom_line() +
scale_x_reverse("Age (kiloyears BP)", limits=c(150, 0)) +
facet_wrap(group~Type, scales="free_y") +
theme_light()

temperature_plot <- ggplot(temperature_frame, aes(age, value)) +
geom_line(colour="red") +
scale_x_continuous("") +
scale_y_continuous("Ocean Temperature (°C)") +
theme_light()

sea_level_plot <- ggplot(ice_frame, aes(age, value)) +
geom_line(colour="blue") +
scale_x_continuous("") +
scale_y_continuous("Δ Sea Level (m)") +
theme_light()

eei_frame <- as.data.frame(data.table::rbindlist(list(temperature_denergy_frame, ice_denergy_frame)))

energy_imbalance_plot <- ggplot(eei_frame, aes(age, value, colour=group)) +
geom_line() +
scale_colour_manual(breaks=c("Temperature", "Ice"), values=c("red", "blue")) +
scale_x_continuous("Age (ka)") +
scale_y_continuous(expression(paste("EEI (Wm"^-2*")"))) +
theme_light() +
theme(legend.position="bottom")


group_plot <- gridExtra::grid.arrange(temperature_plot, sea_level_plot, energy_imbalance_plot, ncol=1)
ggsave("outputs/calculations_check.jpeg", group_plot, height=7, width=5, device="jpg")
