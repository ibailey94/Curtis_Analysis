library(ape)
library(tidyverse)

#read in species list of 2021 data
veg_2021 <- as_tibble(read.csv(
  "/Users/isaacbailey/Documents/Curtis_Prairie_EA/Final_2021_Curtis_Sample_03032022.csv", header = TRUE))

#sort into distinct species
keep_species <- distinct(veg_2021, Scientific_name)

#reformat of species list for tree pruning
keep_species$Scientific_name <- as.character(keep_species$Scientific_name)
keep <- gsub(" ", "_", keep_species$Scientific_name)

#reading in large phylogenetic tree
bigtree <- read.tree("/Users/isaacbailey/Documents/Curtis_Prairie_EA/GC.ultrametric_genera_constrained.tre")

#finding taxa to remove
setdiff(bigtree$tip.label, keep) -> remove_taxa

#tree pruning
pruned.tree <- drop.tip(bigtree, remove_taxa)

#List species in tree
pruned.tree$tip.label

#writing out tree
write.tree(pruned.tree, file = '/Users/isaacbailey/Documents/Curtis_Prairie_EA/curtis.tre')

#plot tree
plot.phylo(pruned.tree)

