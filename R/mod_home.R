#' home UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_home_ui <- function(id) {
	ns <- NS(id)
	tagList(
		h1("DESTROY ALL WIDGETS!"),
		tags$ul(
			tags$li(
				tags$a(
					"No widget",
					href = "/none"
				)
			),
			tags$li(
				tags$a(
					"One widget",
					href = "/one"
				)
			),
			tags$li(
				tags$a(
					"Two widgets",
					href = "/two"
				)
			),
			tags$li(
				tags$a(
					"Three widgets",
					href = "/three"
				)
			),
			tags$li(
				tags$a(
					"Four widgets",
					href = "/four"
				)
			)
		)
	)
}

#' home Server Functions
#'
#' @noRd
mod_home_server <- function(id) {
	moduleServer(id, function(input, output, session) {
		ns <- session$ns
	})
}

#' Page Functions
#'
#' @noRd
#' @importFrom brochure page
home <- function(id = "home", href = "/") {
	page(
		href = href,
		ui = mod_home_ui(id = id),
		server = function(input, output, session) {
			mod_home_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/run_app.R
# home()
