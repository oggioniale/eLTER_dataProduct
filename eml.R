# EML from https://docs.ropensci.org/EML/articles/creating-EML.html ----
# 1. Attributes ----
# mandatory are "attributeName" and "attributeDefinition"
attributes <-
  tibble::tribble(
    ~attributeName, ~attributeDefinition,                                                 ~formatString, ~definition,        ~unit,   ~numberType,
    "run.num",    "which run number (=block). Range: 1 - 6. (integer)",                 NA,            "which run number", NA,       NA,
    "year",       "year, 2012",                                                         "YYYY",        NA,                 NA,       NA,
    "day",        "Julian day. Range: 170 - 209.",                                      "DDD",         NA,                 NA,       NA,
    "hour.min",   "hour and minute of observation. Range 1 - 2400 (integer)",           "hhmm",        NA,                 NA,       NA,
    "i.flag",     "is variable Real, Interpolated or Bad (character/factor)",           NA,            NA,                 NA,       NA,
    "variable",   "what variable being measured in what treatment (character/factor).", NA,            NA,                 NA,       NA,
    "value.i",    "value of measured variable for run.num on year/day/hour.min.",       NA,            NA,                 NA,       NA,
    "length",    "length of the species in meters (dummy example of numeric data)",     NA,            NA,                 "meter",  "real")

# Attributes list ----
i.flag <- c(R = "real",
            I = "interpolated",
            B = "bad")
variable <- c(
  control  = "no prey added",
  low      = "0.125 mg prey added ml-1 d-1",
  med.low  = "0,25 mg prey added ml-1 d-1",
  med.high = "0.5 mg prey added ml-1 d-1",
  high     = "1.0 mg prey added ml-1 d-1",
  air.temp = "air temperature measured just above all plants (1 thermocouple)",
  water.temp = "water temperature measured within each pitcher",
  par       = "photosynthetic active radiation (PAR) measured just above all plants (1 sensor)"
)

value.i <- c(
  control  = "% dissolved oxygen",
  low      = "% dissolved oxygen",
  med.low  = "% dissolved oxygen",
  med.high = "% dissolved oxygen",
  high     = "% dissolved oxygen",
  air.temp = "degrees C",
  water.temp = "degrees C",
  par      = "micromoles m-1 s-1"
)

## Write these into the data.frame format
factors <- rbind(
  data.frame(
    attributeName = "i.flag",
    code = names(i.flag),
    definition = unname(i.flag)
  ),
  data.frame(
    attributeName = "variable",
    code = names(variable),
    definition = unname(variable)
  ),
  data.frame(
    attributeName = "value.i",
    code = names(value.i),
    definition = unname(value.i)
  )
)
attributeList <- magrittr::set_attributes(attributes, factors)#, col_classes = c("character", "Date", "Date", "Date", "factor", "factor", "factor", "numeric"))

# 2. Data file format ----
physical <- EML::set_physical("level1.RData")

# 3. Assembling the dataTable ----
dataTable <- list(
  entityName = "level1.RData",
  entityDescription = "R file (RData) that contain 2 datasets about density (cell/ml) and biomass (mm3/m3) of phytoplankton sampling in the montly campains from January 1986 and Dicember 1987 and counting by inverted microscope. The datasets are harmonized by structural, spatial, temporal, taxonomic, and semantic folowing the gudeline of eLTER RI",
  physical = physical,
  attributeList = attributeList)

# 4. Coverage metadata ----
geographicDescription <- "Lake Candia is located near the city of Tourin in the northern-western Italy and belongs to the Italian, European and International Long-Term Ecological Research (LTER) Networks: Candia (https://deims.org/c7fe4203-24b1-4d11-a573-99b99204fede)."

