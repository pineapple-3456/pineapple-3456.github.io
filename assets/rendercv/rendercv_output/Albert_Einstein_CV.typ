// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Albert Einstein",
  title: "Albert Einstein - CV",
  footer: context { [#emph[Albert Einstein -- #str(here().page())\/#str(counter(page).final().first())]] },
  top-note: [ #emph[Last updated in Oct 2026] ],
  locale-catalog-language: "en",
  text-direction: ltr,
  page-size: "a4",
  page-top-margin: 0.7in,
  page-bottom-margin: 0.7in,
  page-left-margin: 0.7in,
  page-right-margin: 0.7in,
  page-show-footer: false,
  page-show-top-note: false,
  colors-body: rgb(0, 0, 0),
  colors-name: rgb(0, 79, 144),
  colors-headline: rgb(0, 79, 144),
  colors-connections: rgb(0, 79, 144),
  colors-section-titles: rgb(0, 79, 144),
  colors-links: rgb(0, 79, 144),
  colors-footer: rgb(128, 128, 128),
  colors-top-note: rgb(128, 128, 128),
  typography-line-spacing: 0.6em,
  typography-alignment: "justified",
  typography-date-and-location-column-alignment: right,
  typography-font-family-body: "Source Sans 3",
  typography-font-family-name: "Source Sans 3",
  typography-font-family-headline: "Source Sans 3",
  typography-font-family-connections: "Source Sans 3",
  typography-font-family-section-titles: "Source Sans 3",
  typography-font-size-body: 10pt,
  typography-font-size-name: 30pt,
  typography-font-size-headline: 10pt,
  typography-font-size-connections: 10pt,
  typography-font-size-section-titles: 1.4em,
  typography-small-caps-name: false,
  typography-small-caps-headline: false,
  typography-small-caps-connections: false,
  typography-small-caps-section-titles: false,
  typography-bold-name: true,
  typography-bold-headline: false,
  typography-bold-connections: false,
  typography-bold-section-titles: true,
  links-underline: false,
  links-show-external-link-icon: false,
  header-alignment: center,
  header-photo-width: 3.5cm,
  header-space-below-name: 0.7cm,
  header-space-below-headline: 0.7cm,
  header-space-below-connections: 0.7cm,
  header-connections-hyperlink: true,
  header-connections-show-icons: true,
  header-connections-display-urls-instead-of-usernames: false,
  header-connections-separator: "",
  header-connections-space-between-connections: 0.5cm,
  section-titles-type: "with_partial_line",
  section-titles-line-thickness: 0.5pt,
  section-titles-space-above: 0.5cm,
  section-titles-space-below: 0.3cm,
  sections-allow-page-break: true,
  sections-space-between-text-based-entries: 0.3em,
  sections-space-between-regular-entries: 1.2em,
  entries-date-and-location-width: 4.15cm,
  entries-side-space: 0.2cm,
  entries-space-between-columns: 0.1cm,
  entries-allow-page-break: false,
  entries-short-second-row: true,
  entries-degree-width: 1cm,
  entries-summary-space-left: 0cm,
  entries-summary-space-above: 0cm,
  entries-highlights-bullet:  "•" ,
  entries-highlights-nested-bullet:  "•" ,
  entries-highlights-space-left: 0.15cm,
  entries-highlights-space-above: 0cm,
  entries-highlights-space-between-items: 0cm,
  entries-highlights-space-between-bullet-and-text: 0.5em,
  date: datetime(
    year: 2026,
    month: 10,
    day: 28,
  ),
)


= Albert Einstein

  #headline([Scientist])

#connections(
  [#link("mailto:einstein@example.com", icon: false, if-underline: false, if-color: false)[#connection-with-icon("envelope")[einstein\@example.com]]],
  [#connection-with-icon("location-dot")[Princeton, NJ]],
  [#link("https://x.com/AlbertEinstein", icon: false, if-underline: false, if-color: false)[#connection-with-icon("x-twitter")[AlbertEinstein]]],
  [#link("https://github.com/example", icon: false, if-underline: false, if-color: false)[#connection-with-icon("github")[example]]],
  [#link("https://linkedin.com/in/example", icon: false, if-underline: false, if-color: false)[#connection-with-icon("linkedin")[example]]],
)


== Professional Summary

- A German-born theoretical physicist, widely ranked among the greatest and most influential scientists of all time

== Postal Address

- 2712 Broadway St, San Francisco, California, CA 94115, US

== Education

#education-entry(
  [
    #strong[University of Zurich], Physics

    PhD

    Theory of Relativity

    - Description 1.

    - Description 2.

  ],
  [
    Zurich, Switzerland

    1900 – 1905

  ],
)

#education-entry(
  [
    #strong[Eidgenössische Technische Hochschule], Physics

    Federal teaching diploma

    - Description 1.

    - Description 2.

  ],
  [
    Zurich, Switzerland

    1896 – 1900

  ],
)

== Experience

#regular-entry(
  [
    #strong[Institute for Advanced Study, Princeton University], Professor of Theoretical Physics

    #summary[Teaching at Palmer Physical Laboratory (now 302 Frist Campus Center). While not a professor at Princeton, I associated with the physics professors and continued to give lectures on campus.]

    - Relativity

    - Description 2.

  ],
  [
    Princeton University, NJ

    1933 – 1955

    

    22 years

  ],
)

#regular-entry(
  [
    #strong[California Institute of Technology], Visiting Professor

    - Description 1.

    - Description 2.

  ],
  [
    Pasadena, California, US

    1933 – 1933

    

    1 year

  ],
)

#regular-entry(
  [
    #strong[Kaiser Wilhelm Institute for Physics], Director

  ],
  [
    Berlin, Germany

    1917 – 1933

    

    16 years

  ],
)

#regular-entry(
  [
    #strong[Karl-Ferdinand University], Professor of Theoretical Physics

  ],
  [
    Prague, Czechoslovakia

    1911 – 1917

    

    6 years

  ],
)

