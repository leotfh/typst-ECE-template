#import "@preview/mmdr:0.2.1": mermaid
#import "@preview/rivet:0.3.0"
#import "@preview/zap:0.5.0"
#import "@preview/circuiteria:0.2.0"
#import "@preview/chronos:0.3.0"

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

#let todo(term, color: red) = {
  text(color, box[#term])
}
#let quote(message, by) = {
  // #let fb_quote(message,by) = {
  block(radius: 1em, width: 90%, inset: (x: 2em, y: 0.5em), [
    #set align(left)
    #set text(style: "italic")
    #message
    #v(0.1em)
    #set align(right)
    #text(size: 10pt, [
      #by
    ])
  ])
}

#let directquote(it, bibkey:label, supplement:none, delimiter:["],enddelimiter:none) = {
  if enddelimiter == none{ enddelimiter = delimiter}
  [#delimiter#it#enddelimiter #cite(bibkey, supplement: supplement)]
}

// inspired by: https://github.com/typst/typst/issues/344
#let fhjcode(code: "", language: "python", firstline: 0, lastline: -1, textsize: 11pt) = {
  // Custom layout for raw code
  // with line numbering
  show raw.where(block: true, lang: "trimmed_code"): it => {
    //
    // shorten the source code if firstline and/or lastline are specified
    //
    let theCode = it.text // contents -> string
    let lines = theCode.split("\n")
    let fromLine = if firstline > lines.len() { lines.len() } else { firstline };
    let toLine = if lastline > lines.len() { lines.len() } else { lastline };
    lines = lines.slice(fromLine, toLine)
    set text(size: textsize)
    show raw.line: it => {
        text(fill: gray)[#it.number]
        h(1em)
        if language=="console"{
          show regex("^#.*"): set text(weight: "bold" )
          show regex("^>.*"): set text(weight: "bold" )
          text(fill:black,style: "normal", it.body)
        }else{
          it.body
        }
    }
    let txt = lines.join("\n")
    if txt != none {
      let r = raw(txt, lang: language)
      block(
          radius: 0.5em, fill: luma(240),
          width: 100%, inset: (x: 0.7em, y: 0.5em),
          r
        )
    }else{
      todo("Err: Use arguments 'firstline' and 'lastline' to specify a non-empty part of source code.")
    }
  }
  set text(size: 11pt)

  // we use here INTERNAL lang parameter "trimmed_python"
  // which supports trimming (see: show  raw.where(...) )
  raw(code, block: true, lang: "trimmed_code")
}

// macros to emphasise / italic / boldface in a specific way
// e.g. invent your own styles for tools/commands/names/...

#let textit(it) = [
  #set text(style: "italic")
  #h(0.1em, weak: true)
  #it
  #h(0.3em, weak: true)
]

#let textbf(it) = [
  #set text(weight: "semibold")
  #h(0.1em, weak: true)
  #it
  #h(0.2em, weak: true)
]

// Create a table from csv,
//   render first line bold,
//   use alternating line colors
#let fhjtable(
  tabledata: "",
  columns: 1,
  header-row: gray.lighten(60%),
  even-row: rgb(255, 255, 255),
  odd-row: rgb(228, 234, 250),
  align: (col, row) => if row == 0 { center } else { left },
  inset: (x: 0.5em, top: 0.3em, bottom: 0.9em)
) = {
  let parsed = if type(tabledata) == str { csv(bytes(tabledata)) } else { tabledata }
  let tableheadings = parsed.first()
  let data = parsed.slice(1).flatten()
  let col-widths = if type(columns) == int { (1fr,) * columns } else { columns }
  {
    table(
      columns: col-widths,
    
    fill: (_, row) =>
      if row == 0 {
        header-row // color for header row
      } else if calc.odd(row) {
        odd-row // each other row colored
      } else {
        even-row
    },
    inset: inset,
    stroke: 0.6pt, // + gray.darken(20%),
    align: align,
    ..tableheadings.map(x => [*#x*]), // bold headings
    ..data,
  )
  }
}

// Optionally, during review process you might want to
// highlight changed text blocks with #fhjrevisionmark([ ... ]):
// Revision Mark
#let fhjrevisionmark(content) = block(
  stroke: (right: 2pt + black.lighten(5%)),
  inset: (right: 6pt),
  content
)

// flowchart.typ
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#let flowchart(..steps) = {
  let items = steps.pos()
  let nodes = ()
  let y = 0
  let node-map = (:)
  
  for item in items {
    if item.type == "node" or item.type == "decision" {
      if item.name != none {
        node-map.insert(item.name, y)
      }
      
      let n = if item.name != none {
        node(
          (0, y),
          item.label,
          name: label(item.name),
          width: 40mm,
          inset: 8pt,
          stroke: 1pt,
          fill: white,
          corner-radius: if item.type == "decision" { 0pt } else { 4pt },
          shape: if item.type == "decision" { shapes.diamond } else { rect },
        )
      } else {
        node(
          (0, y),
          item.label,
          width: 40mm,
          inset: 8pt,
          stroke: 1pt,
          fill: white,
          corner-radius: if item.type == "decision" { 0pt } else { 4pt },
          shape: if item.type == "decision" { shapes.diamond } else { rect },
        )
      }
      
      nodes.push(n)
      y += 1
      
    } else if item.type == "edge" {
      let from = if item.from != none { (0, node-map.at(item.from)) } else { none }
      let to = if item.to != none { (0, node-map.at(item.to)) } else { none }
      
      if from != none and to != none {
        nodes.push(edge(from, to, "-|>",
          label: item.label,
          label-pos: 0.5,
          label-sep: 0pt,
          label-fill: white,
          label-anchor: "center",
          stroke: 1pt,
          mark-scale: 100%,
          bend: item.bend,
        ))
      } else {
        nodes.push(edge("d", "-|>",
          label: item.label,
          label-pos: 0.5,
          label-sep: 0pt,
          label-fill: white,
          label-anchor: "center",
          stroke: 1pt,
          mark-scale: 100%,
        ))
      }
    }
  }
  
  align(center, pad(y: 15pt, diagram(
    spacing: (10mm, 15mm),
    ..nodes,
  )))
}

#let fnode(label, name: none) = (type: "node", label: label, name: name)
#let fdecision(label, name: none) = (type: "decision", label: label, name: name)
#let fedge(label, from: none, to: none, bend: 90deg) = (type: "edge", label: label, from: from, to: to, bend: bend)