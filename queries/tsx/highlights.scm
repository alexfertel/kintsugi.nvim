; extends

; Keep declaration keywords on the storage (gold) track.
[
  "let"
  "const"
] @keyword.storage

; Keep string quote delimiters on the punctuation track.
(string
  [
    "'"
    "\""
  ] @punctuation.quote)

; Keep template-literal backticks on the punctuation track.
(template_string
  "`" @punctuation.quote)
