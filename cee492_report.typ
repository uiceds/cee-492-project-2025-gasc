#import "@preview/charged-ieee:0.1.4": ieee
#set page(
  footer: context [
    #line(length: 100%, stroke: 0.6pt + black)
    #v(-6pt)
    #align(center, text(size: 12pt, counter(page).display("i")))
  ]
)

#show: ieee.with(
  title: [
    #text(size: 1.2em)[The Data Science of Bridge Scour] \ 
    #text(size: 1.0em)[Diagnostic and Predictive Analytics] \ 
        #v(-0.9em)
    #line(length: 78%, stroke: 0.75pt) 
        #v(-0.9em) 
    #text(size: 0.5em)[University of Illinois at Urbana-Champaign] \ 
      #v(-1.0em)
    #text(size: 0.5em)[CEE 492: Data Science in CEE (Fall 2025)]
    
    ],

  abstract: [
   Bridge scour (the unwanted removal of sediment at bridge foundations) is the leading cause of bridge failures and closures in the United States. With increasing availability and processing power of stream and weather data, it is possible for engineers to make efforts to analyze, predict and prescribe patterns to anticipate problems, react quickly to large weather events, and design mitigations to preserve and protect these large public assets. In this study, the principles of data science and the Julia programming language are applied to investigate streambed profile data supplied by the USGS for select bridges in the state of Montana. It is later discussed that the scope of the project experienced changes throughout the study. This change mostly occurred during the Exploratory Data Analysis. However, the intent of this study has remained the same; to gain insights into scour behavior using data science.#v(0.5em)],

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
  index-terms: ("Bridge", "Scour", "Data Science", "Julia", "Principal Component Analysis (PCA)", "Machine Learning"),
  bibliography: bibliography("refs.bib"),
)

= Introduction

This study has been motivated by the potential to apply the principles of data science to the critical infrastructure problem of bridge foundation scour. The underlying intent is to leverage modern analytical techniques to gain new insights into scour behavior, with the goal of providing quality guidance on how to more effectively monitor, mitigate, and protect vital public assets. More generally, this research seeks to showcase the value that modern data science can provide to a classic civil engineering problem.
#v(0.3em)
Given this context, the primary research hypothesis is that an analysis of historical streambed profile data, when processed using data science methodologies, can reveal detectable patterns and key indicators related to scour behavior at specific bridge locations if the necessary, yet rudimentary, data is collected. This study specifically investigates this hypothesis by applying the Julia programming language to analyze streambed profile data supplied by the USGS for select bridges in the state of Montana. While the precise scope of the project evolved during the Exploratory Data Analysis (EDA) phase, the fundamental objective remained unchanged: to use data science to uncover actionable insights from hydrological and structural data related to bridge scour.

#v(0.3em)

== The Problem of Bridge Scour

Bridge foundations transfer structural loads to the underlying soil or bedrock. However, hydraulic forces, particularly during flood events, can compromise this stability through scour, which is the erosion of sediment around abutments and piers. In fact, hydraulic-related issues are the leading cause of bridge failures in The United States @LeeBridge. Some researchers have even estimated that scour alone can result in the cause of 20-100 bridge collapses per year in the United States @Flintetal. There are complex interactions which drive potential bridge failures. #v(0.3em) 

=== Schoharie Creek Bridge Collapse 

In 1987, the Schorharie Creek Bridge collapse in New York State, which failed due to undermining at an in-water footing, led to new and more detailed analysis and federal requirements involving channel condition and cross-channel measurment.  In the most recent updates to inspection coding guidelines, scour vulnerability has been further refined to consider whether scour affects substructure strength. 
#v(0.3em)
This historic event highlights how scour can be a serious public safety issue. Figure 1 below shows the aftermath of the collapse, which took the lives of ten people. While this may be an extreme case, it serves as a grim reminder of what this research seeks to prevent. We can ask hypothetical questions to relate this tragedy to the current study:
#v(0.3em)
-	What if the magnitude of scour potential had been identified prior to this event?
-	What if inspection frequency was optimized to allow for high-quality assessment?
#v(0.3em)
While the number of these hypothetical questions could begin to approach infinity, the event has already occurred. The focus now must shift to preventing the next disaster of this magnitude. By leveraging modern data science and stream profile analysis, we aim to move from reactive "what-ifs" to proactive prediction. 

