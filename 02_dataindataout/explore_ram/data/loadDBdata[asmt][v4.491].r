###################################################################################
###################################################################################
###################################################################################
#
# This will load database data from the file DBdata.RData. Put the data file in the
# working directory, then run the line at the bottom of the file.
#
###################################################################################
###################################################################################
###################################################################################
#
# The following objects are tables from RAM (data frames):
#
# --- metadata
#	Summarized metadata
# --- stock
#	General stock metadata
# --- assessment
#	General assessment metadata
# --- taxonomy
#	Taxonomic metadata
# --- management
#	Management authority metadata
# --- assessor
#	Stock assessor metadata
# --- assessmethod
#	Assessment method metadata
# --- area
#	Area metadata
# --- biometrics
#	Parameter data types with descriptions
# --- tsmetrics
#	Time series data types with descriptions
# --- timeseries
#	Full time series data listing
# --- bioparams
#	Full parameter data listing
# --- timeseries_values_views
#	Values by stock and year of common time series types
# --- timeseries_units_views
#	Units corresponding to values in timeseries_values_views
# --- timeseries_ids_views
#	Time series IDs corresponding to values in timeseries_values_views
# --- timeseries_assessments_views
#	Assessment IDs corresponding to values in timeseries_values_views
# --- timeseries_notes_views
#	Notes corresponding to values in timeseries_values_views
# --- timeseries_sources_views
#	Sources corresponding to values in timeseries_values_views
# --- timeseries_years_views
#	Year range corresponding to values in timeseries_values_views
# --- bioparams_values_views
#	Values by stock of common parameter types
# --- bioparams_units_views
#	Units corresponding to values in bioparams_values_views
# --- bioparams_ids_views
#	Parameter IDs corresponding to values in bioparams_values_views
# --- bioparams_assessments_views
#	Assessment IDs corresponding to values in bioparams_values_views
# --- bioparams_sources_views
#	Sources corresponding to values in bioparams_values_views
# --- bioparams_notes_views
#	Notes corresponding to values in bioparams_values_views
#
# ---------------------------------------------------------------------------------------------------
#
# There are also dataframes for the individual most-used time series:
#
# --- tb.data --- Total biomass data
# --- ssb.data --- Spawning stock biomass data
# --- tn.data --- Total abundance data
# --- r.data --- Recruits data
# --- tc.data --- Total catch data
# --- tl.data --- Total landings data
# --- recc.data --- Recreational catch data
# --- f.data --- Fishing mortality data (usually an instantaneous rate)
# --- er.data --- Exploitation rate data (usually an annual fraction harvested)
# --- divtb.data --- TB/TBmsy data
# --- divssb.data --- SSB/SSBmsy data
# --- divf.data --- F/Fmsy data
# --- diver.data --- ER/ERmsy data
# --- divbpref.data --- B/Bmsy pref data (B/Bmsy if available, otherwise B/Bmgt)
# --- divupref.data --- U/Umsy pref data (U/Umsy if available, otherwise U/Umgt)
# --- tbbest.data --- TBbest data (all in MT)
# --- tcbest.data --- TCbest data (all in MT)
# --- erbest.data --- ERbest data (usually an annual fraction harvested)
# --- divtb.mgt.data --- TB/TBmgt data
# --- divssb.mgt.data --- SSB/SSBmgt data
# --- divf.mgt.data --- F/Fmgt data
# --- diver.mgt.data --- ER/ERmgt data
# --- divbpref.mgt.data --- B/Bmgt pref data (B/Bmgt if available, otherwise B/Bmsy)
# --- divupref.mgt.data --- U/Umgt pref data (U/Umgt if available, otherwise U/Umsy)
# --- cpair.data --- Catch data that pairs with tac.data and/or cadv.data
# --- tac.data --- TAC data
# --- cadv.data --- Scientific advice for catch limit data
# --- survb.data --- Fishery-independent survey abundance data
# --- cpue.data --- CPUE data (fishery-dependent)
# --- effort.data --- Fishing effort data (fishery-dependent)
# --- divtn.data --- TN/TNmsy data
# --- divtn.mgt.data --- TN/TNmgt data
# --- cdivmeanc.data --- Catch/(mean catch) data
# --- cdivmsy.data --- Catch/MSY data
#
###################################################################################
###################################################################################
###################################################################################
#
# Once the DBdata.RData file is in the working directory, simply run the following command to
# load up the database data into matrix/dataframe files for the assessment only version of the database.


load("DBdata[asmt][v4.491].RData")


