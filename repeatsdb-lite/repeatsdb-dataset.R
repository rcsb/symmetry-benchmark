# Generate a benchmark dataset of structural repeats from RepeatsDB-lite
# Aleix Lafita - October 2018

library(dplyr)

# Load the repeatsDB-lite datasets
rdb = read.csv("full_reference_headers.txt", sep = "", header = F) %>%
  mutate(
    pdb = sub(">", "", sub("_.*", "", V1)),
    chain = sub("\\..*", "", sub(".*_", "", V1)),
    id = paste(pdb,chain, sep = "."),
    units = str_count(V3, ","),
    insertions = str_count(V4, ","),
    class = V2
  )

# Unique repeat region per protein chain
rdb.uniq = rdb %>%
  group_by(id) %>%
  summarise(rdb_regions = length(units)) %>%
  filter(rdb_regions == 1) %>%
  select(id)

dataset.rdb = merge(rdb, rdb.uniq) %>%
  select(
    id,
    pdb,
    chain,
    class
  )

# Load the latest ECOD domain definitions
ecod = read.csv("ecod.latest.domains.txt",
                sep = "\t",
                header = T,
                skip = 4)

# Unique ECOD domain per protein chain
ecod.uniq = ecod %>%
  mutate(id = paste(pdb, chain, sep = ".")) %>%
  group_by(id) %>%
  summarise(ecod_domains = length(ecod_domain_id)) %>%
  filter(ecod_domains == 1) %>%
  select(id)

dataset = merge(dataset.rdb, ecod.uniq)

# Write the final dataset to a file
write.table(
  dataset,
  "repeatsdb-dataset.tsv",
  sep = "\t",
  quote = F,
  row.names = F
)

