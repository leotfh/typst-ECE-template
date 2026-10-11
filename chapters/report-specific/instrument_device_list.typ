#import "../../helpers/lib.typ": *

#fhjtable(
  columns: 3,
  tabledata: (
    ("Type", "Serial Number", "Notes"),
    ([Digital multimeter\ _Keysight 34450A_], [-], [Measuring voltage, current, and resistance]),
    ([Handheld multimeter\ _Keysight U1233A_], [-], [Measuring voltage and current]),
    ([Oscilloscope\ _Keysight DSO X3014 T_], [-], [Observing and measuring time-varying signals]),
    ([Function generator\ _Keysight 33511B_], [-], [Generating test waveforms]),
    ([LCR-Meter\ _Keysight U1233A_], [-], [Measuring inductance, capacitance, and resistance]),
    ([DC power supply], [-], [Providing regulated DC power to the circuit]),
  ),
  inset: (x: 0.5em, top: 1em, bottom: 1em),
)
