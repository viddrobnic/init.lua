; Highlighting for my custom language side project
; See: https://github.com/viddrobnic/aoc-lang

(comment) @comment @spell

(identifier) @variable

(continue) @keyword
(break) @keyword

"fn" @keyword.function
"use" @keyword.import
["for" "while"] @keyword.repeat
"return" @keyword.return
["if" "else"] @keyword.conditional

(integer) @number
(float) @number.float
(true) @boolean
(false) @boolean
(null) @constant.builtin
(char) @character
(string) @string @spell
(escape_sequence) @string.escape

(function_literal
  (identifier) @variable.parameter)

(function_call
  function: (identifier) @function.call)

((identifier) @function.builtin
              (#any-of? @function.builtin
                "len"
                "str"
                "int"
                "char"
                "float"
                "bool"
                "is_null"
                "floor"
                "ceil"
                "round"
                "trim_start"
                "trim_end"
                "trim"
                "split"
                "push"
                "pop"
                "del"
                "print"
                "input"
              ))

(dot_index
  index: (identifier) @property)

["," ";" "."] @punctuation.delimiter
["(" ")" "{" "}" "[" "]"] @punctuation.bracket
[
  "="
  "=="
  "<"
  ">"
  "<="
  ">="
  "!"
  "-"
  "+"
  "*"
  "/"
  "%"
  "&"
  "|"
  "!="
] @operator
