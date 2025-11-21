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
#v(0.3em)
Given this context, the project team’s primary research hypothesis is that an analysis of historical stream bed profile data, when processed using data science methodologies, can reveal detectable patterns and key indicators related to scour behavior at specific bridge locations if the necessary, yet rudimentary, data is collected. This study specifically investigates this hypothesis by applying the Julia programming language to analyze stream bed profile data supplied by the USGS for select bridges in the state of Montana. While the precise scope of the project evolved during the Exploratory Data Analysis (EDA) phase, the fundamental objective remained unchanged: to use data science to uncover actionable insights from hydrological and structural data related to bridge scour.

#v(0.3em)

Along with strictly investigating model improvements, the team tried evalauating existing industry and academic sources in order to better contexualize the findings of this project. Initial sources came from The _Journal of Hydrology_ @Anderson, _River Research and Applications_ @Brown, _Water Resources Research_ @Davis, and the _Journal of the Transportation Research Board_ @Yousefpour2021. More on this subject is covered later in this report. 

== The Problem of Bridge Scour

The load paths of bridges eventually lead to the Earth and the soil or rock within.  Water is a powerful force often working against that foundation.  Since bridges often exist to span waterways, they are especially vulnerable to large flood events. In fact, hydraulic-related issues are the leading cause of bridge failures in The United States @LeeBridge. Some researchers have even estimated that scour alone can result in the cause of 20-100 bridge collapses per year in the United States @Flintetal. There are complex interactions which drive potential bridge failures. #v(0.3em) 

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

Bridge scour is the erosion of sediment, such as sand and gravel, around bridge foundations, including piers and abutments, caused by flowing water. There are three main types of scour: local scour, which occurs around individual piers or abutments due to faster water flow; contraction scour, resulting from the narrowing of the river channel at the bridge, which increases water velocity and sediment removal; and degradational scour, which involves the gradual lowering of the riverbed upstream and downstream of the bridge. This phenomenon accounts for approximately 31.53% of hydraulic failures and is a major cause of bridge collapses worldwide. Traditional methods for predicting scour are often unreliable, but recent advancements in artificial intelligence (AI) and machine learning (ML) techniques are improving prediction accuracy.
#v(0.3em)
Additionally, studies have demonstrated that AI models, such as Decision Tree Regressors and XGBoost, outperform traditional regression methods in estimating equilibrium scour depth around bridge abutments, highlighting the potential of AI in hydraulic engineering. Furthermore, the integration of physics-based equations into deep learning models has shown promise in reducing forecasting errors by up to fifthy percent, indicating a significant improvement over purely data-driven approaches. These developments suggest that AI and ML methodologies, when combined with real-time monitoring systems, can revolutionize bridge scour risk management, offering more accurate and timely predictions to safeguard infrastructure. 

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
  $ y_s = 2.27 K_1 K_2 (L')^0.43 y_a^0.57 "Fr"^0.61 + y_a 
  
  #v(0.3em) 

  While initial goals were to create a model that could directly utilize these equations, the complexity was too high given the available resourches. As such, making the connection to these equations is left to future work.

  #v(0.3em) 

= Exploratory Data Analysis (EDA)

This study initially aimed to integrate diverse datasets from the USGS to ancillary datasets related to stream flow and weather data. The core datasets contained cross-sectional geometry, longitudinal streambed profiles, bridge pier geometry and location, along with water surface profiles. However, the Exploratory Data Analysis (EDA) phase revealed that harmonizing these disparate, independent datasets presented significant logistical challenges that threatened the project's feasibility. Consequently, the research team used the EDA process to refine the study's scope, shifting focus from broad hydraulic integration toward identifying actionable trends in streambed elevation changes to predict trends and optimize inspection intervals. 

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

The research team entered the EDA phase with the intent of further investigating the available data sources and refining its project statement. Despite best efforts, the initial findings suggested that the initial goals of the project were too challenging given the availability, complexity, and format of the necessary data. The available scour data, from the State of Montana USGS data, included numerous unique and rather independent datasets, including cross-sectional geometry data, longitudinal profile data, pier structure data, water surface profiles, and sporadic but extensive stream flow data. Attempting to collect, refine, and subsequently tie such a wide variety of complex data was decidedly understood to be beyond the scope of the project.  
#v(0.3em)
To give example, in order to try and identify and model the relationships between stream flows and scour, the team would have needed to first find a bridge with enough data between 2012 and 2024, locate the subject bridge on the USGS StreamStats GIS page, investigate if there was a stream gauge measuring data in close proximity, and if that were true then hope that the dates on the stream gauge data (similar to that presented in Figure 4) coincided with the data collected on scour/elevation. It was determined by the research team that the described task would be far too challenging in itself, let alone decomposing and cleaning/tidying the complicated stream flow data in addition to the stream elevation data. 

#figure(
  image("figures/Example_StreamStats_Data.png", width: 100%),
  caption: [Example StreamStats data from USGS.],
) <proofread>