#regular-entry(
  [
    #strong[University of Zurich], Associate Professor of Theoretical Physics

  ],
  [
    Zurich, Switzerland

    1909 – 1911

    

    2 years

  ],
)

== Volunteer

#regular-entry(
  [
    #strong[People's Climate March], Lead Organizer

    #summary[Lead organizer for the New York City branch of the People's Climate March, the largest climate march in history.]

    - Awarded 'Climate Hero' award by Greenpeace for my efforts organizing the march.

    - Men of the year 2014 by Time magazine

  ],
  [
    Zurich, Switzerland

    Apr 2014 – July 2015

  ],
)

== Awards

#regular-entry(
  [
    #strong[#link("https://www.nobelprize.org/prizes/physics/1921/einstein/biographical/")[Nobel Prize in Physics]]

    #summary[The Nobel Prizes are five separate prizes that, according to Alfred Nobel's will of 1895, are awarded to 'those who, during the preceding year, have conferred the greatest benefit to humankind.']

    Royal Swedish Academy of Sciences

  ],
  [
    Nov 1921

  ],
)

#regular-entry(
  [
    #strong[Max Planck Medal]

    #summary[Awarded for outstanding scientific achievement]

    German Physical Society

  ],
  [
    2029

  ],
)

== Publications

#regular-entry(
  [
    #strong[#link("https://en.wikisource.org/wiki/Translation:On_the_Electrodynamics_of_Moving_Bodies")[Zur Elektrodynamik bewegter Körper]]

    #summary[It concerned an interpretation of the Michelson–Morley experiment and the properties of light and time. Special relativity incorporates the principle that the speed of light is the same for all inertial observers regardless of the state of motion of the source.]

    Albert Einstein

    Annalen der Physik

  ],
  [
    June 1905

  ],
)

#regular-entry(
  [
    #strong[#link("https://de.wikisource.org/wiki/Über_einen_die_Erzeugung_und_Verwandlung_des_Lichtes_betreffenden_heuristischen_Gesichtspunkt")[Über einen die Erzeugung und Verwandlung des Lichtes betreffenden heuristischen Gesichtspunkt]]

    #summary[In the second paper, he applied the quantum theory to light to explain the photoelectric effect. In particular, he used the idea of light quanta (photons) to explain experimental results, but stressed the importance of the experimental results. The importance of his work on the photoelectric effect earned him the Nobel Prize in Physics in 1921.]

    Albert Einstein

    Annalen der Physik

  ],
  [
    Mar 1905

  ],
)

#regular-entry(
  [
    #strong[#link("https://de.wikisource.org/wiki/Die_Grundlage_der_allgemeinen_Relativitätstheorie")[Die Grundlage der allgemeinen Relativitätstheorie]]

    #summary[The publication of the theory of general relativity made him internationally famous. He was professor of physics at the universities of Zurich (1909–1911) and Prague (1911–1912), before he returned to ETH Zurich (1912–1914).]

    Albert Einstein

    Annalen der Physik

  ],
  [
    Mar 1916

  ],
)

== Skills

#regular-entry(
  [
    #strong[Physics]

    Master

    Quantum Mechanics, Quantum Computing, Quantum Information, Quantum Cryptography, Quantum Communication, Quantum Teleportation

  ],
  [
  ],
)

== Languages

#regular-entry(
  [
    #strong[German]

    #summary[Native speaker]

  ],
  [
  ],
)

#regular-entry(
  [
    #strong[English]

    #summary[Fluent]

  ],
  [
  ],
)

== Interests

#regular-entry(
  [
    #strong[Physics]

    Quantum Mechanics, Quantum Computing, Quantum Information, Quantum Cryptography, Quantum Communication, Quantum Teleportation

  ],
  [
  ],
)

== Certificates

#regular-entry(
  [
    #strong[Machine Learning]

    Stanford University

  ],
  [
    Jan 2018

  ],
)

#regular-entry(
  [
    #strong[Quantum Computing]

    Stanford University

  ],
  [
    Jan 2018

  ],
)

#regular-entry(
  [
    #strong[Quantum Information]

    Stanford University

  ],
  [
    Jan 2018

  ],
)

== Projects

#regular-entry(
  [
    #strong[Quantum Computing]

    #summary[Quantum computing is the use of quantum-mechanical phenomena such as superposition and entanglement to perform computation. Computers that perform quantum computations are known as quantum computers.]

    - Quantum Teleportation

    - Quantum Cryptography

  ],
  [
    Jan 2018 – Jan 2018

  ],
)

== References

#regular-entry(
  [
    #strong[Professor John Doe]

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam condimentum, diam quis convallis euismod, arcu mi ullamcorper lorem, a vestibulum nunc magna at sem. Sed in risus ac felis varius blandit.

  ],
  [
  ],
)

#regular-entry(
  [
    #strong[Professor Jane Smith]

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam condimentum, diam quis convallis euismod, arcu mi ullamcorper lorem, a vestibulum nunc magna at sem. Sed in risus ac felis varius blandit.

  ],
  [
  ],
)
