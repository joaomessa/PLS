library(plumber)

# O Render injeta a porta na variável de ambiente PORT
port <- as.numeric(Sys.getenv("PORT", unset = "8080"))

pr <- plumber::plumb("api.R")
pr$run(host = "0.0.0.0", port = port)