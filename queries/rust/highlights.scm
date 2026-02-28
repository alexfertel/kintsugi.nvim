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
; `&mut` follows VS Code Kintsugi's yellow/gold intent.
(reference_expression
  "&" @keyword.modifier)

(reference_type
  "&" @keyword.modifier)
