// ==========================================================================
// FH JOANNEUM IEE THESIS TEMPLATE (Typst Port)
// Based on the original LaTeX template by Mayer Florian (2016-2025)
// ==========================================================================

// --- Colors defined in IEEconfig.sty ---
#let den-col = rgb(35, 171, 196)
#let den-col-dark = rgb(28, 136, 156)
#let comment-color = rgb(127, 127, 127)
#let string-color = rgb(142, 0, 35)

// --- Constants for Degree Programmes ---
#let PROGRAM_ECE = "ECE" // Bachelor
#let PROGRAM_MEC = "MEC" // Bachelor
#let PROGRAM_ECM = "ECM" // Master
#let PROGRAM_STM = "STM" // Master
#let PROGRAM_EEM = "EEM" // Master (English only usually)

// --- Helper: Blue Box (mdframed equivalent) ---
#let blue-box(body) = {
  block(
    fill: rgb(245, 245, 245), // black!5
    stroke: (left: 5pt + den-col.lighten(45%)), // Line color
    inset: 20pt,
    radius: 4pt, // Approximating roundcorner
    width: 100%,
    body
  )
}

// --- Helper: Get Degree Meta Data ---
// Logic ported from titlepage.tex
#let get-meta(program, doc-type, lang) = {
  let is-de = (lang == "de")
  let data = (
    doc-type-text: "",
    org-text: "",
    degree-type: "", // "am Bachelor-Studiengang" etc.
    location: "Graz",
    thesis-line-one: "",
    thesis-line-two: ""
  )

  // 1. Determine Organization Text and Location based on Program
  if program == PROGRAM_ECE {
    data.org-text = if is-de { "Elektronik und Computer Engineering" } else { "Electronics and Computer Engineering" }
    data.location = "Graz"
    data.degree-type = if is-de { "am Bachelor-Studiengang" } else { "at the bachelor's degree programme" }
  } else if program == PROGRAM_MEC {
    data.org-text = "Industrielle Mechatronik" // Same in DE/EN usually, or translate if needed
    data.location = "Kapfenberg"
    data.degree-type = if is-de { "am Bachelor-Studiengang" } else { "at the bachelor's degree programme" }
  } else if program == PROGRAM_ECM {
    data.org-text = "Electronics and Computer Engineering"
    data.location = "Kapfenberg"
    data.degree-type = if is-de { "am Master-Studiengang" } else { "at the master's degree programme" }
  } else if program == PROGRAM_STM {
    data.org-text = "System Test Engineering"
    data.location = "Graz"
    data.degree-type = if is-de { "am Master-Studiengang" } else { "at the master's degree programme" }
  } else if program == PROGRAM_EEM {
    data.org-text = "Electronic Engineering"
    data.location = "Graz"
    data.degree-type = if is-de { "am Master-Studiengang" } else { "at the master's degree programme" }
  }

  // 2. Determine Doc Type Text (Thesis vs Report)
  if doc-type == "thesis" {
    if is-de {
      data.doc-type-text = if program == PROGRAM_ECE or program == PROGRAM_MEC { "Bachelorarbeit" } else { "Masterarbeit" }
      data.thesis-line-one = data.degree-type + " " + data.org-text
      data.thesis-line-two = "der FH JOANNEUM – University of Applied Sciences, Austria"
    } else {
      data.doc-type-text = if program == PROGRAM_ECE or program == PROGRAM_MEC { "Bachelor's Thesis" } else { "Master's Thesis" }
      data.thesis-line-one = data.degree-type + " " + data.org-text
      data.thesis-line-two = "of the FH JOANNEUM – University of Applied Sciences, Austria"
    }
  } else {
    // Report logic
    data.doc-type-text = if is-de { "Laborprotokoll" } else { "Report" }
    // Reports usually don't have the long "submitted at..." lines in the same way, 
    // but we keep the Org text available.
  }
  
  return data
}

