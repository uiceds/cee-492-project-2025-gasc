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
  index-terms: ("Bridge", "Scour", "Data Science"),
  bibliography: bibliography("refs.bib"),
)

= The Problem of Bridge Scour

The load paths of bridges eventually lead to the Earth and the soil or rock within.  Water is a powerful force often working against that foundation.  Since bridges often exist to span waterways, they are especially vulnerable to large flood events. In fact, hydraulic-related issues are the leading cause of bridge failures in The United States.  There are complex interactions which drive potential bridge failures. 1-dimensional analysis may provide a preliminary view of scour vulnerability but newer and larger datasets allow for a deeper analysis. 

Other options to get BibTeX entries for your references include https://www.bibtex.com/converters/ and asking ChatGPT to generate the a BibTeX entry for you. (If you use ChatGPT, make sure to verify the generated BibTeX entry for correctness.)

More information about citations can be found in the Typst documentation: https://typst.app/docs/reference/model/cite.

== Variables Involved with Scour

Channel slope, cross-sectional area, volumentric flow rates, contraction geometry, soil type and grain size, and bridge geometry all contribute to the interaction of water and bridge substructure.  
#figure(
  image("figures/Scour1.png", width: 100%),
  caption: [Scour at bridge foundation; risk of collapse. (Courtesy: Oregon Department of Transportation.)],
) <proofread>

=== Schoharie Creek Bridge collapse

In 1987, the Schorharie Creek Bridge collapse in New York State, which failed due undermining at an in-water footing, led to new and more detailed analysis and federal requirements involving channel condition and cross-channel measurment. In the most recent updates to inspection coding guidelines, scour vulnerability has been further refined to consider whether scour affects substructure strength. 

= Dataset - Water-surface profiles near selected bridge sites

State Departments of Transporataion (DOTs) are responsible for the inpection of in-service bridges.  Included in those requirments is data for determining scour vulnerability.  State DOTs collect cross-channel profiles at bridge sites on regular intervals, they also evaluate channel conditions and consider bridge substructure geometry.  Together with United States Geologoical Survey (USGS) stream flow data, and contraction geometry at the bridge site, engineers evaluate scour vulnerabilty under different flood level scenarios.

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

== State of Montana Site Data

The State of Montana has published four datasets regarding hydraulic information at bridge locations, in CSV or excel form found here: https://www.sciencebase.gov/catalog/item/66abb29ad34e20d4a0358111
- Cross Sectional Geometry data at selected bridge sites in Montana
- Longitudinal streambed profiles along the sides of piers at selected bridge sites
- Pier structure geometry data for section and side views at seleted bridge sites
  - Pier structure data for section views
  - pier structure data for side views
- Water surface profiles near selected bridge sites


You can create numbered lists using numbers followed by a period:
1. First item
2. Second item
  1. Sub item 1
  2. Sub item 2



== Equations

You can create equations using `$` symbols. For example, you can make an inline equation like this $E=m c^2$ or a displayed equation like this:

$ x < y => x gt.eq.not y $ <eq1>

You can reference the equation like this: Eq. @eq1.
