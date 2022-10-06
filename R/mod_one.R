#' one UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_one_ui <- function(id, basepath) {
	ns <- NS(id)
	fluidPage(
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
one <- function(id = "one", href = "/one", basepath) {
	page(
		href = href,
		ui = mod_one_ui(id = id, basepath = basepath),
		server = function(input, output, session) {
			mod_one_server(id = id)
		}
	)
}

# Add this to the brochureApp call in R/onerun_app.R
# one()
