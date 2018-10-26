# Generate a benchmark dataset of structural repeats from RepeatsDB-lite
# Aleix Lafita - October 2018

library(dplyr)
library(stringr)

# Load the repeatsDB-lite dataset
rdb.lite = read.csv(
  "full_reference_headers.txt", 
  sep = "", 
  header = F,
  stringsAsFactors = F) %>%
  mutate(
    pdb = sub(">", "", sub("_.*", "", V1)),
    chain = sub("\\..*", "", sub(".*_", "", V1)),
    id = paste(pdb,chain, sep = ""),
    units = str_count(V3, ","),
    insertions = str_count(V4, ","),
    class = V2
  )

# Count repeat regions per protein chain
rdb.lite.regions = rdb.lite %>%
  group_by(id) %>%
  summarise(
    rdb_regions = length(units),
    class = min(class),
    pdb = min(pdb),
    chain = min(chain)
  )

# Load the repeatsDB information
rdb.info = read.csv("repeatsdb-info.tsv", sep = "\t", header = T)

# Information per repeat region
rdb.regions = rdb.info %>%
  group_by(id) %>%
  summarise(
    rdb.regions = length(units),
    units_number = sum(units_number),
    reg_seqres_coverage = sum(reg_seqres_coverage)
  )

dataset.rdb = merge(rdb.lite.regions, rdb.regions)

# Load the latest ECOD domain definitions
ecod = read.csv("ecod.latest.domains.txt",
                sep = "\t",
                header = T,
                skip = 4)

# Unique ECOD domain per protein chain
ecod.domains = ecod %>%
  mutate(id = paste(pdb, chain, sep = "")) %>%
  group_by(id) %>%
  summarise(ecod_domains = length(ecod_domain_id))

dataset = merge(dataset.rdb, ecod.domains) %>%
  select(id, pdb, chain, class, rdb_regions, ecod_domains)

# Write the final dataset to a file
write.table(
  dataset,
  "repeatsdb-dataset.tsv",
  sep = "\t",
  quote = F,
  row.names = F
)

