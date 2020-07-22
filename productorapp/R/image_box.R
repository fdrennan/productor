#' @export image_box
image_box <- function(url = NULL, image_link = NULL, title = NULL, image_width = '100%', box_width = 12) {
  box(tags$a(
    href = url,
    tags$image(src = image_link,
               title = title,
               width = image_width)
  ),
  width = box_width)
}

#' @export airflow_image_box
airflow_image_box <- function() {
  AIRFLOW_HOST <- Sys.getenv('AIRFLOW_HOST')
  image_box(
    url = glue("http://{AIRFLOW_HOST}:8080"),
    image_link = "https://ndexr-images.s3.us-east-2.amazonaws.com/airflow.png",
    title = 'Airflow',
    image_width = '85%',
    box_width = 6
  )
}

#' @export repo_image_box
repo_image_box <- function() {
  image_box(
    url = "https://github.com/fdrennan/productor",
    image_link = "https://ndexr-images.s3.us-east-2.amazonaws.com/github.png",
    title = "Get the Repo",
    image_width = '100%',
    box_width = 6
  )
}
