% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/icd9cm.R
\name{icd9cm_charlson_romano}
\alias{icd9cm_charlson_romano}
\title{Create Romano map of ICD-9-CM to Charlson comorbidities}
\usage{
icd9cm_charlson_romano(icd9)
}
\arguments{
\item{icd9}{a unique character vector of ICD-9-CM codes}
}
\value{
A data frame, with ICD9 codes as row names and one logical column for each
comorbidity in \code{\link{charlson_list}}
}
\description{
Function that creates a dataframe which links ICD-9-CM codes to the Charlson
comorbidity categories using the Romano mapping.
}
\details{
NOTE: The input vector of ICD-9-CM codes must be unique, because the output dataframe
uses the ICD-9-CM code as row.name.

Uses regular expressions created from the paper by Romano in 1993.

ICD-9-CM codes must have periods removed.  Diagnostic codes are prefixed with
'D' while procedure codes are prefixed with 'P'. So, diagnostic code
\code{404.03} should be \code{"D40403"}.
}
\examples{
# Identify Charlson categories in ICD-9-CM listing
cases <- data.frame(id=c(1,1,1,2,2,2),
  icd9cm=c("D20206","D24220","D4439","D5064","DE8788","D40403"),
  stringsAsFactors=TRUE)
cases_with_cm <- merge(cases, icd9cm_charlson_romano(levels(cases$icd9cm)),
  by.x="icd9cm", by.y="row.names", all.x=TRUE)

# generate crude comorbidity summary for each patient
library(plyr)
ddply(cases_with_cm, .(id),
  function(x) { data.frame(lapply(x[,3:ncol(x)], any)) })
}
\references{
1. Romano PS, Roos LL, Jollis JG: Adapting a clinical comorbidity index for
use with ICD-9-CM administrative data: differing perspectives. Journal of
clinical epidemiology 1993; 46:1075-9; discussion 1081-90
  \url{http://www.ncbi.nlm.nih.gov/pubmed/8410092}
}
\seealso{
\code{\link{icd9cm_charlson_quan}}, \code{\link{icd9cm_charlson_deyo}},
   \code{\link{icd9cm_elixhauser_quan}}, \code{\link{icd9cm_elixhauser_ahrq37}},
   \code{\link{charlson_weights}},
}
