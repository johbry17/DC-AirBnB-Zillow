\name{cowsay}
\alias{cowsay}
\title{Cow Say}
\description{A cow that says hello.}
\usage{
cowsay(phrase = "hello, world")
}
\arguments{
\item{phrase}{The phrase for the cow to say.}
}
\value{
A string representation of a cow saying the given phrase.
}
\examples{
cat(cowsay())
cat(cowsay("moo!"))
}
