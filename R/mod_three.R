#' three UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_three_ui <- function(id, basepath) {
	ns <- NS(id)
	tagList(
		menu_builder(
			basepath
		),,
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
				dygraphs::dygraphOutput(
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

#' three Server Functions
#'
#' @noRd
mod_three_server <- function(id) {
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
		output$eleplot <- dygraphs::renderDygraph({
			df <- data.frame(
				value = dat$ele
			)
			rownames(df) <- dat$time
			dygraphs::dygraph(
				df
			)
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
three <- function(id = "three", href = "/three", basepath) {
	page(
		href = href,
		ui = mod_three_ui(id = id, basepath = basepath),
		server = function(input, output, session) {
			mod_three_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/threerun_app.R
# three()
