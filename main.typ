#import "fhj-iee-template.typ": *
#import "helpers/lib.typ": *

// ==========================================================
// USER CONFIGURATION
// ==========================================================

#show: doc => fhj-iee-template(
  // Metadata
  title: "Laboratory Exercise Title",
  subtitle: "Optional Subtitle",
  authors: (
    "Forename Surname",
    "Second Author",
  ),

  program: PROGRAM_ECM,
  semester: "WS2026",
  language: "en",
  doc-type: "report",
  show-list-of: (),

  doc,
)



= Title of the lab exercise
== Task Description
Describe the task here.
== Schematic
