# LDF Abstract Syntax Tree
#
# Definitions of basic syntax elements
# Example of expected markup
# app=(
#   name="App";
#   version=1;
#   keys=[
#     "--usessl"; 
#     "--cert"; 
#     "/home/suse/db.crt"
#   ];
#   rules=[
#     (type="passwordRequired"; value=false);
#   ];
# );

obj_node <- function(properties = list()) {
  structure(list(type = "object", properties = properties), class = "obj_node")
}

list_node <- function(elements = list()) {
  structure(list(type = "array", elements = elements), class = "list_node")
}

str_node <- function(value) {
  structure(list(type = "string", value = value), class = "str_node")
}

int_node <- function(value) {
  structure(list(type = "number", value = value), class = "int_node")
}

bool_node <- function(value) {
  structure(list(type = "boolean", value = value), class = "bool_node")
}

null_node <- function() {
  structure(list(type = "null"), class = "null_node")
}

prop_node <- function(key, value) {
  structure(list(
                 type = "property",
                 key = key, value = value),
  class = "prop_node")
}

# Struct of specified chars (ex "*")
any_node <- function() {
  structure(list(type = "any"), class = "any_node")
}


# test
my_object <- obj_node(properties = list(
  prop_node(key = "name", value = str_node("John")),
  prop_node(key = "age", value = int_node(30)),
  prop_node(key = "is_active", value = bool_node(TRUE)),
  prop_node(key = "address", value = null_node())
)
)

print(my_object)