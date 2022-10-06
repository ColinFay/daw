#' four UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_four_ui <- function(id) {
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
				dygraphs::dygraphOutput(
					ns("eleplot")
				)
			),
			column(
				6,
				plotly::plotlyOutput(
					ns("lapplot")
				)
			)
		)
	)
}

#' four Server Functions
#'
#' @noRd
mod_four_server <- function(id) {
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

		output$lapplot <- plotly::renderPlotly({
			g <- laps %>%
				ggplot() +
				aes(x = lap, y = total_elapsed_time) +
				geom_col()
			plotly::ggplotly(g)
		})
	})
}

#' Page Functions
#'
#' @noRd
#' @importFrom brochure page
four <- function(id = "four", href = "/four") {
	page(
		href = href,
		ui = mod_four_ui(id = id),
		server = function(input, output, session) {
			mod_four_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/fourrun_app.R
# four()
