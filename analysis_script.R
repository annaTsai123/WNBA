library(ggplot2)
library(readxl)
library(dplyr)
# Load the scraped data
team1_data <- read_excel("e://Seattle_Storm.xlsx")
team2_data <- read_excel("e://Phoenix_Mercury.xlsx")
team3_data <- read_excel("e://Washington_Mystics.xlsx")

teams_data <- bind_rows(team1_data, team2_data, team3_data)


# Convert 3P column to numeric
teams_data$`3P` <- as.numeric(teams_data$`3P`)

# Plot distribution of 3-pointers made
ggplot(teams_data, aes(x = `3P`)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  ggtitle("Distribution of 3-Pointers") +
  xlab("Number of 3-Pointers") +
  ylab("Frequency") +
  theme_minimal()

# Save the plot as an image
ggsave("3p_distribution.png")


# Convert relevant columns to numeric
teams_data$MP <- as.numeric(teams_data$MP)
teams_data$TRB <- as.numeric(teams_data$TRB)

# Randomly select a player
set.seed(123)
random_player <- sample(teams_data$Player, 1)

# Create scatter plot
ggplot(teams_data, aes(x = MP, y = TRB)) +
  geom_point() +
  geom_point(data = teams_data[teams_data$Player == random_player, ], color = "red", size = 3) +
  geom_text(aes(label = ifelse(Player == random_player, as.character(Player), '')), hjust = 1.2, vjust = 1.2) +
  ggtitle("Minutes Played vs Total Rebounds") +
  xlab("Minutes Played") +
  ylab("Total Rebounds")

# Save the plot as an image
ggsave("mp_vs_rebounds.png")
