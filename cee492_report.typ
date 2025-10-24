#import "@preview/charged-ieee:0.1.4": ieee

#show: ieee.with(
  title: [CEE 492 Group Project: The Data Science of Bridge Scour - Diagnostic and Predictive Analytics
  #text(size: 0.85em, style: "italic")[Submission 2: Exploratory Data Analysis]],
  abstract: [
    Bridge scour (the unwanted removal of sediment at bridge foundations) is the leading cause of bridge failures and closures in the United States. With increasing availability and processing power of stream and weather data, engineers can make efforts to analyze, predict and prescribe patterns to anticipate problems, react quickly to large weather events and design mitigations to preserve and protect these large public assets.   In this study, we will apply the principles of Data Science and the Julia programming language in investigating specific bridge sites for that end. 
  ],
authors: (
    (
      name: "Garret Anderson",
      department: [Civil and Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Seattle, WA, USA],
      email: "garreta2@illinois.edu",
    ),
    (
      name: "Andrew Farver",
      department: [Civil and Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Washington, DC, USA],
      email: "farver1@illinois.edu",
    ),
 (
      name: "Safiata Sawadogo",
      department: [Civil and Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Tuscon, AZ, USA],
      email: "safiata2@illinois.edu",
    ),

  ),
  index-terms: ("Bridge", "Scour", "Data Science", "Julia"),
  bibliography: bibliography("refs.bib"),
)

= The Problem of Bridge Scour

The load paths of bridges eventually lead to the Earth and the soil or rock within.  Water is a powerful force often working against that foundation.  Since bridges often exist to span waterways, they are especially vulnerable to large flood events. In fact, hydraulic-related issues are the leading cause of bridge failures in The United States @LeeBridge. Some researchers have even estimated that scour alone to be the cause of collapse of 20-100 bridges per year in the United States @Flintetal. There are complex interactions which drive potential bridge failures. 1-dimensional analysis may provide a preliminary view of scour vulnerability but newer and larger datasets allow for a deeper analysis. 

== Variables Involved with Scour

Channel slope, cross-sectional area, volumetric flow rates, contraction geometry, soil type and grain size, and bridge geometry all contribute to the interaction of water and bridge substructures.  
#figure(
  image("figures/Scour1.png", width: 100%),
  caption: [Scour at bridge foundation; risk of collapse. (Courtesy: Oregon Department of Transportation.)],
) <proofread>

=== Schoharie Creek Bridge collapse

In 1987, the Schorharie Creek Bridge collapse in New York State, which failed due to undermining at an in-water footing, led to new and more detailed analysis and federal requirements involving channel condition and cross-channel measurment. In the most recent updates to inspection coding guidelines, scour vulnerability has been further refined to consider whether scour affects substructure strength. 

= Dataset - "Bridge scour data at selected bridge sites in Montana"

State Departments of Transporataion (DOTs) are responsible for the inpection of in-service bridges.  Included in those requirments is data for determining scour vulnerability.  State DOTs collect cross-channel profiles at bridge sites on regular intervals, they also evaluate channel conditions and consider bridge substructure geometry.  Together with United States Geologoical Survey (USGS) stream flow data, and contraction geometry at the bridge site, engineers evaluate scour vulnerabilty under different flood level scenarios.

This project intends to use the coding language Julia to evaluate the different aspects of bridge scour, the collected data which contributes to it, and develop descriptive and predictive analytics at many bridge sites, including using Julia's image processing to visualize channel and thalweg migration over time.  Finally, we will compare to emperical formulas and reccomend any changes to existing processes.
#figure(
  caption: [Bridge Cross Section Geometry],
  table(
    columns: (auto, auto, auto, auto),
    table.header([*Northing*], [*Easting*], [*Elevation*], [*Distance*]),
    "1556480.572", "1167958.24", "3952.34", "0",
 "1556480.015",	"1167959.133",	"3951.11",	"1.05",
"1556479.323",	"1167960.241",	"3950.23",	"2.36",
"1556476.053",	"1167965.477",	"3949.06",	"8.53",
"1556474.651",	"1167967.723",	"3948.09",	"11.18",
"1556473.177",	"1167970.083",	"3946.08",	"13.96",

  ),
) <table-example>

