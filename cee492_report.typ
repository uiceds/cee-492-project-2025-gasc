#import "@preview/charged-ieee:0.1.4": ieee
#set page(numbering: "i")

#show: ieee.with(
  title: [
    #text(size: 1.2em)[The Data Science of Bridge Scour] \ 
    #text(size: 1.0em)[Diagnostic and Predictive Analytics] \ 
    #text(size: 0.7em, style: "italic")[Submission 4: Final Report Rough Draft] 
        #v(-0.9em)
    #line(length: 78%, stroke: 0.75pt) 
        #v(-0.9em) 
    #text(size: 0.5em)[University of Illinois at Urbana-Champaign] \ 
      #v(-1.0em)
    #text(size: 0.5em)[CEE 492: Data Science in CEE (Fall 2025)]
    
    ],

  abstract: [
   Bridge scour (the unwanted removal of sediment at bridge foundations) is the leading cause of bridge failures and closures in the United States. With increasing availability and processing power of stream and weather data, it is possible for engineers to make efforts to analyze, predict and prescribe patterns to anticipate problems, react quickly to large weather events, and design mitigations to preserve and protect these large public assets. In this study, the project team applies the principles of data science and the Julia programming language in investigating stream bed profile data supplied by the USGS for select bridges in the state of Montana. It is later discussed that the scope of the project experienced changes throughout the study. This change mostly occurred during the Exploratory Data Analysis. However, the intent of this study has remained the same; to gain insights into scour behavior using data science.#v(0.5em)],

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

= Introduction

This study has been motivated by the potential to apply the principles of data science to the critical infrastructure problem of bridge foundation scour. The underlying intent of the study is to leverage modern analytical techniques to gain new insights into scour behavior in the hopes of providing quality insight into how to more effectively monitor, mitigate, and  protect vital public assets from the problem of scour. More generally, the project team hopes to showcase the value that modern data science can provide to a classic civil engineering problem.

Given this context, the project team’s primary research hypothesis is that an analysis of historical stream bed profile data, when processed using data science methodologies, can reveal detectable patterns and key indicators related to scour behavior at specific bridge locations if the necessary, yet rudimentary, data is collected. This study specifically investigates this hypothesis by applying the Julia programming language to analyze stream bed profile data supplied by the USGS for select bridges in the state of Montana. While the precise scope of the project evolved during the Exploratory Data Analysis (EDA) phase, the fundamental objective remained unchanged: to use data science to uncover actionable insights from hydrological and structural data related to bridge scour.


== The Problem of Bridge Scour

The load paths of bridges eventually lead to the Earth and the soil or rock within.  Water is a powerful force often working against that foundation.  Since bridges often exist to span waterways, they are especially vulnerable to large flood events. In fact, hydraulic-related issues are the leading cause of bridge failures in The United States @LeeBridge. Some researchers have even estimated that scour alone to be the cause of collapse of 20-100 bridges per year in the United States @Flintetal. There are complex interactions which drive potential bridge failures. 1-dimensional analysis may provide a preliminary view of scour vulnerability but newer and larger datasets allow for a deeper analysis. #v(0.4em) 

=== Schoharie Creek Bridge Collapse

In 1987, the Schorharie Creek Bridge collapse in New York State, which failed due to undermining at an in-water footing, led to new and more detailed analysis and federal requirements involving channel condition and cross-channel measurment. In the most recent updates to inspection coding guidelines, scour vulnerability has been further refined to consider whether scour affects substructure strength. 

This historic event highlights how scour can be a serious public safety issue. While this may be an extreme case, it serves as a grim reminder of what this research seeks to prevent. We can ask hypothetical questions to relate this tragedy to the current study:

-	What if the magnitude of scour potential had been identified prior to this event?
-	What if inspection frequency was optimized to allow for high-quality assessment?

While the number of these hypothetical questions could begin to approach infinity, the event has already occurred. The focus now must shift to preventing the next disaster of this magnitude. By leveraging modern data science and stream profile analysis, we aim to move from reactive "what-ifs" to proactive prediction. 

#figure(
  image("figures/Schoharie Creek Bridge.jpg", width: 100%),
  caption: [Schoharie Creek Bridge Collapse at Amsterdam, N.Y., 1987 (Courtesy: Times Union and AP Photo/Jim McKnight)],
) 

=== State of Practice

(IDEA: have a section that discusses "work prevously done by others". Perhaps cite some other research papers or reports.)#v(0.5em)

==== Advanced Scour Modeling

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

==== Variables Involved with Scour

Channel slope, cross-sectional area, volumetric flow rates, contraction geometry, soil type and grain size, and bridge geometry all contribute to the interaction of water and bridge substructures.  

= Exploratory Analysis

