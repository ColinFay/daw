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
    htmlTemplate(
			app_sys("app/www/arrows.html"),
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
    htmlTemplate(
    app_sys("app/www/about.html"),
    body = tagList()
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