#figure(
  caption: [Bridge Channel Cross-Sectional Profile],
  table(
    columns: (auto, auto, auto),
    table.header([*Distance from Abutment*], [*Channel Depth*], [*Below Water Level*]),
    "0.0", "1.2", "No",
    "4.0", "2.4", "No",
    "8.0", "3.8", "Yes",
    "12.0", "5.9", "Yes",
    "18.0", "3.8", "Yes",
    "22.0", "1.8", "No",

  ),
) <table-example>

#figure(
  caption: [Pier Structure Geometry Data],
  table(
    columns: (auto, auto, auto, auto, auto),
    table.header([*Pier*], [*Elevation*], [*Distance*], [*CL*], [*Foundation*]),
    "P4",	"3313.996",	"63.83",	"68.33",	"Known",
"P3",	"3313.516",	"136.27",	"140.77",	"Known",
"P3",	"3307.016",	"136.27",	"140.77",	"Known",
"P3",	"3307.016",	"145.27",	"140.77",	"Known",
"P3",	"3313.516",	"145.27", "140.77",	"Known",
"P3",	"3313.516",	"136.27",	"140.77",	"Known",
"P2", "3314.016",	"207.96",	"212.46",	"Known",
"P2",	"3307.516",	"207.96",	"212.46",	"Known",
"P2",	"3307.516",	"216.96",	"212.46",	"Known",

  ),
) <table-example>

#figure(
  caption: [Water Surface Profile Profile],
  table(
    columns: (auto, auto, auto),
    table.header([*Northing*], [*Easting*], [*Elevation*]),
    "1102284.1",	"1913872.63",	"3204.09",
"1102293.07",	"1913869.11",	"3204.1",
"1102295.2",	"1913867.71",	"3204.07",
"1102296.49",	"1913868.04",	"3204.03",
"1102297.12",	"1913868.05",	"3203.98",
"1102297.7",	"1913868.06", "3203.9",


  ),
) <table-example>


== State of Montana Site Data

The State of Montana has published four datasets regarding hydraulic information at bridge locations, in CSV or excel form found here: 

- https://www.sciencebase.gov/catalog/item/66abb29ad34e20d4a0358111

Which includes: 

- Cross-sectional geometry data 
- Longitudinal streambed profiles along the sides of piers
- Pier structure geometry data for section and side views
  - Pier structure data for section views
  - Pier structure data for side views
- Water surface profiles 

Additionally, The USGS provides expected flood event water levels by severity: https://streamstats.usgs.gov/ss/ 


== Equations

Athough there are five types of scour, we will focus on the two main causes, which are described by empirical equations accordingly:
1. Contraction Scour - 
  1. Laursen Live Bed or Clear Water Scour Equation
$ V_c = K_u y_1^(1/6) D_50^(1/2) $
2. Local Scour
  1. Pier Scour - The Colorado State University (CSU) Equation
  $ y_s = 2.0 K_1 K_2 K_3 K_4 a^0.65 y_1^0.35 "Fr"^0.43 $
  2. Abutment Scour - The Frolich Equation
  $ y_s = 2.27 K_1 K_2 (L')^0.43 y_a^0.57 "Fr"^0.61 + y_a $

To effectively apply the equations, we'll need to make informed assumptions. Since this is a Department of Transportation (DOT) project, our team plans to reference various publicly available DOT sources to make these assumptions. We'll then calculate or estimate variables related to flow velocity, streambed/channel geometry, and pier geometry using the gathered data.

#figure(
  image("figures/Scour2.png", width: 100%),
  caption: [Temporary fix at severe scour location. (Courtesy: Oregon Department of Transportation.)],
) <proofread>

#figure(
  image("figures/X_Channel_Profile.png", width: 100%),
  caption: [Upstream cross-channel profile at bridge.],
) <proofread>

= Exploratory Data Analysis