This study initially aimed to integrate diverse datasets from the USGS to ancillary datasets related to stream flow and weather data. The core datasets contained cross-sectional geometry, longitudinal streambed profiles, bridge pier geometry and location, along with water surface profiles. However, the Exploratory Data Analysis (EDA) phase revealed that harmonizing these disparate, independent datasets presented significant logistical challenges that threatened the project's feasibility. Consequently, the research team used the EDA process to refine the study's scope, shifting focus from broad hydraulic integration toward identifying actionable trends in streambed elevation changes to optimize inspection intervals. 

== Dataset - "Bridge scour data at selected bridge sites in Montana"

State Departments of Transporataion (DOTs) are responsible for the inpection of in-service bridges.  Included in those requirments is data for determining scour vulnerability.  State DOTs collect cross-channel profiles at bridge sites on regular intervals, they also evaluate channel conditions and consider bridge substructure geometry.  Together with United States Geologoical Survey (USGS) stream flow data, and contraction geometry at the bridge site, engineers evaluate scour vulnerabilty under different flood level scenarios.

#figure(
  caption: [Bridge Cross Section Geometry],
  table(
    columns: (auto, auto, auto, auto),
    table.header([*Northing (FT)*], [*Easting (FT)*], [*Elevation (FT)*], [*Distance (ft)*]),
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
    table.header([*Distance from Abutment (ft)*], [*Channel Depth (ft)*], [*Below Water Level*]),
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
    table.header([*Pier*], [*Elevation (FT)*], [*Distance (ft)*], [*CL (ft)*], [*Foundation*]),
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
    table.header([*Northing (FT)*], [*Easting (FT)*], [*Elevation (ft)*]),
    "1102284.1",	"1913872.63",	"3204.09",
"1102293.07",	"1913869.11",	"3204.1",
"1102295.2",	"1913867.71",	"3204.07",
"1102296.49",	"1913868.04",	"3204.03",
"1102297.12",	"1913868.05",	"3203.98",
"1102297.7",	"1913868.06", "3203.9",


  ),
) <table-example>


#figure(
  image("figures/Scour1.png", width: 100%),
  caption: [Scour at Bridge Foundation; Risk of Collapse. (Courtesy: Oregon Department of Transportation.)],
) <proofread>

== State of Montana Site Data

The State of Montana has published four datasets regarding hydraulic information at bridge locations, in CSV or excel form found here: 

- https://www.sciencebase.gov/catalog/item/66abb29ad34e20d4a0358111

Which includes: 

- Cross-sectional geometry data 
- Longitudinal streambed profiles along the sides of piers
- Pier structure geometry data for section and side views
- Water surface profiles 

Additionally, The USGS provides expected flood event water levels by severity: https://streamstats.usgs.gov/ss/ 

#figure(
  image("figures/Figure 3.png", width: 100%),
  caption: [Downstream Cross-Channel Profile at Subject Bridge.],
) <proofread>

#figure(
  image("figures/Scour2.png", width: 100%),
  caption: [Temporary Fix at Severe Scour Location. (Courtesy: Oregon Department of Transportation.)],
) <proofread>

== Exploratory Data Analysis Process

The research team entered the exploratory data analysis (EDA) phase with the intent of further investigating the available data sources and refining its project statement. Despite best efforts, the initial findings suggested that the initial goals of the project were too challenging given the availability, complexity, and format of the necessary data. The available scour data, from the State of Montana USGS data, included numerous unique and rather independent datasets, including cross-sectional geometry data, longitudinal profile data, pier structure data, water surface profiles, and sporadic but extensive stream flow data. Attempting to collect, refine, and subsequently tie such a wide variety of complex data was decidedly understood to be beyond the scope of the project.  

To give example, in order to try identifying and model the relationships between stream flows and scour, the team would have needed to first find a bridge with enough data between 2012 and 2024, locate the subject bridge on the USGS StreamStats GIS page, investigate if there was a stream gauge measuring data in close proximity, and if that were true then hope that the dates on the stream gauge data coincided with the data collected on scour/elevation. It was determined by the research team that the described task would be far too challenging in itself, let alone decomposing and cleaning/tidying the complicated stream flow data in addition to the stream elevation data. 

#figure(
  image("figures/Example_StreamStats_Data.png", width: 100%),
  caption: [Example StreamStats data from USGS.],
) <proofread>

With the aforementioned limitations identified, the research team focused attention and efforts on finding a reasonable but potentially impactful way to analyze some of the data on hand. Remember, bridge scour is a serious concern for State and Federal entities, leading to thousands and even millions of dollars spent in monitoring costs. The research team thus changed its priority to evaluating if applying data science could help identify and model trends in streambed elevations. If correlations did prove to exist, a reliable model could be produced, having the potential to allow States and the Federal Government to more intelligently determine at what interval monitoring should be conducted, as opposed to standardized (and costly) yearly or bi-yearly .

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

