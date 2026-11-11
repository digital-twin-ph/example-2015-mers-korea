args <- commandArgs(trailingOnly=TRUE); src <- args[1]; out <- args[2]
env <- new.env(); objs <- load(src, envir=env)
cat("objects:", objs, "\n")
walk <- function(x, name){
  if (is.data.frame(x)) {
    cat("\n==", name, ":", nrow(x), "rows x", ncol(x), "columns\n")
    for (col in names(x)) cat(sprintf("  %-22s %-10s missing %d\n", col, class(x[[col]])[1], sum(is.na(x[[col]]))))
    f <- file.path(out, paste0(gsub("[^A-Za-z0-9_]", "_", name), ".csv"))
    write.csv(x, f, row.names=FALSE, na=""); cat("  written:", basename(f), "\n")
  } else if (is.list(x)) for (n in names(x)) walk(x[[n]], paste0(name, "_", n))
  else cat("\n==", name, ":", class(x)[1], "\n")
}
for (o in objs) walk(get(o, envir=env), o)
