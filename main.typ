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

#include "chapters/conclusion.typ"

#bibliography("helpers/bib/ECEtempBib.bib", style: "ieee")