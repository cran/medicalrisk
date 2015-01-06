medicalrisk
======

medicalrisk is a collection of tools and data for performing patient-level medical 
risk adjustment using administrative data.

The data sets include `icd9cm_charlson` and `icd9cm_elixhauser`, which are data
frames that map ICD-9-CM codes to comorbidities, using the Charlson
and Elixhauser classifications respectively.  The mapping comes from the paper by 
Quan in 2005, and uses the CMS 2012 ICD-9-CM table.  With a properly formatted
source data frame of patients and ICD-9-CM values, the `cast` or `dcast` methods
can be used to generate comorbidity tables.

The `add_charlson_index_df` method will calculate the Charlson Comorbidity Index 
for each patient.

For data sources that present ICD-9-CM codes as a comma-separated listing, the 
`melt_icd9list` method will convert such data tables into a one-row-per-code format
suitable for `join` or `merge` to the `icd9cm_*` tables.
