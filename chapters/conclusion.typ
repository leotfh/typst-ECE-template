#import "../helpers/lib.typ": *

= Discussion <ch:Discussion>
This corresponds to `Discussion.tex`.
Footnotes also work! #footnote(text("Test"))

== Citations 
Creating your own bibliography is important. In Typst, you link a .bib file at the end of the document. And reference entries using `#cite(key)` where `key` is the citation key defined in your .bib file or just use the \@ syntax. For example, you could reference this:
@CMayerEtAl2018 , also reference this: @Okorn2017 or this: @Prechtl2006

// ==========================================================
// APPENDICES
// ==========================================================
#pagebreak()
#counter(heading).update(0)
#set heading(numbering: "A.1")

= Miscellaneous (Appendix A)
== Some Math
Here is the cases equation example from `appendixA.tex`:

$
  pi_q (k,l) = cases(
    1 &quad G_q(k,l) > rho_text("th"),
    0 &quad text("otherwise")
  )
$

== Program Code / Listing
Three types of source codes are supported. Here is a C-code example (Listing 1.1 in your files):
@Stoica2005

#figure(
  kind: raw,
  caption: [Example C Code],
  ```c
  #include <stdio.h>
  #define N 10

  int main()
  {
    int i;
    puts("Hello world!");
    for (i = 0; i < N; i++)
    {
      puts("Typst is also great for programmers!");
    }
    return 0;
  }
  ```
)

== Tables

#figure(
  fhjtable(tabledata: csv("../assets/data/book1.csv", delimiter: ";"), columns: (auto, 1fr, 1fr, 1fr)), 
  caption: [Example Table]
)

#pagebreak()