#import "@preview/charged-ieee:0.1.4": ieee

#show: ieee.with(
  title: [CEE 492 Group Project: The Data Science of Bridge Scour - Diagnostic and Predictive Analytics],
  abstract: [
    Bridge scour (the unwanted removal of sediment at bridge foundations) is the leading cause of bridge failures and closures in the United States. With increasing availability and processing power of stream and weather data, engineers can make efforts to analyze, predict and prescribe patterns to anticipate problems, react quickly to large weather events and design mitigations to preserve and protect these large public assets.   In this study, we will apply the principles of Data Science and the Julia programming language in investigating specific bridge sites for that end. 
  ],
authors: (
    (
      name: "Garret Anderson",
      department: [Civil and Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Urbana, IL, USA],
      email: "garreta2@illinois.edu",
    ),
    (
      name: "Andrew Farver",
      department: [Civil and Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Urbana, IL, USA],
      email: "farver1@illinois.edu",
    ),
 (
      name: "Safi Sawadogo",
      department: [Civil and Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Urbana, IL, USA],
      email: "safiata2@illinois.edu",
    ),
 (
      name: "Corey Withroe",
      department: [Civil and Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Urbana, IL, USA],
      email: "withroe2@illinois.edu",
    ),
  ),
  index-terms: ("Optional", "Keywords", "Here"),
  bibliography: bibliography("refs.bib"),
)

= The Problem of Bridge Scour

To add citations to the report, go to https://scholar.google.com, search for a paper, click on the quotation mark icon below the search result, and copy the BibTeX entry. Then paste it into the `refs.bib` file. You can cite papers using the `@` symbol followed by the citation key, e.g., @lowry1951protein.

Other options to get BibTeX entries for your references include https://www.bibtex.com/converters/ and asking ChatGPT to generate the a BibTeX entry for you. (If you use ChatGPT, make sure to verify the generated BibTeX entry for correctness.)

More information about citations can be found in the Typst documentation: https://typst.app/docs/reference/model/cite.

== Variables Involved with Scour

To add figures to your report, save the image file in the `figures` folder and use the `#figure` command as shown below to include it in your document. You can specify the width of the image and add a caption. Then you can reference the figure like this: @proofread.

#figure(
  image("figures/Scour1.png", width: 80%),
  caption: [A humble request. (Copyright: University of the Fraser Valley.)],
) <proofread>

=== Schoharie Creek Bridge collapse

You can make sub, sub-sub, and sub-sub-sub sections by adding `=` signs in front of the section title. There needs to be a space between the last `=` sign and the title text.

= Dataset - Water-surface profiles near selected bridge sites

You can add tables using the `#table` command. Here is an example table:

#figure(
  caption: [Example Table],
  table(
    columns: (auto, auto, auto),
    table.header([*Column 1*], [*Column 2*], [*Column 3*]),
    "Row 1", "Data 1", [Data 2],
    image("figures/proof-read.png", width: 40%), "Data 3", "Data 4",
  ),
) <table-example>

You can reference the table like this: @table-example.

== Various Text Formatting Options

You can make text _italic_ by surrounding it with `_` symbols, *bold* by surrounding it with `*` symbols, and _*bold italic*_ by combining both. You can also use `#code` to format inline code snippets.

You can create bullet point lists using `-` or `*` symbols:
- Bullet point 1
- Bullet point 2
  - Sub bullet point 1
  - Sub bullet point 2


You can create numbered lists using numbers followed by a period:
1. First item
2. Second item
  1. Sub item 1
  2. Sub item 2



== Equations

You can create equations using `$` symbols. For example, you can make an inline equation like this $E=m c^2$ or a displayed equation like this:

$ x < y => x gt.eq.not y $ <eq1>

You can reference the equation like this: Eq. @eq1.
