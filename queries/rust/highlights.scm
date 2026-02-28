; extends

; Keep Rust type-introducing keywords on the "storage/type keyword" track.
[
  "struct"
  "enum"
  "union"
  "trait"
  "type"
] @keyword.type

; Keep mutability markers aligned with the storage keyword color.
[
  "mut"
  "ref"
] @keyword.modifier

; In signatures/refs, paint the reference sigil as a modifier keyword so
; `&mut` keeps the sigil on operator (orange) while `mut` remains gold.
(reference_expression
  "&" @operator)

(reference_type
  "&" @operator)
