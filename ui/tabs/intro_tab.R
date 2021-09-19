rand_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis 
suscipit nisi vel lacinia laoreet. Vivamus facilisis ipsum 
at massa condimentum, id tempus libero laoreet. Sed quis odio 
et risus mattis porttitor. Nam eu tempor nisi, at vestibulum nunc. 
Interdum et malesuada fames ac ante ipsum primis in faucibus. 
Nam ac nulla egestas, faucibus sem at, ultrices massa."

intro_tab<-f7Tab(
  tabName = "Guide",
  icon = f7Icon("info"),
  active = TRUE,
  f7Shadow(
    intensity = 10,
    hover = TRUE,
    f7Card(
      title = NULL,
      h3("Welcome to Our E-Commerce Tool"),
      h5(rand_text),
      h4("Overview"),
      h5(rand_text),
      h4("Region"),
      h5(rand_text),
      h4("Customers"),
      h5(rand_text),
      h4("Trends"),
      h5(rand_text),
      h4("Performance"),
      h5(rand_text)
    )
  )
  
  
)