The research team entered the exploratory data analysis (EDA) phase with the intent of further investigating the available data sources and refining its project statement. Despite best efforts, the initial findings suggested that the goals of the project set forth in the first submittal (i.e. the preceding paragraphs) were reasoned to be too challenging given the availability, complexity, and format of the necessary data. As mentioned in our prior submittal, the available scour data included numerous unique and rather independent datasets, including cross-sectional geometry data, longitudinal profile data, pier structure data, water surface profiles, and sporadic but extensive stream flow data. Attempting to collect, refine, and subsequently tie such a wide variety of complex data was decidedly understood to be beyond the scope of this class. To give example, in order to try identifying and model the relationships between stream flows and scour, the team would have needed to first find a bridge with enough data between 2012 and 2024, locate the subject bridge on the USGS StreamStats GIS page, investigate if there was a stream gauge measuring data in close proximity, and if that were true then hope that the dates on the stream gauge data coincided with the data collected on scour/elevation. It was determined by the research team that the described task would be far too challenging in itself, let alone decomposing and cleaning/tidying the complicated stream flow data in addition to the stream elevation data.

#figure(
  image("figures/Example_StreamStats_Data.png", width: 100%),
  caption: [Example StreamStats data from USGS.],
) <proofread>

With the aforementioned limitations identified, the research team focused attention and efforts on finding a reasonable but potentially impactful way to analyze some of the data on hand. As discussed in the team’s prior submittal, bridge scour is a serious concern for State and Federal entities, leading to thousands and even millions of dollars spent in monitoring costs. The research team thus changed its priority to evaluating if applying data science could help identify and model trends in streambed elevations. If correlations do exist, a reliable model could be produced, having the potential to allow States and the Federal Government to more intelligently determine at what interval monitoring should be conducted, as opposed to standardized (and costly) yearly or bi-yearly.

#figure(
  caption: [Basic Data Stats],
  table(
    columns: (auto, auto,),
    "Number of Streams",	"16",	
"Number of Bridges",	"33",	
"Number of Cross Sections",	"79",	
"Total Unique Readings",	"102,276",	

  ),
) <table-example>


With that in mind, the research team has successfully compiled the cross-sectional streambed data provided by the USGS, ranging from 2012 to 2024, into a single dataframe that will be used for the predictive modeling. Thus far, the team has loaded the data into a Pluto workbook, performed initial cleaning, and began simplifying the ability to visualize the data. Figure 5 shows the plots of a sample bridge, with both upstream and downstream surface elevations changing throughout the observed years.

#figure(
  image("figures/Example_Bridge_Plots.png", width: 100%),
  caption: [Example Cross Sections Combined and Plotted in Julia.],
) <proofread>

= Predictive Modeling

With the project scope refined and simplified, the research team sought out to begin planning on how to refine the data further and formulate how to eventually generate the previously described predictive model. The team is foremost interested in determining if there are noticeable trends in the streambed data. Through preliminary research and initial understanding, the research team believes that SVD and PCA may be able to provide insights into the underlying trends within the streambed data. The use of SVD and PCA would require the data to be reformatted. The restructuring will involve transitioning the current data frame, which is a comprehensive collection of all bridges, across all years, and both upstream and downstream elevations, into a matrix format that is suitable for SVD/PCA analysis and focused on singular bridges with separated upstream and downstream matrices. Our team believes that the first and second modes of the PCA/SVD analyses will provide the most useful information. The first mode will capture the overall summation of cut and fill across the stream bed, while the second mode will focus more on local changes. The trends present in the second mode of the SVD/PCA are thought to be the most applicable to the scour problem at hand since they can be correlated with the known pier coordinates at each bridge location.   

To develop a predictive model, the question of whether to use the entire stream bed cross section in the model or whether to focus on the known pier locations is currently unanswered. This is mostly due to the fact that the previously mentioned SVD/PCA analyses have not been conducted. Following these analyses, our team believes that the path forward in developing our model will be more definite. Given the extent of the data frame the team believes that selecting a number of bridges, most likely those that reside on the same stream, may be a way to simplify the problem. Choosing a river with the most abundant and high quality data for this task will be crucial. Some preliminary analysis has been done and shows that the Bitterroot river has three unique structures that have all been observed more than five years. The team may also develop a model for a single bridge over a partial span of its data (2012-2020 for example) and then test the legitimacy of the model by comparing to the estimated elevation to that of the known elevation in the remaining years data.
