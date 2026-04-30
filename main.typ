#import "iee-template.typ": *
#import "helpers/lib.typ": *

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
    #include "/chapters/frontmatter/abstract_de.typ"
  ],
  abstract-en: [
    #include "/chapters/frontmatter/abstract_en.typ"
  ],
  acknowledgments: [
    #include "/chapters/frontmatter/acknowledgments.typ"
  ],

  doc
)

#include "chapters/introduction.typ"

#include "chapters/methods.typ"

#include "chapters/conclusion.typ"

#bibliography("helpers/bib/ECEtempBib.bib", style: "ieee")