Consequently, the research team successfully compiled the cross-sectional streambed data provided by the USGS, ranging from 2012 to 2024, into a single dataframe that had the potential to be used for the predictive modeling. The Julia language was used within a Pluto workbook interface, where initial cleaning/tidying of the data was performed. Following this, the team began simplifying the ability to visualize the data. Figure 5 shows the plots of a sample bridge, with both upstream and downstream surface elevations changing throughout the observed years. While this presentation provides an overall view of the streambed elevations across the observed range of years, it can at times be difficult to interpret from a vast legend what profile relates to which year. Thus, an additional presentation was chosen. In this additional presentation, each observed year for a given structure is provided a separate graph with the previous year’s profile superimposed in a dashed line on the same graph. This allowed for easier interpretation  of whether the difference from one year to the next was considered a cut, fill, or balance.

Both presentations of the streambed elevations across overserved years were seen as beneficial to the project team. The Figure 5 presentation allows the observer to account for overall variation of the dataset. Contrastingly, the presentation presented in Figure 6 allows, as previously discussed, the observer to account for cuts, fills, or balances in the overall streambed across observed years. In the project team’s opinion, the characterization of the streambed year to year as a cut, fill, or balance is seen as the most holistic take on the comparison of streambed profiles. The profiles presented in Figure 6 have been normalized following recommendations provided to the project team. This normalization allows for comparison between profiles at different structures.  

#figure(
  image("figures/Figure 5.png", width: 100%),
  caption: [Example Cross Sections Combined and Plotted in Julia.],
) <proofread>

#figure(
  image("figures/Figure 6.png", width: 100%),
  caption: [Example Year to Year Profile Comparison],
) <proofread>

= Predictive Modeling

== Initial Predictive Modeling Strategy

With the project scope refined and simplified, the research team sought out to begin planning on how to refine the data further and formulate how to eventually generate the previously described predictive model. The team is foremost interested in determining if there are noticeable trends in the streambed data. Through preliminary research and initial understanding, the research team believes that SVD and PCA may be able to provide insights into the underlying trends within the streambed data. The use of SVD and PCA would require the data to be reformatted. The restructuring will involve transitioning the current data frame, which is a comprehensive collection of all bridges, across all years, and both upstream and downstream elevations, into a matrix format that is suitable for SVD/PCA analysis and focused on singular bridges with separated upstream and downstream matrices. Our team believes that the first and second modes of the PCA/SVD analyses will provide the most useful information. The first mode will capture the overall summation of cut and fill across the stream bed, while the second mode will focus more on local changes. The trends present in the second mode of the SVD/PCA are thought to be the most applicable to the scour problem at hand since they can be correlated with the known pier coordinates at each bridge location.

To develop a predictive model, the question of whether to use the entire stream bed cross section in the model or whether to focus on the known pier locations is currently unanswered. This is mostly due to the fact that the previously mentioned SVD/PCA analyses have not been conducted. Following these analyses, our team believes that the path forward in developing our model will be more definite. Given the extent of the data frame the team believes that selecting a number of bridges, most likely those that reside on the same stream, may be a way to simplify the problem. Choosing a river with the most abundant and high quality data for this task will be crucial. Some preliminary analysis has been done and shows that the Bitterroot river has three unique structures that have all been observed more than five years. The team may also develop a model for a single bridge over a partial span of its data (2012-2020 for example) and then test the legitimacy of the model by comparing to the estimated elevation to that of the known elevation in the remaining years data.

== Methods
As discussed in the preceding section, the USGS data required reformatting in order to perform SVD/PCA. This was completed by the group and the aforementioned modes of the SVD/PCA were able to be readily observed. Figure 7 below shows the two modes presented in the code.

#figure(
  image("figures/Figure 7.png", width: 100%),
  caption: [SVD Modes 1 & 2 for Subject Bridge Structure],
) <proofread>

Following this, training data was then able to be created foe the prospective predictive model. Most of the stream bed profiles investigated by the project team exhibited significant variability (or 'noise'), as seen for the 2023 data in Figure 5. This high variability, combined with the fact that adjacent elevation points are highly correlated, could cause a standard model to overfit the data. Therefore, a regularized multiple linear regression model was chosen. The project team used the regularization parameter to prevent overfitting of the data. This was believed to produce a more stable and robust prediction. For this submission, the model was used to predict the last observed year for a given bridge structure.

