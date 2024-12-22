# LDF Abstract Syntax Tree builder
# At this moment, decided, that iteration char is semicolon ";" not ","
# Like for me very comfortable to hit semicolon but not seeking comma char
#
# Definitions of basic syntax elements
# Example of expected markup
# app=(
#   name="App" # nolint
#   version=1  # nolint
#   keys=[
#     "--usessl"
#     "--cert"
#     "/home/suse/db.crt" # nolint
#   ]
#   rules=[
#     (type="passwordRequired" value=false);
#   ]
# )

set_node <<- function(properties = list()) {
  structure(
    list(
      type = "set",
      properties = properties
    ),
    class = "set_node"
  )
}

list_node <<- function(elements = list()) {
  structure(
    list(
      type = "array", 
      elements = elements
    ),
    class = "list_node"
  )
}

str_node <<- function(value) {
  structure(
    list(
      type = "string",
      value = value
    ),
    class = "str_node"
  )
}

int_node <<- function(value) {
  structure(
    list(
      type = "number",
      value = value
    ),
    class = "int_node"
  )
}

bool_node <<- function(value) {
  structure(
    list(
      type = "boolean",
      value = value
    ),
    class = "bool_node"
  )
}

null_node <<- function() {
  structure(
    list(
      type = "null"
    ),
    class = "null_node"
  )
}

prop_node <<- function(key, value) {
  structure(
    list(
      type = "property",
      key = key,
      value = value
    ),
    class = "prop_node"
  )
}

# Struct of specified chars (ex "*")
any_node <<- function() {
  structure(
    list(type = "any"),
    class = "any_node"
  )
}

comment_node <<- function() {
  structure(
    list(type = "comment"),
    class = "comment"
  )
}