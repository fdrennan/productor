#' @export upsert_tidyverse_data
upsert_tidyverse_data <- function(con) {
  
  stats <- 
    cran_stats(c('tidyverse')) %>% 
    transmute(
      id = glue('{start}-{package}'),
      start_date = start,
      end_date = end,
      downloads,
      package
    ) 
  
  tryCatch(expr = {
    dbExecute(
      conn = con, 
      statement = '
        create table public.package_downloads (
            id          varchar,
            start_date  date,
            end_date    date,
            downloads   integer,
            package     varchar,
            primary key (id)
        )
        '
    )
  }, error = function(err) {
    message('Disregard already exists error if below')
    message(as.character(err))
  })
  
  dbxUpsert(
    conn = con, 
    table = "package_downloads", 
    records = stats, 
    where_cols = c("id")
  )
  
}