== Results
In order to produce meaningful results, a user-friendly interface needed to be created in the Pluto notebook interface. Through the use of drop-down menus and various graphs, like those presented in figures 5-7, understanding the data, along with the results, was made possible. Figure 8 shows the resulting plot in which the predicted profile for the last year is superimposed on the actual profile for that same year. 
The SVD with Ridge Regularization effectively represented riverbed profiles in a compressed format, capturing the dominant "depth" mode indicative of pool deepening or filling, and the secondary "tilt/asymmetry" mode that reflects lateral migration and asymmetric bar dynamics. This method showed stability with minimal overfitting due to an efficient use of training transitions, yielding an unbiased average forecast with a mean absolute error (MAE) of approximately 3.9 feet. However, its limitation was evident in capturing sharp, localized morphological changes, particularly in areas of abrupt transition.
•	The SVD + ridge autoregression provided an unbiased forecast on average (bias ≈ 0 ft) but a moderate pointwise error (MAE ≈ 2.1 ft). The method captures broad, low frequency shape but not localized, high amplitude scour or bank build up.
#figure(
  image("figures/Figure 8.png", width: 100%),
  caption: [Last Observed Year: Actual v. Predicted Profile],
) <proofread>

It can be seen in Figure 8 that the predicted profile is in relatively good agreement with the actual profile. To make this observation more quantitative, the project team worked on applying accuracy metrics to the data. The project team chose to use the coefficient of determination (COD), more familiarly known as R^2, along with Root Mean Squared Error (RMSE) to gauge the accuracy of the model.
For this submission, the scope of analysis was limited to three bridges on the same river, the Bitterroot. These structures include: P00007 043+0.666, S00373000+04001, S00370 000+0.5361. Both the upstream and downstream data were analyzed for these structures. Predictions made for the final observed year’s profile were made and the accuracy metrics were recorded. The results can be seen in the following table, Table  6.

#figure(
  caption: [Predictive Model Results],
  table(
    columns: (auto, auto, auto, auto),
    table.header([*Structure*], [*Side*], [*R^2*], [*RMSE (ft)*]),
 "P00007 043+0.666", "Upstream", "0.68", "2.0",
"P00007 043+0.666", "Downstream", "0.90", "1.9",
"S00373000+04001", "Upstream", "0.74", "1.3",
"S00373000+04001", "Downstream", "0.88", "1.5",
"S00370 000+0.5361", "Upstream", "0.55", "2.2",
"S00370 000+0.5361", "Downstream", "0.56", "2.4"
  ),
) <table-example>

From the results presented in the above table and by referencing the respective figures (Figure 5 and 6) for each structure, it was apparent that of the three structures, the structures with the least variation year to year had more accurate model predictions than the more erratic years. Structure S00370 000+0.5361, both in the upstream and downstream sides, has the most erratic streambed profile year over year. The predicted profiles for this structure had the lowest R^2 value, which is supported by the previous statement regarding the erratic streambed elevations. 

While the R^2 value differed per structure, something that remained relatively consistent was the RMSE for all observation made. The column in table 6 is reported in feet and represents the magnitude of inaccuracy between the predicted and actual profile at any given point. 

== Conclusions
In conclusion, the modeling effort to date reveals critical insights into river dynamics and emphasizes the need for comprehensive methods that consider both common trends and rare events in fluvial systems. Supporting evidence from statistical analyses and ongoing literature review enriches the findings, reiterating the significance of continuous improvement in river modeling methodologies.

= Discussion

== Future Efforts

(COPIED FROM PREVIOUS SECTION, NEEDS EDITING)
The project team noticed some areas which could be improved for the final report. First, the use of the R^2 and RSME as accuracy metrics seems useful, but could be supported by overall area comparisons. These comparsions could be made between the final year prediction vs actual, but are thought to be more insightful if the second to last year is compared to both the the actual final year profile along with the predicted final year profile. A cut, fill, or balance (values close to zero) could be applied to the difference in areas. Another area for improvement that the team noticed is that the current code extends actual profiles artifically to stay within a set horizontal maximum and minimum value. This becomes problematic when comparing a predicted profile that extends from the maximum to minimum horizotnal extents to an actual profile that has artifical, and rather incorrect, elevation data. The project team believes a truncation of the results to have a consistent horizontal maximum and minimum can alliviate this issue. In addition to model improvements, the team has begun evalauating existing industry and academic sources in order to better contexualize the findings of this project. Initial sources come from The _Journal of Hydrology_ @Anderson, _River Research and Applications_ @Brown, _Water Resources Research_ @Davis, and the _Journal of the Transportation Research Board_ @Yousefpour.

The overall evaluation of these approaches underscores that while the SVD + ridge model effectively captures broad, long-term changes in river morphology, it is less proficient at detecting sudden, localized alterations. This dual approach highlights the necessity for advanced modeling techniques that can accommodate both gradual and rapid changes in river dynamics. Additionally, the interpretations derived from the modes align with established fluvial processes, demonstrating the model's utility as a screening tool for anticipating potential changes in river morphology, informing infrastructure decisions, sediment management, and ecological conservation efforts.

=== Relation to Stream Gauge Data


