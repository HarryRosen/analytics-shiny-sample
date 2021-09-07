select_ui <- function(id) {
  #Establish the UI namespace
  ns <- NS(id)
  #Output of UI
  uiOutput(ns("select"))
}

select_server <-
  function(input,
           output,
           session,
           lbl = "Distribution type:",
           choices = c(
             "Normal" = "norm",
             "Uniform" = "unif",
             "Log-normal" = "lnorm",
             "Exponential" = "exp"
           )) {
    #Establish the UI namespace
    session$ns -> ns
    
    output[['select']] <- renderUI({
      f7Select(
        inputId = ns("select"),
        label = lbl,
        choices = choices
      )
    })
  }
