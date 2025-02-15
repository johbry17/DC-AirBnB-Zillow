\name{fishsay}
\alias{fishsay}
\title{Fish Say}
\description{A fish that says hello.}
\usage{
fishsay(phrase = "hello, world")
}
\arguments{
\item{phrase}{The phrase for the fish to say.}
}
\value{
A string representation of a fish saying the given phrase.
}
\examples{
cat(fishsay())
cat(fishsay("blub blub!"))
}