With the aforementioned limitations identified, the research team focused attention and efforts on finding a reasonable but potentially impactful way to analyze some of the data on hand. Remember, bridge scour is a serious concern for State and Federal entities, leading to thousands and even millions of dollars spent in monitoring costs. The research team thus changed its priority to evaluating if applying data science could help identify and model trends in streambed elevations. If correlations did prove to exist, a reliable model could be produced, having the potential to allow States and the Federal Government to more intelligently determine at what interval monitoring should be conducted, as opposed to standardized (and costly) yearly or bi-yearly. Successful modeling could also help prioritize vulnerable or critical bridges, potentially reducing collapse risks. The data the project team preliminarily focused on is summarized in Table V below.

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

Consequently, the research team successfully compiled the cross-sectional streambed data provided by the USGS, ranging from 2012 to 2024, into a single dataframe that had the potential to be used for the predictive modeling. The Julia language was used within a Pluto workbook interface, where initial cleaning/tidying of the data was performed. Cleaning efforts included simplifying and standardizing dataframe descriptions, cleaning and reformatting dates, and removing unnecessary rows and columns. Following this, the team began simplifying the ability to visualize the data. Figure 5 shows the plots of a sample bridge, with both upstream and downstream surface elevations changing throughout the observed years. While this presentation provides an overall view of the streambed elevations across the observed range of years, it can at times be difficult to interpret from a vast legend what profile relates to which year. Thus, an additional presentation was chosen. In this additional presentation, each observed year for a given structure is provided a separate graph with the previous year’s profile superimposed in a dashed line on the same graph. This allowed for easier interpretation of whether the difference from one year to the next was considered a cut, fill, or balance. 
#v(0.3em)
Both presentations of the streambed elevations across overserved years were seen as beneficial to the project team and a significant improvement on the native visualization provided by the USGS. The Figure 5 presentation allows the observer to account for overall variation of the dataset. Contrastingly, the presentation presented in Figure 6 allows, as previously discussed, the observer to account for cuts, fills, or balances in the overall streambed across observed years. In the project team’s opinion, the characterization of the streambed year to year as a cut, fill, or balance is seen as the most holistic take on the comparison of streambed profiles. The profiles presented in Figure 6 have been normalized following recommendations provided to the project team. This normalization allows for comparison between profiles at different structures.  

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

With the project scope refined and simplified, the research team sought out to begin planning on how to refine the data further and formulate how to eventually generate the predictive model. The team was foremost interested in determining if there were noticeable trends in the streambed data over time. After evaluating the methods learned in CEE 492 to date, the research team decided that SVD and PCA were the best methods to pursue. The first step required the data to be reformatted. The restructuring involved transitioning the initial data frame, which was a comprehensive collection of all bridges, across all years, and both upstream and downstream elevations, into a matrix format that was suitable for SVD/PCA analysis and focused on singular bridges with separated upstream and downstream matrices. Our team realized that the first and second modes of the PCA/SVD analyses were able to provide the most useful information. Figure 7 below shows an example of two calculated modes. The first mode captured the overall summation of cut and fill across the stream bed, while the second mode focused more on local changes. The trends presented in the second mode of the SVD/PCA are thought to be the most applicable to the scour problem at hand since they have the possibility of being correlated with the known pier coordinates at each bridge location.
#v(0.3em)

#figure(
  image("figures/Figure 7.png", width: 100%),
  caption: [SVD Modes 1 & 2 for Subject Bridge Structure],
) <proofread>

Following the reformatting of the data, the team focused on developing the predictive model. With 16 sreams and 33 bridges, the team decided to narrow the scope of the report to bridges located along a single watercourse. Prioritizing a river with abundant, high-quality historical data was critical to this approach. Preliminary analysis identified the Bitterroot River as a prime candidate, featuring three distinct structures with over five years of observation data. While the team considered an alternative approach—developing a single-bridge model using a temporal training split (e.g., 2012–2020) for validation, the multi-bridge analysis of the Bitterroot River was selected as the superior strategy. 

The initial model was not without its shortcomings, though, some of which the team was able to resolve and some that weren't. First, the team struggled to grasp how to integrate stream/bridge pier data or account for different years not surveying the same cross-section length, effectively cutting off chunks of potential data. The native USGS data contained pier locations, but their underlying data were in different dataframes and formats. Second, the multiple linear regression model, while initially functioning, was static, requiring manual inputs of bridge information, the regularization value, learning rate, and number of steps/interations for every bridge, every time the model was run. Furthermore, different bridges caried different amounts of data, meaning input variables may not apply universally. Finally, the model's predictions were purely visual, without an automated, subjective error metric to quantify accuracy. 

