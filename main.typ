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

// ==========================================================
// CHAPTER 1: Introduction
// ==========================================================
= Introduction <ch:Introduction>
// Content from Introduction.tex
This chapter corresponds to `Introduction.tex`. You can write your introduction here.

// ==========================================================
// CHAPTER 2: Methods
// ==========================================================
= Methods <ch:Methods>
// Content from Method.tex
In this very first chapter, we clarify how to add your math within the text in a proper way.

== Phase Estimation Fundamentals <sec:PEF>
The problem of interest in many signal processing applications including radar, spectrum estimation and signal enhancement, is to detect a signal of interest in a noisy observation.

The signal of interest is often represented as a sum of sinusoids characterized by their amplitude, frequency and phase parameters. Since these parameter triplet suffices to describe the signal, the problem degenerates to the detection and estimation of the sinusoidal parameters.

#blue-box[
  This is a highlighted box (MDFramed in LaTeX). 
  Do not forget to add specific bibliography fields into your `.bib` file!
]

== Key Examples: Phase Estimation Problem <ch3:PE1>
=== Example 1: discrete-time sinusoid

To reveal the phase structure of one sinusoid's frequency response we consider the following real-valued sequence:

$ x(n) = cos(omega_0 n + phi) $ <eq:c3.1>

with $omega_0$ as frequency and $phi$ as phase shift.

Application of the discrete-time Fourier transform (DTFT) yields:

$ X(e^(j omega)) = pi e^(j phi) delta(omega - omega_0) + pi e^(-j phi) delta(omega + omega_0) $

=== Complex Equations (Split Environment)
In LaTeX, you used `split` or `eqnarray`. In Typst, we use `$` blocks with `&` alignment. Here is the complex error term equation from `Method.tex` (Eq 3.17):

$
  bb(E)_phi (e_c) &= sum_(h=1)^H A_h / A_bar(h) bb(E)(e^(j(phi_h - phi_bar(h)))) W(e^(j(omega_bar(h) - omega_h))) \
  &+ sum_(h=1)^H A_h / A_bar(h) bb(E)(e^(-j(phi_h + phi_bar(h)))) W(e^(j(omega_bar(h) + omega_h))) \
  &+ 1 / (pi A_bar(h)) bb(E)(e^(-j phi_bar(h))) D_w (e^(j omega_bar(h)))
$

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
  caption: [Spectrogram consistency concept used in Griffin-Lim iterative signal reconstruction.]
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

= Citations 
(Appendix B) Creating your own bibliography is important. In Typst, you link a .bib file at the end of the document. And reference entries using `#cite(key)` where `key` is the citation key defined in your .bib file or just use the \@ syntax. For example, you could reference this:
@CMayerEtAl2018 , also reference this: @Okorn2017 or this: @Prechtl2006

// ========================================================== 
// BIBLIOGRAPHY 
// ========================================================== 
#bibliography("bib/ECEtempBib.bib") // Ensure you have a references.bib file in the same folder.