#' Generate new Short UUID
#'
#' @param n the number of short uuids to generate
#' @param short what alphabet to use
#' @export
new_short <- function(n, short = c("flickr_base58", "bitcoin58")) {
  short <- match.arg(short)
  switch(
    short,
    "flickr_base58" = short_flickr_base58_(n),
    "bitcoin58" = short_bitcoin58_(n)
  )
}


#' Convert uuid to short
#'
#' @param uuid vector of uuids
#' @param short what alphabet to use
#' @export
uuid_to_short <- function(uuid, short = c("flickr_base58", "bitcoin58")) {
  short <- match.arg(short)
  switch(
    short,
    "flickr_base58" = uuid_to_short_flickr_(uuid),
    "bitcoin58" = uuid_to_short_bitcoin58_(uuid)
  )
}

#' Convert short to uuid
#'
#' @param short_uuid vector of short-uuids
#' @param short what alphabet to use
#' @seealso [new_short()]
#' @export
short_to_uuid <- function(short_uuid, short = c("flickr_base58", "bitcoin58")) {
  short <- match.arg(short)
  switch(
    short,
    "flickr_base58" = short_flickr_to_uuid_(short_uuid),
    "bitcoin58" = short_bitcoin58_to_uuid_(short_uuid)
  )
}
