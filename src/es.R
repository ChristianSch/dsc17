library("cmaes")

setwd('~/Documents/Development/DataSci/dsc17/')

# lets find out if there is a correlation between price and demand
df.antibiotics <- read.csv('output/df_antibiotics_imputed.csv', row.names = NULL)
df.tengu <- read.csv('output/df_tengu_imputed.csv', row.names = NULL)
df.veldspar <- read.csv('output/df_veldspar_imputed.csv', row.names = NULL)
df.nanite <- read.csv('output/df_nanite_repair_paste_imputed.csv', row.names = NULL)
df.tritanium <- read.csv('output/df_tritanium_imputed.csv', row.names = NULL)

df.raw <- read.csv('../output/forecasts.csv', row.names = NULL)

# select the data per product, then remove the product column
# there are a total of five products in the data
df.tritanium <- df.raw[df.raw$product == 'tritanium', ]
stopifnot(dim(df.tritanium)[1] > 0)
df.tritanium <- df.tritanium[, !names(df.tritanium) %in% c("product")]

df.veldspar <- df.raw[df.raw$product == 'veldspar', ]
stopifnot(dim(df.veldspar)[1] > 0)
df.veldspar <- df.veldspar[, !names(df.veldspar) %in% c("product")]

df.antibiotics <- df.raw[df.raw$product == 'antibiotics', ]
stopifnot(dim(df.antibiotics)[1] > 0)
df.antibiotics <- df.antibiotics[, !names(df.antibiotics) %in% c("product")]

df.tengu <- df.raw[df.raw$product == 'tengu', ]
stopifnot(dim(df.tengu)[1] > 0)
df.tengu <- df.tengu[, !names(df.tengu) %in% c("product")]

df.nanite <- df.raw[df.raw$product == 'nanite repair paste', ]
stopifnot(dim(df.nanite)[1] > 0)
df.nanite <- df.nanite[, !names(df.nanite) %in% c("product")]

# fetch only the forecasted demand per product
df.tritanium_dem <- select(df.tritanium, starts_with("d"))
df.tengu_dem <- select(df.tengu, starts_with("d"))
df.veldspar_dem <- select(df.veldspar, starts_with("d"))
df.antibiotics_dem <- select(df.antibiotics, starts_with("d"))
df.nanite_dem <- select(df.nanite, starts_with("d"))

df.tritanium_dem_pos <- df.tritanium_dem[rowSums(df.tritanium_dem > 0) == 31,]
print(dim(df.tritanium_dem)[1])
print(dim(df.tritanium_dem_pos)[1])
print('---')

df.tengu_dem_pos <- df.tengu_dem[rowSums(df.tengu_dem > 0) == 31,]
print(dim(df.tengu_dem)[1])
print(dim(df.tengu_dem_pos)[1])
print('---')

df.veldspar_dem_pos <- df.veldspar_dem[rowSums(df.veldspar_dem > 0) == 31,]
print(dim(df.veldspar_dem)[1])
print(dim(df.veldspar_dem_pos)[1])
print('---')

df.antibiotics_dem_pos <- df.antibiotics_dem[rowSums(df.antibiotics_dem > 0) == 31,]
print(dim(df.antibiotics_dem)[1])
print(dim(df.antibiotics_dem_pos)[1])
print('---')

df.nanite_dem_pos <- df.nanite_dem[rowSums(df.nanite_dem > 0) == 31,]
print(dim(df.nanite_dem)[1])
print(dim(df.nanite_dem_pos)[1])


# ES
init.vector <- function(stations, p = NULL, q = NULL) {
  # creates a three-dimensional array for
  # (station, price + demand per day of january (62 entries))
  # stations: numerical ids of stations
  # p: estimated price, if NULL initalized by zeros
  # q: estimated quantity, if NULL initalized by zeros
  stations.len <- length(stations)
  v <- rep(0, stations.len * 62)
  dim(v) <- c(stations.len, 2, 31)
  
  if (is.null(p)) {
    p <- rep(0, 31)
  }
  
  if (is.null(q)) {
    q <- rep(0, 31)
  }
  
  for (s in 1:stations.len) {
    v[s, 1, ] <- p
    v[s, 2, ] <- q
  }
  
  return(v)
}

# implements the fitness
cost.function.flat <- function(x, max = TRUE) {
  # sum_s sum_t q_st * p_st
  o <- 0
  stations <- dim(x)[1]
  
  # TODO: possible improvement
  # * weight "error" by distance in IQR of estimated demand
  # by accepting everything in +- 1.5 * estimated demand (as mean)
  # and "rejecting" everything outside
  for (s in 1:stations) {
    o = o + sum(x[s, 1, ] * x[s, 2, ])
  }
  
  if (max) {
    return(o)
  }
  
  return(-o)
}

# i.e.
enc.veldspar <- init.vector(unique(df.veldspar$stationid)) # , q = df.veldspar_dem_pos)

out <- cmaes::cma_es(par = enc.veldspar, cost.function.flat, max = FALSE) #, lower = rep(length(enc.veldspar), 0)) 
