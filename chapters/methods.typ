#import "lib.typ"

// ==========================================================
// CHAPTER 2: Methods
// ==========================================================
= Methods <ch:Methods>
// Content from Method.tex
In this very first chapter, we clarify how to add your math within the text in a proper way.

== Phase Estimation Fundamentals <sec:PEF>
The problem of interest in many signal processing applications including radar, spectrum estimation and signal enhancement, is to detect a signal of interest in a noisy observation.

The signal of interest is often represented as a sum of sinusoids characterized by their amplitude, frequency and phase parameters. Since these parameter triplet suffices to describe the signal, the problem degenerates to the detection and estimation of the sinusoidal parameters.

== Key Examples: Phase Estimation Problem <ch3:PE1>
=== Example 1: discrete-time sinusoid

To reveal the phase structure of one sinusoid's frequency response we consider the following real-valued sequence:

$ x(n) = cos(omega_0 n + phi) $ <eq:c3.1>

with $omega_0$ as frequency and $phi$ as phase shift.

Application of the discrete-time Fourier transform (DTFT) yields:

$ X(e^(j omega)) = pi e^(j phi) delta(omega - omega_0) + pi e^(-j phi) delta(omega + omega_0) $

=== Complex Equations (Split Environment)
In LaTeX, you used `split` or `eqnarray`. In Typst, we use `$` blocks with `&` alignment. Here is the complex error term equation from `Method.tex` (Eq 3.17):

$
  bb(E)_phi (e_c) &= sum_(h=1)^H A_h / A_bar(h) bb(E)(e^(j(phi_h - phi_bar(h)))) W(e^(j(omega_bar(h) - omega_h))) \
  &+ sum_(h=1)^H A_h / A_bar(h) bb(E)(e^(-j(phi_h + phi_bar(h)))) W(e^(j(omega_bar(h) + omega_h))) \
  &+ 1 / (pi A_bar(h)) bb(E)(e^(-j phi_bar(h))) D_w (e^(j omega_bar(h)))
$