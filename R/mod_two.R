#' two UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_two_ui <- function(id) {
	ns <- NS(id)
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
two <- function(id = "two", href = "/two") {
	page(
		href = href,
		ui = mod_two_ui(id = id),
		server = function(input, output, session) {
			mod_two_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/tworun_app.R
# two()
