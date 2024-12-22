# LDF Syntax analyser
# Represents basic algorithm for detecting token bindings
# For a first time i will write this.

source("ast.R")   # get abstract syntax tree references
source("lexer.R") # get lexems analyser


# Warning
# Here is Syntax reader seeking literally built-in lexem's types.
# Not ";" just "colon"

parseldf <<- function(tokens) {
  pos <- 1
  next_token <- function() {
    if (pos > length(tokens)) {
      return(NULL)
    }
    token <- tokens[[pos]]
    pos <<- pos + 1
    return(token)
  }

  peek_token <- function() {
    if (pos > length(tokens)) {
      return(NULL)
    }
    tokens[[pos]]
  }

  parse_value <- function() {
    token <- peek_token()
    if (is.null(token)) {
      stop("Unexpected EOI")
    }
    if (token$type == "string") {
      next_token()
      return(str_node(token$value))
    } else if (token$type == "number") {
      next_token()
      return(int_node(as.numeric(token$value)))
    } else if (token$type == "open_brace") {
      return(parse_object())
    } else if (token$type == "open_bracket") {
      return(parse_array())
    } else if (token$type == "key") {
      # include (*)
      next_token()
      return(any_node())
    }
    stop(token$type) # warn: 
  }

  parse_property <- function() {
    key_token <- next_token()
    if (is.null(key_token) || key_token$type != "key") {
      stop("Expected key")
    }
    if (is.null(next_token()) || peek_token()$type != "colon") {
      stop("Expected '='")
    }
    value <- parse_value()
    return(prop_node(key_token$value, value))
  }

  parse_object <- function() {
    if (is.null(next_token()) || peek_token()$type != "open_brace") {
      stop("Expected '('")
    }

    properties <- list()
    while (peek_token()$type != "close_brace") {
      properties <- append(properties, list(parse_property()))
      if (peek_token()$type == "comma") {
        next_token()
      }
    }

    if (is.null(next_token()) || peek_token()$type != "close_brace") {
      stop("Expected ')'")
    }
    return(obj_node(properties))
  }

  parse_array <- function() {
    if (is.null(next_token()) || peek_token()$type != "open_bracket") {
      stop("Expected '['")
    }
    elements <- list()
    while (peek_token()$type != "close_bracket") {
      elements <- append(elements, list(parse_value()))
      if (peek_token()$type == "comma") {
        next_token()
      }
    }
    if (is.null(next_token()) || peek_token()$type != "close_bracket") {
      stop("Expected ']'")
    }
    return(list_node(elements))
  }


  root <- parse_value()
  if (!is.null(peek_token())) {
    stop("Unexpected token at the end")
  }
  return(root)
}