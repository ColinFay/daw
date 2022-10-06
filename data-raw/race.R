## code to prepare `race` dataset goes here
library(tidyverse)
library(sf)
dat <- sf::read_sf(
	"data-raw/Belle_Ile_en_trail_Ultra_des_vagues.gpx",
	layer = "track_points"
) %>%
	tidyr::separate(
		col = time,
		into = c("date", "timepoint"),
		sep = " ",
		remove = FALSE
	) %>%
	dplyr::mutate(
		x = map_dbl(geometry, 1),
		y = map_dbl(geometry, 2)
	)
dist <- st_distance(
	tail(dat, -1),
	head(dat, -1),
	by_element = TRUE
) %>%
	units::set_units("km")

distance <- c(0, cumsum(dist))

dat <- dat %>% mutate(distance = distance)


dat <- dat %>%
	mutate(
		ele_n1 = lag(ele),
		gain = ele_n1 - ele
	)
usethis::use_data(dat, overwrite = TRUE)

library(FITfileR)
fit <- readFitFile(
	"data-raw/Belle_Ile_en_trail_Ultra_des_vagues.fit"
)
fit_records <- records(fit)

laps(fit) %>%
	tibble::rowid_to_column() %>%
	rename(
		lap = rowid
	) -> laps
usethis::use_data(laps, overwrite = TRUE)

View(laps)
library(tidyverse)
laps %>%
	select(
		total_elapsed_time
	) %>%
	tibble::rowid_to_column() %>%
	mutate(
		rowid = ceiling(rowid / 5)
	) %>%
	group_by(
		rowid
	) %>%
	summarize(
		time_in_sec = sum(total_elapsed_time)
	) %>%
	rename(
		lap = rowid
	) -> laps_converted
usethis::use_data(laps_converted, overwrite = TRUE)

track2 <- dat %>%
	st_combine() %>%
	st_cast(to = "LINESTRING") %>%
	st_sf()
usethis::use_data(track2, overwrite = TRUE)