#figure(
  image("figures/Schoharie Creek Bridge.jpg", width: 100%),
  caption: [Schoharie Creek Bridge Collapse at Amsterdam, N.Y., 1987 (Courtesy: Times Union and AP Photo/Jim McKnight)],
) 

=== State of the Practice

Bridge scour is the erosion of sediment, such as sand and gravel, around bridge foundations, including piers and abutments, caused by flowing water. There are three main types of scour: local scour, which occurs around individual piers or abutments due to faster water flow; contraction scour, resulting from the narrowing of the river channel at the bridge, which increases water velocity and sediment removal; and degradational scour, which involves the gradual lowering of the riverbed upstream and downstream of the bridge @Pizarro. This phenomenon accounts for approximately 31.53% of hydraulic failures and is a major cause of bridge collapses worldwide @Xiong. Traditional methods for predicting scour are often unreliable @Pizarro, but recent advancements in artificial intelligence (AI) and machine learning (ML) techniques are improving prediction accuracy @Yousefpour2021.
#v(0.3em)
Additionally, studies have demonstrated that AI models, such as Decision Tree Regressors and XGBoost, outperform traditional regression methods in estimating equilibrium scour depth around bridge abutments, highlighting the potential of AI in hydraulic engineering @Uzun. Furthermore, the integration of physics-based equations into deep learning models has shown promise in reducing forecasting errors by up to fifthy percent, indicating a significant improvement over purely data-driven approaches @Yousefpour2024. These developments suggest that AI and ML methodologies, when combined with real-time monitoring systems, can revolutionize bridge scour risk management, offering more accurate and timely predictions to safeguard infrastructure. 
#v(0.3em)
Athough there are five types of scour, this project and its findings most closesly relate to two specifc types, which are described by the below empirical equations.
#v(0.3em)

1. Contraction Scour - 
  1. Laursen Live Bed or Clear Water Scour Equation
$ V_c = K_u y_1^(1/6) D_50^(1/2) $
2. Local Scour
  1. Pier Scour - The Colorado State University (CSU) Equation
  $ y_s = 2.0 K_1 K_2 K_3 K_4 a^0.65 y_1^0.35 "Fr"^0.43 $
  2. Abutment Scour - The Frolich Equation
  $ y_s = 2.27 K_1 K_2 (L')^0.43 y_a^0.57 "Fr"^0.61 + y_a $
  
  #v(0.3em) 

  While initial goals were to create a model that could directly utilize these equations, the complexity was too high given the available resourches. As such, making the connection to these equations is left to future work.

  #v(0.3em) 

= Exploratory Data Analysis

Initially, this study aimed to integrate diverse USGS datasets with ancillary stream flow and meteorological data. The core datasets comprised cross-sectional geometry, longitudinal streambed profiles, bridge pier geometry and locations, and water surface profiles. However, the EDA phase revealed that harmonizing these disparate, independent datasets presented significant logistical challenges that threatened the project's feasibility. Consequently, the EDA findings were used to refine the study's scope, shifting the focus from broad hydraulic integration toward identifying actionable trends in streambed elevation changes to predict future behavior and optimize inspection intervals.

== Dataset - "Bridge scour data at selected bridge sites in Montana"

State Departments of Transportation (DOTs) are responsible for the inspection of in-service bridges. Included in those requirements is data for determining scour vulnerability. State DOTs collect cross-channel profiles at bridge sites on regular interval. They also evaluate channel conditions and consider bridge substructure geometry. Together with agencies like the United States Geological Survey (USGS), who collect data on stream flow and contraction geometry at bridge sites, engineers have the capability to evaluate scour vulnerability under different scenarios, including flood level events.
#v(0.3em)
Relating to this study, the USGS partnered with the Montana Department of Transportation (MDT) to acquire channel cross-section geometry upstream and downstream of designated highway bridges. To effectively distinguish between local pier scour and broader geomorphic processes, these data points span the full streambed width, including the abutments. Notably, contraction scour was ruled out as a contributing factor, as the bridge geometries did not induce significant flow contraction during spring runoff. The primary objective of this initiative was to detect scour and channel instability near bridge structures. Figure 2 provides example of what a bridge affected by severe scour can look like.

#figure(
  image("figures/Scour1.png", width: 100%),
  caption: [Scour at Bridge Foundation; Risk of Collapse. (Courtesy: Oregon Department of Transportation.)],
) <proofread>

