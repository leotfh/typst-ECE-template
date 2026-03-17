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