; extends

; Keep declaration keywords on the storage (gold) track.
"let" @keyword.storage

; Keep Rust string quote delimiters on the punctuation track.
(string_literal
  "\"" @punctuation.quote
  "\"" @punctuation.quote
  (#set! priority 130))

; Raw string delimiters (r#", r###", "#, "###) should stay on punctuation.
((raw_string_literal) @punctuation.quote
  (#set! priority 130))

; Keep raw string inner content on the regular string track.
((raw_string_literal
  (string_content) @string)
  (#set! priority 140))