The aforementioned data relating to the state of Montana was published in four datasets regarding hydraulic information at bridge locations, in CSV or excel form found here:#v(0.3em) 

- https://www.sciencebase.gov/catalog/item/66abb29ad34e20d4a0358111
#v(0.3em)
The datasets included: 
#v(0.3em)
- Cross-sectional foundation geometry data (Table I) 
- Cross-sectional foundation geometry data in relation to stream (Table II) 
- Streambed profiles along the sides of piers (Figure 3)
- Pier structure geometry data for section and side views (Table III)
- Water surface profiles (Table IV)
#v(0.3em)
The referenced tables and figures provide a brief example of data included in each dataset. As the tables and figures show, the data is robust but in disjointed and/or rudimentary format, lending support to the need for this modeling project. 

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
"...",	"...",	"...",	"...",

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
    "...", "...", "...",

  ),
) <table-example>

#figure(
  image("figures/Figure 3.png", width: 100%),
  caption: [Downstream Cross-Channel Profile at Subject Bridge.],
) <proofread>

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
"...",	"...",	"...",	"...",	"...",

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
"...","...","..." ,


  ),
) <table-example>

== EDA Process & Methodology

The EDA phase commenced with the intent of further investigating available data sources and refining the project statement. However, initial findings suggested that the original goals were overly ambitious given the availability, complexity, and format of the necessary data. The available scour data, sourced from the State of Montana USGS, included numerous unique and independent datasets, such as cross-sectional geometry, longitudinal profiles, pier structure data, water surface profiles, and sporadic but extensive stream flow data. Ultimately, the effort required to collect, refine, and integrate such a wide variety of complex data was determined to be beyond the feasible scope of the project.
#v(0.3em)
For instance, modeling the relationship between stream flows and scour necessitates identifying bridges with sufficient longitudinal data (2012–2024) located in close proximity to active USGS stream gauges. Furthermore, the temporal resolution of the hydraulic data must align precisely with the sporadic scour elevation surveys (similar to Figure 4). Due to these spatial and temporal synchronization requirements, combined with the substantial computational effort required to preprocess complex stream flow datasets, this integration was determined to be infeasible for the current study.

#figure(
  image("figures/Example_StreamStats_Data.png", width: 100%),
  caption: [Example StreamStats data from USGS.],
) <proofread>

Given the identified limitations, attention was directed toward establishing a feasible yet impactful analytical approach using the available dataset. Bridge scour represents a significant financial burden for State and Federal entities, incurring millions of dollars in annual monitoring costs. Consequently, the study's priority shifted to evaluating whether data science methodologies could effectively identify and model temporal trends in streambed elevations. Demonstrating the existence of such correlations would enable the development of reliable predictive models, offering the potential to optimize monitoring intervals—replacing costly standardized schedules with intelligent, risk-based assessments. Furthermore, successful modeling would facilitate the prioritization of vulnerable structures, thereby reducing the risk of collapse. The specific data selected for this preliminary analysis is summarized in Table V.

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

Consequently, the cross-sectional streambed data provided by the USGS (2012–2024) was compiled into a unified dataframe suitable for predictive modeling. Data cleaning was performed using the Julia language within a Pluto notebook interface, involving the standardization of descriptors, reformatting of dates, and the removal of extraneous records. Subsequently, visualization methods were refined to improve interpretability. Figure 5 depicts the upstream and downstream surface elevations for a sample bridge over the observation period. While this aggregate view provides a comprehensive timeline, the density of overlapping profiles can obscure specific annual trends. Therefore, an alternative presentation format was adopted in which each observation year is plotted individually, with the preceding year’s profile superimposed as a dashed line. This comparative visualization facilitates the rapid identification of inter-annual morphological changes, specifically distinguishing between cut, fill, and equilibrium conditions.

#figure(
  image("figures/Figure 5.png", width: 100%),
  caption: [Example Cross Sections Combined and Plotted in Julia.],
) <proofread>

