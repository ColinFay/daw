#' about UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_about_ui <- function(id, basepath) {
	ns <- NS(id)
	fluidPage(
		menu_builder(
			basepath
		),
		htmlTemplate(
			app_sys("app/www/about.html")
			# add here other template arguments
		)
	)
}

#' about Server Functions
#'
#' @noRd
mod_about_server <- function(id) {
	moduleServer(id, function(input, output, session) {
		ns <- session$ns
	})
}

#' Page Functions
#'
#' @noRd
#' @importFrom brochure page
about <- function(id = "about", href = "/about", basepath) {
	page(
		href = href,
		ui = mod_about_ui(id = id, basepath = basepath),
		server = function(input, output, session) {
			mod_about_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/aboutrun_app.R
# about()
