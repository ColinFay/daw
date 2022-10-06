#' helpers 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
menu_builder <- function(basepath){
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
		)
}