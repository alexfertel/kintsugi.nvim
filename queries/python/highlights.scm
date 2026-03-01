; extends

; Keep Python string delimiters (including prefixed/triple starts) on punctuation.
(string
  (string_start) @punctuation.quote
  (string_end) @punctuation.quote)
