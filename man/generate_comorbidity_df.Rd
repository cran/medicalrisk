% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/icd9cm.R
\name{generate_comorbidity_df}
\alias{generate_comorbidity_df}
\title{Generate a comorbidity dataframe}
\usage{
generate_comorbidity_df(
  df,
  idvar = "id",
  icd9var = "icd9cm",
  icd9mapfn = icd9cm_charlson_quan,
  .progress = "none",
  .parallel = FALSE,
  .paropts = NULL
)
}
\arguments{
\item{df}{a data frame with at least two columns, specified as \code{idvar}
and \code{icd9var}.}

\item{idvar}{string with name of ID variable within \code{df} (defaults to
"id")}

\item{icd9var}{string with name of ICD code variable within \code{df}
(defaults to \code{icd9cm})}

\item{icd9mapfn}{Function to generate comorbidity data frame from ICD-9 codes
(defaults to \code{\link{icd9cm_charlson_quan}})}

\item{.progress}{passed to \code{\link{ddply}}}

\item{.parallel}{passed to \code{\link{ddply}}}

\item{.paropts}{passed to \code{\link{ddply}}}
}
\value{
a dataframe with column \code{idvar} and a logical column for each comorbidity
}
\description{
Merges a given DF of IDs and ICD-9-CM codes to one of the ICD9CM maps,
removes redundant comorbidities, and returns a dataframe.
}
\details{
Redundancy rules:
* If "tumor" and "mets", only "mets" will be returned.
* If "htn" and "htncx", only "htncx" will be returned.
* If "dm" and "dmcx", only "dmcx" will be returned.
* If "liver" and "modliver", only "modliver" will be returned.

Van Walraven has a modification adopted here where the following "dmcx" codes
are downgraded to "dm" if the specific DM complication is separately coded:
* D2(49|50)4x is DM w renal
* D2(49|50)6x is DM w neuro
* D2(49|50)7x is DM w PVD

Cases without any comorbidities will not appear in the returned data
frame.
}
\examples{
cases <- data.frame(id=c(1,1,1,2,2,2,2,2),
         icd9cm=c("D20206","D24220","D4439","D5064","DE8788","D40403","D1960","D1958"),
         stringsAsFactors=TRUE)
generate_comorbidity_df(cases)
# generate categories for patients in the \code{\link{vt_inp_sample}}
generate_comorbidity_df(vt_inp_sample)
# in this example, D25071 is reduced to "dm" from "dmcx" because D4439 already codes perivasc
# also, D20206 "tumor" and D1970 "mets" lead to just "mets"
# D25001 and D25040 are just "dmcx"
# D45621 and D570 are just "modliver"
cases <- data.frame(id=c(1,1,1,1,2,2,2,2),
  icd9cm=c("D1970","D20206","D25071","D4439","D25001","D25040","D45621","D570"),
  stringsAsFactors=TRUE)
generate_comorbidity_df(cases)
}
