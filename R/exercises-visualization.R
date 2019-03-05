# Exercise: Create plots with one or two variables
# 1 continuous variable.
# 1 discrete variable.
# 2 continuous variables.
# 2 discrete variables.
# 1 continuous and 1 discrete variable.
# See the variables available
names(NHANES)

# 1 continuous
ggplot(NHANES, aes(x = Length)) +
  geom_histogram()

# 1 discrete
ggplot(NHANES, aes(x = Diabetes)) +
  geom_bar()

# 2 continuous
ggplot(NHANES, aes(x = Length, y = Weight)) +
  geom_jitter()

# 2 discrete
ggplot(___, aes(x = ___, fill = ___)) +
  ___

# 1 continous and 1 discrete
ggplot(___, aes(x = ___, y = ___)) +
  ___