== Final Modeling Methods
The team entered the final stage of the project with improvements and fine tuning in mind. Most of the stream bed profiles investigated by the project team exhibited significant variability (or 'noise'), as seen for the 2023 data in Figure 5. This high variability, combined with the fact that adjacent elevation points were highly correlated, had a high probability to make a standard model overfit the data. To account for this, the team utilized cross-validation to have the model determine the optimal regularization parameter (lambda) automatically. The cross-validation was further improved by utilizing "blocking" to prevent the model from accidentally training on future data. Using these methods, the model was tuned to output a prediction of the last year of data, which could then be compared to the actual last year of data. 

== Results and Takeways
In order to produce meaningful results, a user-friendly interface needed to be created in the Pluto notebook interface. Through the use of drop-down menus and various graphs, like those presented in figures 5-7, understanding the data, along with the results, was made possible. Figure 8 shows the resulting plot in which the predicted profile for the last year is superimposed on the actual profile for that same year. The application of SVD with Ridge Regularization effectively decomposed the complex riverbed profiles into two primary behaviors: general changes in bed depth and lateral channel migration (asymmetry). By prioritizing these dominant modes, the model minimized overfitting and produced a stable forecast. While this approach successfully predicted the broader channel shape (low-frequency trends), its smoothing effect limited the ability to capture sharp, high-frequency changes. Consequently, the model excels at forecasting general channel evolution but may underestimate abrupt, localized features such as deep scour holes or steep bank transitions.

#figure(
  image("figures/Figure 8.png", width: 100%),
  caption: [Last Observed Year: Actual v. Predicted Profile],
) <proofread>

It can be seen in Figure 8 that the predicted profile is in relatively good agreement with the actual profile. To make this observation more quantitative, the project team worked on applying accuracy metrics to the data. The project team chose to use the coefficient of determination (COD), more familiarly known as R^2, along with Root Mean Squared Error (RMSE) to gauge the accuracy of the model. The scope of analysis was limited to three structures on the same river, the Bitterroot. These structures included: P00007 043+0.666, S00373000+04001, S00370 000+0.5361. Both the upstream and downstream data were analyzed for these structures. Predictions made for the final observed year’s profile were made and the accuracy metrics were recorded. The results are presented in the following table, Table  6.

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
#v(0.3em)
While the R^2 value differed per structure, something that remained relatively consistent was the RMSE for all observations made. The column in table 6 is reported in feet and represents the magnitude of inaccuracy between the predicted and actual profile at any given point. 

= Discussion

== Hypothesis Assessment

The team's initial hypothesis was that analyzing historical stream bed profile data using data science methodologies could reveal detectable patterns and key indicators related to scour behavior at specific bridge locations, provided that the necessary data was collected. The study's findings partially support this hypothesis. The application of SVD with Ridge Regularization allowed the model to effectively decompose complex riverbed profiles into dominant behaviors, enabling the prediction of general channel evolution. The model demonstrated reasonable accuracy, with R^2 values ranging from 0.55 to 0.90 across different structures and sides, indicating that it could capture significant trends in the data. However, the model's limitations in capturing abrupt, localized features such as deep scour holes or steep bank transitions suggest that while patterns can be detected, they may not fully encompass all aspects of scour behavior. The variability in R^2 values across structures further indicates that the model's effectiveness remains largely variable. Overall, while the study confirms that data science methodologies can uncover meaningful insights into scour behavior, it also highlights the need for further refinement and integration of additional data sources to enhance predictive capabilities.

== Future Efforts

=== More Advanced Modeling Strategies

The research team recognizes that while the current model provides valuable insights, there are shortcomings and several avenues for future enhancement. One potential direction is to explore non-linear modeling techniques disussed in class, such as neural networks, which may better capture complex interactions within the data. Additionally, incorporating temporal dynamics through time-series analysis could improve the model's ability to predict future scour events based on historical trends.

#v(0.3em)

=== Cross Sectional Data improvements

Two seemingly simple but impactful challenges that were faced involved integrating pier locations and standardizing cross-sectional data widths. Pier data is available but will take effort to prepare in a way that it can integrate into this model. The horizontal extents of cross-sectional data varied, which undoubtedly complicated the model's ability to assess and learn patterns. 

#v(0.3em)

=== Relation to Stream Gauge Data

Another potential step for this line of research is drawing connection between the stream gauge data, observed streambed elevation data, and the predictive model. As discussed previously, the USGS keeps vast amounts of stream data, which add key context to when and why given streams may experience scour. 

