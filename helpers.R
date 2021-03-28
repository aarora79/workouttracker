# helper functions used by the Shiny app

shp <- function(df) {
  # returns a string with the dataframe shape: rows x cols
  if(!is.null(df)) {
    glue("{nrow(df)}x{ncol(df)}")
  } else {
    NULL
  }
}



get_names <- reactive({
  df <- read_data(ENTITY_TYPE_NAME)
  if(!is.null(df)) {
    df$name
  } else {
    NULL
  }
})

get_exercises <- reactive({
  df <- read_data(ENTITY_TYPE_EXERCISE)
  if(!is.null(df)) {
    df$exercise
  } else {
    NULL
  }
})

get_exercise_types <- reactive({
  df <- read_data(ENTITY_TYPE_TYPE)
  if(!is.null(df)) {
    df$type
  } else {
    NULL
  }
})

get_weights <- reactive({
  df <- read_data(ENTITY_TYPE_WEIGHT)
  if(!is.null(df)) {
    df$weight
  } else {
    NULL
  }
})

get_sets <- reactive({
  seq(1, 10, 1)
})

get_reps <- reactive({
  seq(1, 100, 1)
})

save_data <- function(username, df, gsheet) {
  # save the dataframe to a local file or googlesheets
  if(!is.null(df)) {
    # save to google sheets
    df %>%
      filter(name==username) %>%
      arrange(desc(date)) %>%
      sheet_write(gsheet, sheet=username)
  } else {
    flog.error("input dataframe is NULL, nothing to save")
  }
} 


read_data <- function(sheet_name) {
  out <- tryCatch(
    {
      # Just to highlight: if you want to use more than one 
      # R expression in the "try" part then you'll have to 
      # use curly brackets.
      # 'tryCatch()' will return the last evaluated expression 
      # in case the "try" part was completed successfully
      
      message(glue("read shet {sheet_name}"))
      
      ss <- gs4_get(WORKOUT_TRACKER_GOOGLE_SHEET_URL)
      df <- read_sheet(ss, sheet_name)
      df
      # The return value of `readLines()` is the actual value 
      # that will be returned in case there is no condition 
      # (e.g. warning or error). 
      # You don't need to state the return value via `return()` as code 
      # in the "try" part is not wrapped inside a function (unlike that
      # for the condition handlers for warnings and error below)
    },
    error=function(cond) {
      flog.info(glue("sheet={sheet_name} does not seem to exist:"))
      flog.error("Here's the original error message:")
      flog.error(cond)
      # Choose a return value in case of error
      return(EMPTY_DF)
    },
    warning=function(cond) {
      message(glue("sheet={sheet_name} caused a warning:"))
      flog.error("Here's the original warning message:")
      flog.error(cond)
      # Choose a return value in case of warning
      return(EMPTY_DF)
    },
    finally={
      # NOTE:
      # Here goes everything that should be executed at the end,
      # regardless of success or error.
      # If you want more than one expression to be executed, then you 
      # need to wrap them in curly brackets ({...}); otherwise you could
      # just have written 'finally=<expression>' 
      message(glue("read sheet={sheet_name}"))
    }
  )    
  message(out)
  return(out)
}
