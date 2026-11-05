// See https://github.com/typst/packages/tree/main/packages/preview/glossarium
#import "@preview/glossarium:0.5.10": gls, glspl, make-glossary, print-glossary, register-glossary
#show: make-glossary

#import "glossary-definitions.typ": gls-entries

// Hints:
// * Add list of terms in file glossary-definitions.typ
// * Usage within text will then be #gls(<key>) or plurals #glspl(<key>)

// Output the glossary. The entries will be sorted by key.
//
// FIX left alignment of glossary:
//      With glossary 0.5.1 it is necessary
//      to overwrite figure captions to be aligned left
#show figure: set block(inset: (top: .1em))
#show figure.caption: c => block(width: 100%, align(left, c.body))
#print-glossary(
  gls-entries,
  deduplicate-back-references: true,
)
