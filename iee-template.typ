// ==========================================================================
// FH JOANNEUM IEE THESIS TEMPLATE (Typst Port)
// Based on the original LaTeX template by Mayer Florian (2016-2025)
// and the IIT Thesis Template by FH JOANNEUM (2026).
// ==========================================================================


// See https://github.com/typst/packages/tree/main/packages/preview/glossarium
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#import "helpers/glossary-definitions.typ": gls-entries

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

// ******************
// Helper functionality: todo / quote / fhjcode / textit / textbf / fhjtable / ...
// ******************

// Helper to support long and short captions for outlines (list of figures)
// author: laurmaedje
// Put this somewhere in your template or at the start of your document.
#let in-outline = state("in-outline", false)
#let flex-caption(long, short) = context if in-outline.get() { short } else {
long }

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
  show-list-of: ("figures", "tables", "equations", "listings"), // which lists/outlines to show
  body
) = {

  // Set PDF document metadata.
  set document(title: title, author: author)
  
  let meta = get-meta(program, doc-type, language)
  let is-german = (language == "de")

  // --- 1. Page Setup ---
  set page(
    paper: "a4",
    margin: if style == "book" {
      (inside: 3cm, outside: 2.5cm, top: 3cm, bottom: 4cm)
    } else {
      (left: 2.5cm, right: 2.5cm, top: 3cm, bottom: 4cm)
    },

    header: context {
      // Use absolute page position (not the logical counter, which can be reset)
      // so that counter(page).update(1) at body start doesn't cause collisions.
      let abs-here = here().position().page

      // Only consider headings that appear after the table of contents.
      let outlines = query(outline)
      let toc-page = if outlines.len() > 0 { outlines.first().location().position().page } else { 0 }

      let all-h1 = query(heading.where(level: 1))
        .filter(h => h.numbering != none and h.location().position().page > toc-page)
      let on-page   = all-h1.filter(h => h.location().position().page == abs-here)
      let before-page = all-h1.filter(h => h.location().position().page < abs-here)
      let current-chapter = if on-page.len() > 0 { on-page.first().body }
                            else if before-page.len() > 0 { before-page.last().body }
                            else { "" }

      if current-chapter != "" {
        
          grid(
            columns: (1fr, 1fr),
            align(left,  if calc.even(abs-here) { text(size: 9pt, fill: black.lighten(50%), baseline: 10pt)[#current-chapter] } else { "" }),
            align(right, if calc.odd(abs-here)  { text(size: 9pt, fill: black.lighten(50%), baseline: 10pt)[#current-chapter] } else { "" }),
          )
          line(length: 100%, stroke: 0.2pt)
        
      }
    },

    footer: context {
        line(length: 100%, stroke: 0.2pt)  
        align(center, text(size: 9pt, fill: black.lighten(50%), 
          counter(page).display("1")))
    },
  )

  // ==========================================================
  // TITLE PAGE
  // ==========================================================
  {
    let img = image("assets/graphics/others/bgGraphic-eps-converted-to.pdf", width: 140%, height: 100%)

    set page(header: none, footer: none, margin: (top:2cm, bottom: 2cm), background: none)
    
    set text(font: ("Latin Modern Roman"), fill: white)

    table(
      columns: (1fr, 1fr), 
      align: (center + horizon, center + horizon),
      stroke: none,
      image("assets/graphics/logos/company_logo-eps-converted-to.pdf", width: 7cm),
      image("assets/graphics/logos/FHJ-EE_flat-eps-converted-to.pdf", width: 7cm)
    )

    place(bottom+right, dx: 3cm, dy: 3cm,
      img)
    
    v(1fr)
        
    align(right)[
      #text(size: 28pt, weight: "bold")[#title]
      #if subtitle != none {
        parbreak()
        text(size: 18pt, weight: "regular")[#subtitle]
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

  // Global typesetting settings
  

  let body-spacing = 20pt

  set text(size: 11pt, font: ("Cambria"))
  set par(justify: true, leading: 1.1em, spacing: body-spacing)

  set block(spacing: body-spacing, below: 20pt, above: 20pt)
  set list(body-indent: 12pt, indent: 20pt, spacing: auto)

  show link: set text(fill: den-col-dark)
  set math.equation(numbering: "(1)")
  set math.equation(numbering: (..n) => strong(numbering("(1)", ..n)))

  // --- Code Block Styling ---
  show raw.where(block: true): it => {
    let num-width = if it.lines.len() < 100 { 1.8em } else { 2.5em }
    show raw.line: line => {
      box(width: num-width, align(right, text(size: 1em, fill: luma(150))[#line.number]))
      h(1.5em)
      line.body
    }
    block(
      fill: luma(245),
      inset: 10pt,
      radius: 2pt,
      stroke: (left: 4pt + den-col),
      it
    )
  }
  show figure.where(
  kind: raw
): set figure.caption(position: top)

  //add more vertical space between text and start of figures
  show figure: set block(inset: (top: 0.5em))

  set figure(gap: 1.5em)
  
  show figure.caption: it => text(
    [*#it.supplement #it.counter.display(it.numbering):* #it.body]
  )

  show figure.caption: it => text(
    [*#it.supplement #it.counter.display(it.numbering):* #it.body]
  )

  set align(left) // align text left (i.e. no longer centered)

  let num_col = 1cm
  let gap = 0.25cm

  let hang_head(it, size, above: 0pt, below: 0pt) = {
    v(above, weak: false)
    block(below: below)[
      #set text(size: size, weight: "bold")
      #if it.numbering != none {
        par(hanging-indent: num_col + gap)[
          #box(width: num_col)[
            #counter(heading).display(it.numbering)
          ]
          #h(gap)
          #it.body
        ]
      } else {
        it.body
      }
    ]
  }

  show heading.where(level: 1): it => hang_head(it, 20pt, above: 28pt, below: 25pt)
  show heading.where(level: 2): it => hang_head(it, 16pt, above: 10pt, below: 15pt)
  show heading.where(level: 3): it => hang_head(it, 13pt, above: 15pt, below: 15pt)

  {
    // No header and roman page number as footer only for preambles
    set page(header: none)
    set page(footer: context {
      pad(bottom: 4cm)[
        #align(right,  text(size: 9pt, fill: black.lighten(50%),baseline: 10pt, counter(page).display("i")))
      ]
    })
    counter(page).update(2)

    // ==========================================================
    // DECLARATION
    // ==========================================================
  
    heading(outlined: false, numbering: none, "Eidesstattliche Erklärung")
    include "chapters/frontmatter/eidesstattliche_erklaerung.typ"
    pagebreak()

    heading(outlined: false, numbering: none, "Declaration of Honor")
    include "chapters/frontmatter/declaration_of_honor.typ"
    pagebreak()
  

    // ==========================================================
    // ABSTRACTS
    // ==========================================================
    
    v(30pt)
    if abstract-de != none {
      heading(outlined: false, numbering: none, "Kurzfassung")
      abstract-de
      pagebreak()
    }
    
    v(30pt)
    if abstract-en != none {
      heading(outlined: false, numbering: none, "Abstract")
      abstract-en
      pagebreak()
    }

    // ==========================================================
    // ACKNOWLEDGMENTS
    // ==========================================================
    if acknowledgments != none {
      heading(outlined: false, numbering: none, 
        [#if is-german [Danksagung] else [Acknowledgments]]
      )
      acknowledgments
      pagebreak()
    }

    // ==========================================================
    // TABLE OF CONTENTS
    // ==========================================================
    

    show outline.entry.where(level: 1): it => {
      if it.element.func() == heading {
        text(size: 12pt, weight: "bold")[#it]
      } else if it.element.func() == figure {
        let cap = it.element.caption
        let fill = it.fill
        context {
          let pg = counter(page).at(it.element.location()).first()
          let num = numbering(cap.numbering, ..cap.counter.at(it.element.location()))
          block(
            link(it.element.location(), text(fill: black)[*#cap.supplement #num:* #cap.body #if fill != none { box(width: 1fr, fill) } else { h(1fr) } #pg])
          )
        }
      } else {
        it
      }
    }
    show outline.entry.where(level: 2): it => {
      v(0.6cm, weak: true)
      it
    }
    show outline.entry.where(level: 3): it => {
      v(0.5cm, weak: true)
      it
    }
    outline(
      title: [
        #text(size: 20pt, weight: "bold")[
          #if is-german [Inhaltsverzeichnis] else [Contents]
        ]
       
      ],
      depth: 3,
      indent: auto,
    )
    pagebreak()

    set align(left)
    enum(numbering: "I.")

    //
    // LIST OF FIGURES (LoF)
    //
    if show-list-of.contains("figures") {
      if (language == "de") {
        heading("Abbildungsverzeichnis", numbering: none, outlined: false)
      } else {
        heading("List of Figures", numbering: none, outlined: false)
      }
      outline(title: none, target: figure.where(kind: image))
      pagebreak()
    }

    //
    // LIST OF TABLES (LoT)
    //
    if show-list-of.contains("tables") {
      if (language == "de") {
        heading("Tabellenverzeichnis", numbering: none, outlined: false)
      } else {
        heading("List of Tables", numbering: none, outlined: false)
      }
      outline(title: none, target: figure.where(kind: table))
      pagebreak()
    }

    //
    // LIST OF EQUATIONS (LoE)
    //
    if show-list-of.contains("equations") {
      if (language == "de") {
        heading("Formelverzeichnis", numbering: none, outlined: false)
      } else {
        heading("List of Equations", numbering: none, outlined: false)
      }
      outline(title: none, target: figure.where(kind: math.equation))
      pagebreak()
    }

    if show-list-of.contains("glossary") {
      if (language == "de") {
        heading("Abkürzungsverzeichnis", numbering: none, outlined: false)
      } else {
        heading("Glossary", numbering: none, outlined: false)
      }
    register-glossary(gls-entries)

    show: make-glossary
    include "helpers/glossary.typ"
    pagebreak()
    }

    //
    // LIST of LISTINGS LoL
    //
    if show-list-of.contains("listings") {
      if (language == "de") {
        heading("Quellcodeverzeichnis", numbering: none, outlined: false)
      } else {
        heading("List of Listings", numbering: none, outlined: false)
      }
      outline(title: none, target: figure.where(kind: raw))
      pagebreak()
    }
  }
  // ==========================================================
  // MAIN BODY
  // ==========================================================

  set page(numbering: "1")
  counter(page).update(1)
  set heading(numbering: "1.1.1")

  body
}