The developed visualization methods represent a substantial improvement over the native formats provided by the USGS. While Figure 5 illustrates the aggregate variation of the dataset over the observed period, Figure 6 facilitates a more granular analysis of inter-annual morphological changes. By explicitly highlighting areas of cut, fill, or equilibrium (balance), this comparative approach provides a holistic assessment of streambed dynamics. Furthermore, the profiles presented in Figure 6 were normalized to standardize the spatial domain, thereby enabling direct comparisons of scour behavior across different bridge structures.  



#figure(
  image("figures/Figure 6.png", width: 100%),
  caption: [Example Year to Year Profile Comparison],
) <proofread>

= Predictive Modeling

== Initial Predictive Modeling Strategy

Following the refinement of the project scope, the analytical strategy focused on detecting temporal trends within the streambed data. Singular Value Decomposition (SVD) and Principal Component Analysis (PCA) were identified as the optimal methods for extracting these underlying structural patterns. Implementing these techniques required restructuring the initial aggregate dataset into site-specific matrices, isolating upstream and downstream profiles for individual bridges to ensure compatibility with SVD algorithms. Analysis revealed that the first two modes provided the most significant morphological insights, as illustrated in Figure 7. Mode 1 effectively captured the net summation of cut and fill (aggradation or degradation) across the entire cross-section, while Mode 2 resolved localized geometric changes. These localized patterns in Mode 2 are particularly relevant to scour analysis, as they suggest a strong correlation with the fixed pier coordinates at each bridge location.
#v(0.3em)
Following the reformatting of the data, efforts were directed to develop the predictive model. Given the initial dataset comprising 16 streams and 33 bridges, the scope was narrowed to focus on structures along a single watercourse. Prioritizing a river with abundant, high-quality historical data was critical to this approach. Preliminary analysis identified the Bitterroot River as a prime candidate, featuring three distinct structures with over five years of observation data. Although a single-bridge model utilizing a temporal training split (e.g., 2012–2020) was evaluated for validation, the multi-bridge analysis of the Bitterroot River was ultimately selected as the superior strategy.
#v(0.3em)

#figure(
  image("figures/Figure 7.png", width: 100%),
  caption: [SVD Modes 1 & 2 for Subject Bridge Structure],
) <proofread>



Despite its initial functionality, the preliminary model presented several critical limitations. First, integrating pier location data with cross-sectional geometry proved computationally infeasible due to format discrepancies in the native USGS datasets and inconsistent survey lengths. This necessitated the exclusion of relevant spatial data. Second, the multiple linear regression architecture was static. It required manual calibration of hyperparameters, specifically regularization strength, learning rate, and iteration counts, for each unique bridge simulation. Furthermore, the heterogeneity in historical data density across different structures complicated the definition of universally applicable input variables. Finally, early model assessment relied exclusively on qualitative visual inspection, lacking an automated, objective error metric to quantify predictive accuracy. 

== Final Modeling Methods
The final phase of the project focused on refining the model to handle the significant variability, or "noise," evident in the streambed profiles (as illustrated in Figure 5). This high variability, coupled with the strong correlation between adjacent elevation points, presented a significant risk of overfitting with a standard linear model. To mitigate this, Blocked Cross-Validation was utilized to rigorously determine the optimal regularization parameter ($lambda$). This technique employs temporal "blocking" to preserve the sequential integrity of the dataset, effectively preventing the model from training on future data during the tuning process. Consequently, the model was optimized to predict the final year of available data, establishing a robust baseline for comparison against the actual observed conditions.

== Results and Takeways
In order to produce meaningful results, a user-friendly interface needed to be created in the Pluto notebook interface. Through the use of drop-down menus and various graphs, like those presented in figures 5-7, understanding the data, along with the results, was made possible. Figure 8 shows the resulting plot in which the predicted profile for the last year is superimposed on the actual profile for that same year. The application of SVD with Ridge Regularization effectively decomposed the complex riverbed profiles into two primary behaviors: general changes in bed depth and lateral channel migration (asymmetry). By prioritizing these dominant modes, the model minimized overfitting and produced a stable forecast. While this approach successfully predicted the broader channel shape (low-frequency trends), its smoothing effect limited the ability to capture sharp, high-frequency changes. Consequently, the model excels at forecasting general channel evolution but may underestimate abrupt, localized features such as deep scour holes or steep bank transitions.

