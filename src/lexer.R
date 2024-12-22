source("ast.R")

# nolint: spaces_left_parentheses_linter.
# nolint: line_length_linter.

tokenizeldf <- function(text) {
  tokens <- list()
  pos <- 1

  while (pos <= nchar(text)) {
    char <- substr(text, pos, pos)
    if (char == "(") {
      tokens <- append(tokens, list(list(type = "open_brace", value = char)))
      pos <- pos + 1
    } else if (char == ")") {
      tokens <- append(tokens, list(list(type = "close_brace", value = char)))
      pos <- pos + 1
    } else if (char == "[") {
      tokens <- append(tokens, list(list(type = "open_bracket", value = char)))
      pos <- pos + 1
    } else if (char == "]") {
      tokens <- append(tokens, list(list(type = "close_bracket", value = char)))
      pos <- pos + 1
    } else if (char == '"') {
      # Handle strings
      pos <- pos + 1
      start <- pos
      while (pos <= nchar(text)) {
        if (substr(text, pos, pos) == '"') {
          break # string handled
        }
        pos <- pos + 1
      }
      value <- substr(text, start, pos - 1)
      tokens <- append(tokens, list(list(type = "string", value = value)))
      pos <- pos + 1
    } else if (char == "#") {
      # Handle comments
      pos <- pos + 1
      start <- pos
      while (pos <= nchar(text)) {
        if (substr(text, pos, pos) == "\n") {
          break
        }
        pos <- pos + 1
      }
      value <- substr(text, start, pos - 1)
      tokens <- append(tokens, list(list(type = "comment", value = value)))
    } else if (grepl("^[0-9.-]+$", char)) {
      # Handle numbers
      start <- pos
      while (pos <= nchar(text) &&
               grepl("^[0-9.-]+$",
                     substr(text, pos, pos))) {
        pos <- pos + 1
      }
      value <- substr(text, start, pos - 1)
      tokens <- append(tokens, list(list(type = "number", value = value)))
    } else if (grepl("^[a-zA-Z0-9_]+$", char)) {
      # Handle keys
      start <- pos
      while (pos <= nchar(text) &&
               grepl("^[a-zA-Z0-9_]+$", substr(text, pos, pos))) {
        pos <- pos + 1
      }
      value <- substr(text, start, pos - 1)
      tokens <- append(tokens, list(list(type = "key", value = value)))
    } else if (char == "=") {
      tokens <- append(tokens, list(list(type = "colon", value = char)))
      pos <- pos + 1
    } else if (grepl("^[;]$", char)) {
      tokens <- append(tokens, list(list(type = "comma", value = char)))
      pos <- pos + 1
      #   } else if (grepl("^\\s$", char)) {
      #     # ignore whitespaces
      #     stop(paste0("Invalid character: ", char))
      #   } else {
      #     pos <- pos + 1
      #   }
      # }
    } else if (grepl("^\\s$", char)) {
        pos <- pos + 1
    } else {
      stop(paste0("Invalid character: ", char))
    }
  }

  tokens
}