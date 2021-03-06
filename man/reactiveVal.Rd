% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reactives.R
\name{reactiveVal}
\alias{reactiveVal}
\title{Create a (single) reactive value}
\usage{
reactiveVal(value = NULL, label = NULL)
}
\arguments{
\item{value}{An optional initial value.}

\item{label}{An optional label, for debugging purposes (see
\code{\link[=reactlog]{reactlog()}}). If missing, a label will be automatically
created.}
}
\value{
A function. Call the function with no arguments to (reactively) read
the value; call the function with a single argument to set the value.
}
\description{
The \code{reactiveVal} function is used to construct a "reactive value"
object. This is an object used for reading and writing a value, like a
variable, but with special capabilities for reactive programming. When you
read the value out of a reactiveVal object, the calling reactive expression
takes a dependency, and when you change the value, it notifies any reactives
that previously depended on that value.
}
\details{
\code{reactiveVal} is very similar to \code{\link[=reactiveValues]{reactiveValues()}}, except
that the former is for a single reactive value (like a variable), whereas the
latter lets you conveniently use multiple reactive values by name (like a
named list of variables). For a one-off reactive value, it's more natural to
use \code{reactiveVal}. See the Examples section for an illustration.
}
\examples{

\dontrun{

# Create the object by calling reactiveVal
r <- reactiveVal()

# Set the value by calling with an argument
r(10)

# Read the value by calling without arguments
r()

}

## Only run examples in interactive R sessions
if (interactive()) {

ui <- fluidPage(
  actionButton("minus", "-1"),
  actionButton("plus", "+1"),
  br(),
  textOutput("value")
)

# The comments below show the equivalent logic using reactiveValues()
server <- function(input, output, session) {
  value <- reactiveVal(0)       # rv <- reactiveValues(value = 0)

  observeEvent(input$minus, {
    newValue <- value() - 1     # newValue <- rv$value - 1
    value(newValue)             # rv$value <- newValue
  })

  observeEvent(input$plus, {
    newValue <- value() + 1     # newValue <- rv$value + 1
    value(newValue)             # rv$value <- newValue
  })

  output$value <- renderText({
    value()                     # rv$value
  })
}

shinyApp(ui, server)

}

}