#figure(
  image("figures/Figure 8.png", width: 100%),
  caption: [Last Observed Year: Actual v. Predicted Profile],
) <proofread>

It can be seen in Figure 8 that the predicted profile is in relatively good agreement with the actual profile. To make this observation more quantitative, accuracy metrics were applied to the data. The coefficient of determination (COD), more familiarly known as $R^2$, along with the Root Mean Squared Error (RMSE) were chosen to gauge the accuracy of the model. The scope of analysis was limited to three structures on the same river, the Bitterroot. These structures included: _P00007 043+0.666_, _S00373000+04001_, and _S00370 000+0.5361_. Both the upstream and downstream data were analyzed for these structures. Predictions were generated for the final observed year’s profile, and the accuracy metrics were recorded. The results are presented in Table 6.

#figure(
  caption: [Predictive Model Results],
  table(
    columns: (auto, auto, auto, auto),
    table.header([*Structure*], [*Side*], [*$R^2$*], [*RMSE (ft)*]),
 "P00007 043+0.666", "Upstream", "0.68", "2.0",
"P00007 043+0.666", "Downstream", "0.90", "1.9",
"S00373000+04001", "Upstream", "0.74", "1.3",
"S00373000+04001", "Downstream", "0.88", "1.5",
"S00370 000+0.5361", "Upstream", "0.55", "2.2",
"S00370 000+0.5361", "Downstream", "0.56", "2.4"
  ),
) <table-example>

From the results presented in the above table and by referencing the respective figures (Figure 5 and 6) for each structure, it was apparent that of the three structures, the structures with the least variation year to year had more accurate model predictions than the more erratic years. Structure S00370 000+0.5361, both in the upstream and downstream sides, has the most erratic streambed profile year over year. The predicted profiles for this structure had the lowest $R^2$ value, which is supported by the previous statement regarding the erratic streambed elevations. 
#v(0.3em)
While the $R^2$ value differed per structure, something that remained relatively consistent was the RMSE for all observations made. The column in table 6 is reported in feet and represents the magnitude of inaccuracy between the predicted and actual profile at any given point. 

= Discussion

== Hypothesis Assessment

The initial hypothesis posited that analyzing historical streambed profile data using data science methodologies could reveal detectable patterns and key indicators related to scour behavior. The study's findings partially support this hypothesis. The application of SVD combined with Ridge Regularization effectively decomposed complex riverbed profiles into dominant behaviors, enabling the prediction of general channel evolution. The model demonstrated reasonable accuracy, with $R^2$ values ranging from 0.55 to 0.90 across different structures, indicating a capability to capture significant morphological trends. However, limitations in resolving abrupt, localized features—such as deep scour holes or steep bank transitions—suggest that current predictive capabilities do not yet encompass all aspects of scour phenomenology. Furthermore, the variance in $R^2$ values across structures highlights the heterogeneity of model performance. Ultimately, while this study confirms that data science methodologies can uncover meaningful insights into scour behavior, it emphasizes the necessity for further refinement and the integration of exogenous data sources to enhance predictive fidelity.

== Future Efforts

=== More Advanced Modeling Strategies

While the current model yields significant insights into streambed morphology, specific limitations highlight opportunities for further refinement. Future research should investigate non-linear modeling techniques, particularly Neural Networks, to resolve complex, high-order interactions within the data that linear models may overlook. Additionally, the integration of explicit temporal dynamics via advanced time-series analysis would likely enhance the model's capacity to forecast future scour events based on historical morphological trends.

#v(0.3em)

=== Cross Sectional Data improvements

Two seemingly simple but impactful challenges that were faced involved integrating pier locations and standardizing cross-sectional data widths. Pier data is available but will take effort to prepare in a way that it can integrate into this model. The horizontal extents of cross-sectional data varied, which undoubtedly complicated the model's ability to assess and learn patterns. 

#v(0.3em)

=== Relation to Stream Gauge Data

Another potential step for this line of research is drawing connection between the stream gauge data, observed streambed elevation data, and the predictive model. As discussed previously, the USGS keeps vast amounts of stream data, which add key context to when and why given streams may experience scour. 

