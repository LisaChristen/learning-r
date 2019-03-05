# Data visualization
source(here::here("R/package-loading.R"))


# 1 dimension plots (1 variable) -------------------------------------------------------
# density plot
ggplot(NHANES, aes(x = BMI)) +
  geom_density()

# Histogramm
ggplot(NHANES, aes(x = BMI)) +
  geom_histogram()

# bar plot
ggplot(NHANES, aes(x = Education)) +
  geom_bar()



# 2 dimension plots (2 variables) -----------------------------------------
two_nums <- ggplot(NHANES, aes(x = Age, y = BPSysAve))

two_nums +
  geom_point()

two_nums +
  geom_line()

two_nums +
  geom_hex()

two_nums +
  geom_smooth()

# 2 Categorial variables
two_categ <- ggplot(NHANES, aes(x = Education,
                                fill = Diabetes))
# 2 categories in 1 bar
two_categ +
  geom_bar()
# 3 categories in comparison
two_categ +
  geom_bar(position = position_dodge())

# mixed
two_mixed <- ggplot(NHANES, aes(x = Diabetes,
                                y = TotChol))
two_mixed +
  geom_boxplot()
NHANES %>%
  filter(!is.na(Diabetes)) %>%
  ggplot(aes(x = Diabetes, y = TotChol)) +
  geom_boxplot()

two_mixed +
  geom_jitter(width = 0.2)


# 3 or more dimensions (3 + variables) ------------------------------------

ggplot(NHANES, aes(x = BMI, y = BPSysAve, colour = HomeOwn)) +
  geom_point()

ggplot(NHANES, aes(x = BMI, y = BPSysAve, colour = HomeOwn)) +
  geom_smooth()

ggplot(NHANES, aes(x = BMI, y = BPSysAve, colour = HomeOwn)) +
  geom_smooth() +
  geom_point() +
  facet_grid(cols = vars(Gender))

colour_plot_nums <- NHANES %>%
  ggplot(aes(x = BMI, y = BPSysAve, colour = HomeOwn))

colour_plot_nums +
  geom_point()

colour_plot_nums +
  geom_smooth()

colour_plot_mixed <- NHANES %>%
  ggplot(aes(x = Gender, y = BPSysAve, colour = HomeOwn))

colour_plot_mixed +
  geom_boxplot()

colour_plot_mixed +
  geom_point(aes(alpha = Age))

# siye related to age
colour_plot_nums +
  geom_point(aes(size = Age))

colour_plot_nums +
  geom_smooth(aes(linetype = Diabetes))

# adding more layers: Plot for survey year, phs. activity, gender, BP & Homeowners
colour_plot_mixed +
  geom_boxplot() +
  facet_grid(cols = vars(SurveyYr), rows = vars(PhysActive))

# color schemes
base_boxblot <- NHANES %>%
  ggplot(aes(x = HomeOwn, fill = Education)) +
  geom_bar(position = position_dodge())
base_boxblot

base_boxblot +
  scale_fill_viridis_d()

# palettes from A to E
base_boxblot +
  scale_fill_viridis_d(option = "A")
base_boxblot +
  scale_fill_brewer(type = "qual")
base_boxblot +
  scale_fill_brewer()




# Themes, titles, labels --------------------------------------------------

basic_scatterplot <- NHANES %>%
  ggplot(aes(x = Height, y = Weight, colour = Age)) +
  geom_point(alpha = 0.5) +
  facet_grid(cols = vars (Gender)) +
  scale_colour_viridis_c()
basic_scatterplot

# change background color
# background black & white
basic_scatterplot +
  theme_bw()
# no background
basic_scatterplot +
  theme_classic()
# no square above
basic_scatterplot +
  theme_minimal()

# add labels
basic_scatterplot +
  labs(title = "This is the plot", y = "Weight (kg)", x = "Height (cm)")

# change panel
basic_scatterplot +
  labs(title = "This is the plot", y = "Weight (kg)", x = "Height (cm)") +
  theme(panel.background = element_rect(fill = "pink"),
        strip.background = element_rect(fill = "purple"))

# change legend size & colour
basic_scatterplot +
  labs(title = "This is the plot", y = "Weight (kg)", x = "Height (cm)") +
  theme(panel.background = element_rect(fill = "pink"),
        strip.background = element_rect(fill = "purple"),
        legend.text = element_text(size = 20, colour = "magenta"))

prettied_plot <- basic_scatterplot +
  labs(title = "This is the plot", y = "Weight (kg)", x = "Height (cm)") +
  theme(panel.background = element_rect(fill = "pink"),
        strip.background = element_rect(fill = "purple"),
        legend.text = element_text(size = 20, colour = "magenta"),
        axis.ticks = element_blank())

# saving
ggsave(here::here("doc/prettied_plot.png"),
       prettied_plot)
