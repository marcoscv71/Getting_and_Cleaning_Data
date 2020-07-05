####### Reading HDF5 files

# Used for storing large data sets
# Supports storing a range of data types
# Hierarchical data format
# groups containing zero or more data sets and metadata
#    - Have a group header with group name and list of attributes
#    - Have a group symbol table with a list of objects in group
# datasets multidimensional array of data elements with metadata
#    - Have a header with name, datatype, dataspace, and storage layout
#    - Have a data array with the data
# http://hdfgroup.org

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.11")

library(BiocManager)
BiocManager::available()
BiocManager::valid() 
BiocManager::install("rhdf5")

library(rhdf5)

created <- h5createFile("example.h5")
created

created <- h5createGroup("example.h5", "foo")
created <- h5createGroup("example.h5", "baa")
created <- h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

# Write to groups
A <- matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B <- array(seq(0.1, 2.0, by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

# Write a data set
df <- data.frame(1L:5L, seq(0, 1, length.out = 5),
                 c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
h5write(df, "example.h5", "df")
h5ls("example.h5")


# Reading data
readA <- h5read("example.h5", "foo/A")
readA <- h5read("example.h5", "foo/foobaa/B")
readdf <- h5read("example.h5", "df")
readA
readdf

# Writing and reading chunks
h5write(c(12, 13, 14), "example.h5","foo/A", index=list(1:3, 1))
h5read("example.h5", "foo/A")
