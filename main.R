# Here is will be tests of all projects parts
source("lexer.R")
source("parser.R")

ldft <- 'app=(
   # Applications configuration
   user="admin"
   password="admin"
   keys=["--usessl"; "--cert"; "mycert.crt"]
   settings=(
      debug=true
      log_level="info"
      allowed_users="*"
   )
)'

tokens <- tokenizeldf(ldft)
result <- parseldf(tokens)

print(result)