# load packages from the "package-loading-R script"
source(here::here("R/package-loading.R"))

# to get a summary of the data frame
glimpse(NHANES)

# an easier way to refer to the dataset during analysis, opens new tap
NHANES <- NHANES
view(NHANES)


# Pipe operator -----------------------------------------------------------
# pipe operator helping to make code more readible and create comments
colnames(NHANES)
NHANES %>% colnames() # use of pipe operator

# standard R way of "chaining" functions together
glimpse(head(NHANES))

NHANES %>%
  head()
glimpse()


# Mutate () function ------------------------------------------------------
# change height unit into meters/ modify an existing variable to create a new variable
NHANES_changed <- NHANES %>%
  mutate(Height_meters = Height/100)
# see the changes in the table file on the right side


# create a new variable based on a condition
NHANES_changed <- NHANES_changed %>%
  mutate(HighlyActive = if_else(PhysActiveDays >= 5, "yes", "no"))

# create of replace multiple variables by using ","
NHANES_changed <- NHANES_changed %>%
  mutate(new_column = "only one variable",
         Height = Height/100,
         UrineVolAverage = (UrineVol1 + UrineVol2/2))

# Select (): to select specific data by the variable ----------------------

# select columns/ Variables/ by name, without quotes
NHANES_characteristics <- NHANES %>%
  select(Age, Gender, BMI)

# To not select a variable, use minus (-)
NHANES %>%
  select(-HeadCirc)

# to select similar names, use "mathcing" functions
NHANES %>%
  select(starts_with("BP"), contains ("Vol"))

?select_helpers



# Rename (): Rename specific columns --------------------------------------
# rename using the form: "newname = oldname"
NHANES_rename <- NHANES %>%
  rename(NumberBabies = nBabies)




# Filter (): Filtering/subsetting the data by row -------------------------
# when gender is equal to
NHANES %>%
  filter(Gender == "female")

# when gender is unequal to
NHANES %>%
  filter(Gender != "female")

# when BMI is equal to
NHANES %>%
  filter(BMI == 25)

# when BMI is greater than
NHANES %>%
  filter(BMI >= 25)

# when BMI is 25 and gender is female
NHANES %>%
  filter(BMI == 25 & Gender == "female")

# when BMI is 25 or gender is female
NHANES %>%
  filter(BMI == 25| Gender == "female")

# Arrange (): Arrange/Sort data by columns --------------------------------
#smallest value on top (ascending order)
NHANES %>%
  arrange(Age) %>%
  select(Age)

# biggest to smallest (descending order)
NHANES %>%
  arrange(desc(Age, Gender)) %>%
  select(Age, Gender)


  # Group function (): group by (), summarize -------------------------------
# Create a summary of the data, alone or by a group(s)
NHANES <- NHANES
NHANES %>%
  summarise(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm = TRUE))

# combine with group_by ()
NHANES %>%
  group_by(Gender) %>%
  summarise(MaxAge = max(Age, na.rm = TRUE),
            MeanBMI = mean(BMI, na.rm = TRUE))

NHANES %>%
  group_by(Gender, Diabetes) %>%
  summarise(MaxAge = max(Age, na.rm = TRUE),
            meanBMI = mean(BMI, na.rm = TRUE))


# Gather (): Converting from wide to long form ----------------------------
# option 1: excluding by minus
table4b
table4b %>%
  gather(key = year, value = population, -country)
# option 2 without minus
table4b %>%
  gather(key = year, value = population, '1999', '2000')

# keep only variables of interest
NHANES_char <- NHANES %>%
  select(SurveyYr, Gender, Age, Weight, Height, BMI, BPSysAve)
NHANES_char

# Convert to long formate excluding year & gender
NHANES_long <- NHANES_char %>%
  gather(Measure, Value, -SurveyYr, -Gender)
NHANES_long

# calculate mean on each measure by gender & year
NHANES_long %>%
  group_by(SurveyYr, Gender, Measure) %>%
  summarise(MeanValues = mean(Value, na.rm = TRUE))


