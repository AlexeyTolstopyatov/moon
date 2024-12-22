# Here is will be tests of all projects parts
source("lexer.R")

ldft <- 'app=(
   # объект
   user="admin";
   password="admin";
   keys=["--usessl";"--cert";"mycert.crt";];
   settings=(
      debug=true;
      log_level="info";
      allowed_users = *;
   )
)'

print(tokenize(ldft))