coverage <- EML::set_coverage(
  begin = '1986-03-06',
  end = '1987-12-02',
  sci_names = c("Asterionella formosa","Melosira varians","Chrysococcus","Dinobryon divergens","Mallomonas akrokomos","Mallomonas","Oocystis","Pediastrum duplex","Sorastrum","Sphaerocystis schroeteri","Staurastrum gracile","Woronichinia robusta","Drepanochloris nannoselene","Closterium","Cosmarium","Franceia ovalis","Planktolyngbya limnetica","Synedra radians var. radians","Merismopedia","Scenedesmus","Ceratium hirundinella","Closterium acutum var. variabile","Lemmermannia triangularis","Schroederia setigera","Rhabdogloea smithii","Peridinium","Phacus tortus","Ankistrodesmus falcatus","Tetraedron minimum","Limnothrix pseudospirulina","Microcystis aeruginosa","Oscillatoria planctonica","Closterium gracile","Elakatothrix","Staurastrum avicula var. lunatum","Tetraedron trigonum","Mallomonas tonsurata","Dictyosphaerium","Uroglena","Fragilaria crotonensis","Cryptomonas","Rhodomonas","Dinobryon","Chrysidalis","Mallomonas caudata","Coelastrum"),
  geographicDescription = geographicDescription,
  west = 7.8982377891131277, east = 7.9221609860244682, 
  north = 45.3326839395734140, south = 45.3185487960114131
)

# 5. Creating methods ----
methods <- EML::set_methods(methods_file = "hf205-methods.md")

# 6. Creating parties ----
R_person <- person(
  "Alessandro",
  "Oggioni",
  "alessandro.oggioni@cnr.it",
  "cre", 
  c(ORCID = "0000-0002-7997-219X")
)
oggioni <- EML::as_emld(R_person)
IREA_address <- list(
  deliveryPoint = "Via Alfonso Corti 12",
  city = "Milan",
  administrativeArea = "MI",
  postalCode = "20154",
  country = "Italy")
publisher <- list(
  organizationName = "CNR - IREA",
  address = IREA_address)
contact <- 
  list(
    individualName = oggioni$individualName,
    electronicMailAddress = oggioni$electronicMailAddress,
    address = IREA_address,
    organizationName = "CNR - IREA",
    phone = "000-000-0000")

# 7. Keywords ----
keywordSet <- list(
  list(
    keywordThesaurus = "...",
    keyword = list("occurrence", "Darwin Core", "GBIF", "occurrences", "phytoplankton", "LTER-Italy", "Lake Candia")
  ))

# 8. date ----
pubDate <- "2023" 

# 9. title ----
title <- "A long-term (1986-2010) phytoplankton dataset from the LTER-Italy site Lake Candia"

# 10. abstract ----
abstract <- "This georeferenced dataset describes a 25-year (1986-2010) monitoring studies of phytoplankton abundance and biomass in Lake Candia, a eutrophic, natural, small, and shallow lake located in north-western Italy. The lake has been subjected to biomanipulation experiments aiming to improve its water quality since 1986 to 2010. It belongs to the national (LTER-Italy), European (LTER-Europe) and International (ILTER) long-term ecological research (LTER) networks. Making available this dataset also represents a contribution to the current activities of the LTER networks, aiming at making accessible the time series of the LTER sites, in order to reconstruct trends and dynamics and to identify and compare reliable trends and can be useful for further ecological and biodiversity studies on small and shallow lakes. The interest of the dataset is also remarkable because Lake Candia belongs to the national (LTER-Italy), European (LTER-Europe) and International (ILTER) long-term ecological research (LTER) networks, where the long-term site-based monitoring approach and the site comparison are important to determine spatial and temporal trends and changes."

# 11. Rights ----
intellectualRights <- "Creative Commons Attribution (CC-BY) 4.0 License"

# 12. data table ----
dataset <- list(
  title = title,
  creator = aaron,
  pubDate = pubDate,
  intellectualRights = intellectualRights,
  abstract = abstract,
  associatedParty = associatedParty,
  keywordSet = keywordSet,
  coverage = coverage,
  contact = contact,
  methods = methods,
  dataTable = dataTable)

# 13. create eml object ----
eml <- list(
  packageId = uuid::UUIDgenerate(),
  system = "uuid", # type of identifier
  dataset = dataset)

# 14. XML file ----
EML::write_eml(eml, "eml.xml")
