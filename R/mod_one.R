#' one UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_one_ui <- function(id) {
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
				plotOutput(
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

#' one Server Functions
#'
#' @noRd
mod_one_server <- function(id) {
	moduleServer(id, function(input, output, session) {
		ns <- session$ns
		output$tbl <- DT::renderDT({
			laps_converted
		})
		output$plot <- renderPlot({
			ggplot(dat) +
				geom_sf(aes(color = ele)) +
				scale_color_viridis_c() +
				theme_bw()
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
one <- function(id = "one", href = "/one") {
	page(
		href = href,
		ui = mod_one_ui(id = id),
		server = function(input, output, session) {
			mod_one_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/onerun_app.R
# one()
