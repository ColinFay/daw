#' home UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_home_ui <- function(id, basepath) {
	ns <- NS(id)
	tagList(
		htmlTemplate(
			app_sys("app/www/template.html"),
			
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
home <- function(id = "home", href = "/", basepath) {
	page(
		href = href,
		ui = mod_home_ui(id = id, basepath = basepath),
		server = function(input, output, session) {
			mod_home_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/run_app.R
# home()
