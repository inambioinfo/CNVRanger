% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pheno_assoc.R
\name{importLRR_BAF}
\alias{importLRR_BAF}
\title{Import LRR and BAF from text files used in the CNV analysis}
\usage{
importLRR_BAF(all.paths, path.files, list.of.files, verbose = TRUE)
}
\arguments{
\item{all.paths}{Object returned from \code{CreateFolderTree} function with 
the working folder tree}

\item{path.files}{Folder containing the input CNV files used for the CNV 
calling (i.e. one text file with 5 collumns for each sample). Columns should 
contain (i) probe name, (ii) Chromosome, (iii) Position, (iv) LRR, and (v) BAF.}

\item{list.of.files}{Data-frame with two columns where the (i) is the file 
name with signals and (ii) is the correspondent name of the sample in the gds file}

\item{verbose}{Print the samples while importing}
}
\description{
This function imports the LRR/BAF values and create a node for each one in 
the GDS file at the working folder 'Inputs' created by the 
\code{\link{setupCnvGWAS}} function. Once imported, the LRR values can be 
used to perform a GWAS directly as an alternative to copy number dosage
}
\examples{

# Load phenotype-CNV information
data.dir <- system.file("extdata", package="CNVRanger")

phen.loc <- file.path(data.dir, "Pheno.txt")
cnv.out.loc <- file.path(data.dir, "CNVOut.txt")
map.loc <- file.path(data.dir, "MapPenn.txt")

phen.info <- setupCnvGWAS('Example', phen.loc, cnv.out.loc, map.loc)

# Extract path names
all.paths <- phen.info$all.paths

# List files to import LRR/BAF 
list.of.files <- list.files(path=data.dir, pattern="cnv.txt.adjusted$")
list.of.files <- as.data.frame(list.of.files)
colnames(list.of.files)[1] <- "file.names"
list.of.files$sample.names <- sub(".cnv.txt.adjusted$", "", list.of.files$file.names)

# All missing samples will have LRR = '0' and BAF = '0.5' in all SNPs listed in the GDS file
importLRR_BAF(all.paths, data.dir, list.of.files)

# Read the GDS to check if the LRR/BAF nodes were added
cnv.gds <- file.path(all.paths[1], 'CNV.gds')    
genofile <- SNPRelate::snpgdsOpen(cnv.gds, allow.fork=TRUE, readonly=FALSE)
SNPRelate::snpgdsClose(genofile)

}
\author{
Vinicius Henrique da Silva <vinicius.dasilva@wur.nl>
}
