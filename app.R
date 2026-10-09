library(plumber)

#* @apiTitle API R para Google Apps Script
#* @apiDescription Processa requisições enviadas do Google Sheets

#* Somar dois números
#* @post /somar
function(a = 0, b = 0) {
  val_a <- as.numeric(a)
  val_b <- as.numeric(b)
  
  list(
    status = "sucesso",
    resultado = val_a + val_b,
    mensagem = paste("Soma de", val_a, "com", val_b, "realizada no R!")
  )
}