#' two UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_two_ui <- function(id, basepath) {
	ns <- NS(id)
	tagList(
		htmlTemplate(
			app_sys("app/www/arrows.html"),
			home = sprintf(
				"/%s",
				basepath
			),
			none = sprintf(
				"/%s/none",
				basepath
			) %>% gsub("//", "/", .),
			one = sprintf(
				"/%s/one",
				basepath
			) %>% gsub("//", "/", .),
			two = sprintf(
				"/%s/two",
				basepath
			) %>% gsub("//", "/", .),
			three = sprintf(
				"/%s/three",
				basepath
			) %>% gsub("//", "/", .),
			four = sprintf(
				"/%s/four",
				basepath
			) %>% gsub("//", "/", .),
			about = sprintf(
				"/%s/about",
				basepath
			) %>% gsub("//", "/", .),
			# add here other template arguments
		),
		fluidPage(
			fluidRow(
			h1("Belle Ile en trail")
		),
		fluidRow(
			column(
				6,
				DT::DTOutput(
					ns("tbl")
				)
			),
			column(
				6,
				leaflet::leafletOutput(
					ns("plot")
				)
			)
		),
		fluidRow(
			column(
				6,
				plotOutput(
					ns("eleplot")
				)
			),
			column(
				6,
				plotOutput(
					ns("lapplot")
				)
			)
		)
		)
	)
}

#' two Server Functions
#'
#' @noRd
#' @import leaflet
mod_two_server <- function(id) {
	moduleServer(id, function(input, output, session) {
		ns <- session$ns
		output$tbl <- DT::renderDT({
			laps_converted
		})
		output$plot <- leaflet::renderLeaflet({
			leaflet() %>%
				addProviderTiles("CartoDB.Positron") %>%
				addPolylines(data = track2)
		})
		output$eleplot <- renderPlot({
			ggplot(dat) +
				aes(x = time, y = ele) +
				geom_line()
		})

		output$lapplot <- renderPlot({
			laps %>%
				ggplot() +
				aes(x = lap, y = total_elapsed_time) +
				geom_col()
		})
	})
}

#' Page Functions
#'
#' @noRd
#' @importFrom brochure page
two <- function(id = "two", href = "/two", basepath) {
	page(
		href = href,
		ui = mod_two_ui(id = id, basepath = basepath),
		server = function(input, output, session) {
			mod_two_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/tworun_app.R
# two()
