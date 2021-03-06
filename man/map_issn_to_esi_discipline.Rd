% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map_issn_to_esi_discipline.R
\name{map_issn_to_esi_discipline}
\alias{map_issn_to_esi_discipline}
\title{map issn to ESI discipline}
\usage{
map_issn_to_esi_discipline(var)
}
\arguments{
\item{var}{a column contains the ISSN of Journals}
}
\value{
data.frame that adds a new column of ESI discipline which mapped from issn
}
\description{
map issn to ESI discipline
}
\examples{
df \%>\% mutate(discipline = map_issn_to_esi_discipline(issn))
}
