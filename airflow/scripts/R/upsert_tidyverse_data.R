library(productor)

(function() {
  con <- 
    postgres_connector(
      POSTGRES_HOST = Sys.getenv('POSTGRES_HOST'),
      POSTGRES_PORT = Sys.getenv('POSTGRES_PORT'),
      POSTGRES_USER = Sys.getenv('PRODUCTOR_POSTGRES_USER'),
      POSTGRES_PASSWORD = Sys.getenv('PRODUCTOR_POSTGRES_PASSWORD'),
      POSTGRES_DB = Sys.getenv('PRODUCTOR_POSTGRES_DB')
    )
  
  on.exit(expr = {
    message('Disconnecting')
    dbDisconnect(conn = con)
  })
  
  upsert_tidyverse_data(con)
  
})()