// --- The Main Template Function ---
#let iee-thesis(
  title: "Thesis Title",
  subtitle: none,
  author: "Author Name",
  supervisors: (), 
  program: PROGRAM_ECE, 
  language: "en", 
  doc-type: "thesis", 
  style: "pdf", 
  date: datetime.today(),
  abstract-de: none,
  abstract-en: none,
  acknowledgments: none,
  body
) = {
  
  let meta = get-meta(program, doc-type, language)
  let is-german = (language == "de")

  // --- 1. Page Setup ---
  set page(
    paper: "a4",
    margin: if style == "book" {
      (inside: 3cm, outside: 2.5cm, top: 3cm, bottom: 3.5cm)
    } else {
      (left: 2.5cm, right: 2.5cm, top: 3cm, bottom: 3.5cm)
    },
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        set text(size: 9pt)
        grid(
          columns: (1fr, 1fr),
          align(left, if calc.even(page-num) { title } else { "" }),
          align(right, if calc.odd(page-num) { title } else { "" })
        )
        line(length: 100%, stroke: 0.5pt)
      }
    },
    footer: context {
      line(length: 100%, stroke: 0.5pt)
      align(center, counter(page).display("1"))
    }
  )
  
  // --- 2. Heading Styling ---
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1cm)
    place(right + top, dx: 2.6cm, dy: -0cm, image("graphics/chapterBacking-eps-converted-to.pdf", width: 12cm))
    v(2.5cm)
    grid(
      columns: (1fr, auto),
      align(left + bottom)[
         #set text(weight: "bold", size: 22pt, fill: black)
         #it.body
      ],
      place(
        right + top, 
        dx: 0cm, dy: -3.2cm,
        text(size: 80pt, weight: "bold", fill: black.lighten(0%))[
          #if it.numbering != none { counter(heading).display() }
        ]
      )
    )
    //line(length: 100%, stroke: 2pt + den-col)
    v(1cm)
  }

  show heading.where(level: 2): it => {
    v(0.5cm)
    text(size: 14pt, weight: "bold", fill: black, it)
    v(0.2cm)
  }

  // --- 3. Code Block Styling ---
  show raw.where(block: true): block.with(
    fill: luma(245),
    inset: 10pt,
    radius: 2pt,
    stroke: (left: 4pt + den-col)
  )

  // ==========================================================
  // TITLE PAGE
  // ==========================================================
  {
    let img = image("graphics/bgGraphic-eps-converted-to.pdf", width: 140%, height: 100%)

    set page(header: none, footer: none, margin: (top:2cm, bottom: 2cm), background: none)
    
    set text(font: ("Latin Modern Roman"), fill: white)
    //set page(margin: (left: 1cm, right: 1cm, top: 2cm, bottom: 3.5cm))

    table(
      columns: (1fr, 1fr), 
      align: (center + horizon, center + horizon),
      stroke: none,
      image("graphics/company_logo-eps-converted-to.pdf", width: 7cm),
      image("graphics/FHJ-EE_flat.pdf", width: 7cm)
    )

    place(bottom+right, dx: 3cm, dy: 3cm,
      img)
    
    v(1fr)
        
    align(right)[
      #text(size: 28pt, weight: "bold")[#title]
      #if subtitle != none {
        parbreak()
        text(size: 20pt, weight: "regular")[#subtitle]
      }
    ]

    v(1fr)

    align(right)[
      #text(size: 20pt, weight: "bold")[#meta.doc-type-text]
      
      #v(1em)
      
      #if doc-type == "thesis" [
        #if is-german [eingereicht] else [submitted] \
        #meta.thesis-line-one \
        #text(size: 16pt)[#meta.thesis-line-two]
      ] else [
        // Report Layout
        #meta.org-text \
        FH JOANNEUM -- University of Applied Sciences, Austria
      ]
    ]

    v(1fr)

    align(right)[
      *#if is-german [Autor] else [Author]* \
      #author
      
      #v(1em)
      
      *#if is-german [Betreuer] else [Supervisor]* \
      #supervisors.join(", ")
    ]

    v(0.5fr)
    align(right)[
      #meta.location, #date.display("[month repr:long] [year]")
    ]
    
    pagebreak()
  }


  // ==========================================================
  // ACKNOWLEDGMENTS (New)
  // ==========================================================
  if acknowledgments != none {
     set page(header: none, footer: none)
     v(1cm)
     align(right)[
       #text(size: 22pt, weight: "bold")[
         #if is-german [Danksagung] else [Acknowledgments]
       ]
     ]
     v(1cm)
     acknowledgments
     pagebreak()
  }


  // ==========================================================
  // DECLARATION
  // ==========================================================
  {
    set page(header: none, footer: none)
    v(2cm)
    
    if is-german {
       align(right, text(size: 22pt, weight: "bold", font: "")[Eidesstattliche Erklärung])
       v(1cm)
       [Der:Die Verfasser:in dieser Arbeit ist verpflichtet, den jeweils aktuellen Wortlaut der Eidesstattlichen Erklärung eigenständig über die Webseite der FH JOANNEUM abzurufen:]
       v(0.5cm)
       align(center)[https://www.fh-joanneum.at/hochschule/lehre-forschung/]
       [Die Einhaltung, Richtigkeit, Aktualität sowie vollständige Übernahme des dort veröffentlichten offiziellen Wortlauts liegt in der Verantwortung der Studierenden.]
       v(1cm)
       text(weight: "bold")[Dieser Text ist vor Abgabe vollständig durch die aktuelle Eidesstattliche Erklärung zu ersetzen.]
    } else {
       align(right, text(size: 22pt, weight: "bold", font: "")[Declaration of Honour])
       v(1cm)
       [The author of this thesis is responsible for obtaining the most recent and valid version of the Obligatory Declaration from the official FH JOANNEUM website:]
       v(0.5cm)
       align(center)[https://www.fh-joanneum.at/en/university/teaching-and-research/]
       [The accuracy, completeness and up-to-date adoption of the official wording is the sole responsibility of the submitting student.] 
       v(1cm)
       text(weight: "bold")[This placeholder text must be fully replaced with the current official Obligatory Declaration prior to submission.]
    }
    pagebreak()
  }

  // ==========================================================
  // ABSTRACTS
  // ==========================================================
  
  if abstract-de != none {
    heading(level: 1, numbering: none, outlined: false)[Kurzfassung]
    abstract-de
    pagebreak()
  }
  
  if abstract-en != none {
    heading(level: 1, numbering: none, outlined: false)[Abstract]
    abstract-en
    pagebreak()
  }

  // ==========================================================
  // TABLE OF CONTENTS
  // ==========================================================
  set page(numbering: "I")
  counter(page).update(1)
  
  show outline.entry.where(level: 1): it => {
    v(18pt, weak: true)
    strong(it)
  }
  
  outline(depth: 3, indent: auto)
  pagebreak()

  // ==========================================================
  // MAIN BODY
  // ==========================================================
  set page(numbering: "1")
  counter(page).update(1)
  set heading(numbering: "1.1")

  body
}