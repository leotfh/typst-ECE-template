#import "iee-template.typ": *

// ==========================================================
// USER CONFIGURATION
// ==========================================================

#show: doc => iee-thesis(
  // Metadata
  title: "Your Thesis Title",
  subtitle: "Optional Subtitle",
  author: "Forename Surename",
  supervisors: (
    "Prof. Dr. Max Mustermann",
    "Dipl.-Ing. Jane Doe"
  ),
  
  // Program: PROGRAM_ECE, PROGRAM_MEC, PROGRAM_ECM, PROGRAM_STM, PROGRAM_EEM
  program: PROGRAM_ECE, 
  language: "en", // "en" or "de"
  doc-type: "thesis", // "thesis" or "report"
  show-list-of: ("figures"),
  
  // Content from abstract.tex and acknowledgments.tex
  abstract-de: [
    Hier sollte Ihre Zusammenfassung der Arbeit stehen! Dies ist der Platzhalter für die Kurzfassung.
  ],
  abstract-en: [
    Please put the summary of your work here! This corresponds to the content of `abstract.tex`.
  ],
  acknowledgments: [
    Thanks to... 
    
    Choose whatever suits you best. This corresponds to `acknowledgments.tex`.
  ],

  doc
)

#include "chapters/introduction.typ"

#include "chapters/methods.typ"

// ==========================================================
// CHAPTER 3: Graphics & Lists (ChapterTwo.tex)
// ==========================================================
= Draw graphics using TikZ & other fancy stuff

TikZ and PGF are TeX packages. In Typst, we usually use the `cetz` package or import images.

== TikZ Examples
Since Typst cannot compile `.tex` files directly, you should export your TikZ figures to PDF or SVG and import them like this:

#figure(
  // image("figures/figure3_7.svg", width: 80%),
  rect(width: 80%, height: 5cm, fill: luma(240))[
    #align(center+horizon)[*Placeholder for TikZ Figure 3.7*]
  ],
  caption: [Spectrogram consistency concept]
) <figExOne>

== List Structures
Here are the list examples from `chapterTwo.tex`:

=== Itemize (Bullet List)
- First item
- Second item
- Third item

=== Enumerate (Numbered List)
+ First item
+ Second item
+ Third item

=== Nested Lists
+ The first item
  + Nested item 1
  + Nested item 2
+ The second item

// ==========================================================
// CHAPTER 4: Discussion
// ==========================================================
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
  fhjtable(tabledata: csv("data/book1.csv", delimiter: ";"), columns: (auto, 1fr, 1fr, 1fr)), 
  caption: [Example Table]
)


#pagebreak()
#bibliography("bib/ECEtempBib.bib", style: "ieee")