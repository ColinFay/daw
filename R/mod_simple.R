#' simple UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_simple_ui <- function(
	id,
	basepath
) {
	ns <- NS(id)
	tagList(
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
		fluidPage(
			fluidRow(
				h1("Belle Ile en trail")
			),
			fluidRow(
				column(
					6,
					tableOutput(
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
	)
}

#' simple Server Functions
#'
#' @import ggplot2
#' @noRd
mod_simple_server <- function(
	id
) {
	moduleServer(id, function(input, output, session) {
		ns <- session$ns
		output$tbl <- renderTable({
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
simple <- function(id = "simple", href = "/none", basepath) {
	page(
		href = href,
		ui = mod_simple_ui(id = id, basepath = basepath),
		server = function(input, output, session) {
			mod_simple_server(id = id)
		}
	)
}


# Add this to the brochureApp call in R/simplerun_app.R
# simple()
