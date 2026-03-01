; extends

; Keep declaration keywords on the storage (gold) track.
"let" @keyword.storage

; Keep Rust string quote delimiters on the punctuation track.
(string_literal
  "\"" @punctuation.quote
  "\"" @punctuation.quote)
