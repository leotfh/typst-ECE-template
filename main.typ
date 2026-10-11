#import "iee-template.typ": *
#import "helpers/lib.typ": *

// ==========================================================
// USER CONFIGURATION
// ==========================================================

#show: doc => iee-thesis(
  // Metadata
  title: "Your Report Title",
  subtitle: "Optional Subtitle",
  authors: (
    "Forename Surname",
    "Second Author"
  ),
  supervisors: (
    "Prof. Dr. Max Mustermann",
    "Dipl.-Ing. Jane Doe"
  ),
  
  // Program: PROGRAM_ECE, PROGRAM_MEC, PROGRAM_ECM, PROGRAM_STM, PROGRAM_EEM
  program: PROGRAM_ECM,
  language: "en", // "en" or "de"
  doc-type: "report", // "thesis" or "report" -> auto-selects the matching title page
  show-list-of: (),

  doc
)

#include "chapters/introduction.typ"

#include "chapters/methods.typ"

#include "chapters/conclusion.typ"

#bibliography("helpers/bib/ECEtempBib.bib", style: "ieee")