// * Add list of terms

#let gls-entries = (
    (
      key: "svg", short: "SVG", long: "Scalable Vector Graphics", description: [A vector image format.],
    ),
    (
      key: "csv", short: "CSV", long: "Comma-separated Values ", description: [A human readable, plain text file format using commas to separate the values.],
    ),
    (
      key: "esp", short: "ESP", long: "ESP32/ESP8266", description: [ESP32 and ESP8266 are popular microcontrollers used in IoT and smart home projects.],
    ),
    (
      key: "ota", short: "OTA", long: "Over the Air Updates", description: [Over the Air Updates allow firmware to be updated wirelessly, without needing physical access to the device.],
    ),
)

// Hints:
// * Usage within text will then be #gls(<key>) or plurals #glspl(<key>)
