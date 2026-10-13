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

#import "@preview/lilaq:0.6.0" as lq

= Title of the lab exercise
== Task Description
Describe the task here.
== Schematic

#import "@preview/zap:0.6.0"

#figure(
  {
    zap.circuit({
      import zap: *

      vsource("vin", (0, -2), (0, 0), u: $u_"in"$)
      earth("gnd-in", "vin.in")

      resistor("r1", "vin.out", (4, 0), label: $R_1$)
      capacitor("c1", "r1.out", (4, -2), label: $C_1$)
      earth("gnd-c", "c1.out")

      opamp("op1", (8, 0.5), variant: "ieee", label: "OP1")
      swire("r1.out", "op1.plus", axis: "x")
      wire((10, 0.5), (10, 2))
      wire((10, 2), (5, 2))
      wire((5, 1), (5, 2))
      wire((5, 1), "op1.minus")
      wire("op1.out", (11, 0.5))
      node("out", (11, 0.5), label: $u_"out"$)
    })
  },
  caption: "Active low-pass filter with an op-amp",
)

== Plots
#let (x, y_meas, phase, y_sim, phase2, kp2) = lq.load-txt(
  read("assets/data/Bode_HochTief.csv"),
  delimiter: ";",
  skip-rows: 1,
)

#show: lq.set-diagram(width: 100%, height: 4cm)

#figure(
  {
    show: lq.layout
    grid(
      row-gutter: 2em,
      lq.diagram(
        title: [magnitude response],
        ylabel: [Mag / dB],
        xscale: "log",
        xlim: (1, 10000),
        grid: (stroke-sub: 0.3pt + luma(90%)),

        lq.plot(x, y_meas, mark: "a6", mark-size: 6pt),
        //lq.plot(x, y_sim, mark: "x", mark-size: 6pt),
        lq.plot(x, kp2, mark: "a6", mark-size: 6pt),
      ),
      lq.diagram(
        title: [phase response],
        xlabel: [f / Hz],
        ylabel: [Phi / °],
        xscale: "log",
        xlim: (1, 10000),
        grid: (stroke-sub: 0.3pt + luma(90%)),
        lq.plot(x, phase, mark: "a6", mark-size: 6pt),
        lq.plot(x, phase2, mark: "a6", mark-size: 6pt),
      ),
    )
  },
  caption: "Bode plot of the low-pass filter",
)
