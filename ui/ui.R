# ui.R
#Declare al of the tab code into the global environment
sapply(list.files('ui/components', pattern = "*.R", full.names = T),
       source,
       globalenv())
sapply(list.files('ui/tabs', pattern = "*.R", full.names = T),
       source,
       globalenv())

#Assign the tabs to the UI
ui <- function(lbl = "E-commerce",
               opts = list(
                 theme = "auto",
                 dark = FALSE,
                 filled = FALSE,
                 color = "#007aff",
                 touch = list(
                   tapHold = TRUE,
                   tapHoldDelay = 750,
                   iosTouchRipple = FALSE
                 ),
                 iosTranslucentBars = FALSE,
                 navbar = list(iosCenterTitle = TRUE,
                               hideNavOnPageScroll = TRUE),
                 toolbar = list(hideNavOnPageScroll = FALSE),
                 pullToRefresh = TRUE
               )) {
  f7Page(title = lbl,
         options = opts,
         f7SingleLayout(
           navbar = nav(),
           f7Tabs(
             id = "tabs",
             style = "strong",
             animated = FALSE,
             swipeable = TRUE,
             intro_tab,
             tab_1,
             tab_2,
             tab_3,
             tab_4,
             tab_5
           )
         ))
}
