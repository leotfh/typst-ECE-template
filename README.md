> [!WARNING]
> This is still WIP, feel free to open issues or PRs!
> This is not a real typst template yet.

# typst-ECE-template
This Typst template is intended for writing a thesis or a lab report at the Electronic Engineering departement at FH JOANNEUM.

## Getting Started
- Clone this repository: `git clone https://github.com/leotfh/typst-ECE-template`
- If you want to have a more clean template without the visual aids in the header: checkout the `salloker` branch
- Install VSCode
- Install the [TinyMist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) extension for VSCode (provides preview, PDF rendering and linting capabilities)
- Edit `main.typ` to fit your needs
- Kind of optional, but installing the "Latin Modern Roman" font is recommended to get the original look of the IEE LaTeX template. You can download it [here](https://www.gust.org.pl/projects/e-foundry/latin-modern/download)

## Lab Report

To use this template for a thesis, these are the relevant settings:

```typst
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
```

## Thesis

To use this template for a thesis, these are the relevant settings:

```typst
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
```

## References
- Florian Mayer's LaTeX template: https://github.com/Electronic-and-Computer-Engineering/IEETemplate
- Another Typst template used at the IIT Institute: https://git-iit.fh-joanneum.at/oss/thesis-template/-/blob/main/template/thesis.typ?ref_type=heads
