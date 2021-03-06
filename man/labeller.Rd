% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/facet-labels.r
\name{labeller}
\alias{labeller}
\title{Generic labeller function for facets}
\usage{
labeller(..., keep.as.numeric = FALSE)
}
\arguments{
\item{...}{Named arguments of the form \code{variable=values},
where \code{values} could be a vector or method.}

\item{keep.as.numeric}{logical, default TRUE. When FALSE, converts numeric
values supplied as margins to the facet to characters.}
}
\value{
Function to supply to
  \code{\link{facet_grid}} for the argument \code{labeller}.
}
\description{
One-step function for providing methods or named character vectors
for displaying labels in facets.
}
\details{
The provided methods are checked for number of arguments.
If the provided method takes less than two
(e.g. \code{\link[Hmisc]{capitalize}}),
the method is passed \code{values}.
Else (e.g. \code{\link{label_both}}),
it is passed \code{variable} and \code{values} (in that order).
If you want to be certain, use e.g. an anonymous function.
If errors are returned such as ``argument ".." is missing, with no default''
or ``unused argument (variable)'', matching the method's arguments does not
work as expected; make a wrapper function.
}
\examples{
\donttest{
p1 <- ggplot(mpg, aes(cty, hwy)) + geom_point()
p1 + facet_grid(cyl ~ class, labeller=label_both)
p1 + facet_grid(cyl ~ class, labeller=labeller(cyl=label_both))

ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point() +
  facet_grid(vs + am ~ gear, margins=TRUE,
             labeller=labeller(vs=label_both, am=label_both))

capitalize <- function(string) {
  substr(string, 1, 1) <- toupper(substr(string, 1, 1))
  string
}
conservation_status <- c('cd'='Conservation Dependent',
                         'en'='Endangered',
                         'lc'='Least concern',
                         'nt'='Near Threatened',
                         'vu'='Vulnerable',
                         'domesticated'='Domesticated')
## Source: http://en.wikipedia.org/wiki/Wikipedia:Conservation_status

p2 <- ggplot(msleep, aes(x=sleep_total, y=awake)) + geom_point()
p2 + facet_grid(vore ~ conservation, labeller = labeller(vore = capitalize))

p2 + facet_grid(vore ~ conservation,
  labeller=labeller(vore = capitalize, conservation = conservation_status ))

# We could of course have renamed the levels;
# then we can apply another nifty function
msleep$conservation2 <- plyr::revalue(msleep$conservation, conservation_status)

p2 \%+\% msleep +
  facet_grid(vore ~ conservation2, labeller = labeller(vore = capitalize))
p2 \%+\% msleep +
 facet_grid(vore ~ conservation2, labeller = labeller(conservation2 =
 label_wrap_gen(10)))
}
}

