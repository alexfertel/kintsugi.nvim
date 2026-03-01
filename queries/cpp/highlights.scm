; extends

; Keep C++ string/char quote delimiters on the punctuation track.
(string_literal
  "\"" @punctuation.quote
  "\"" @punctuation.quote)

(char_literal
  "'" @punctuation.quote
  "'" @punctuation.quote)
