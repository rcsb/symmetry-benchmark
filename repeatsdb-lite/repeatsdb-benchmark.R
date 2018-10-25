# Benchmark results of CE-Symm on RepeatsDB-lite dataset
# Aleix Lafita - October 2018

library(dplyr)

# Load the data
dataset = read.csv("repeatsdb-dataset.tsv", sep = "\t", stringsAsFactors = F)

cesymm = read.csv("cesymm-rdb_allresults.tsv", sep = "\t", stringsAsFactors = F)
names(cesymm) = c("id", "repeats_CESymm", "SymmGroup", "Reason")

rdblite = read.csv("full_rdblite.txt", sep = "", header = F, stringsAsFactors = F) %>%
  mutate(
    pdb = sub("_.*", "", V1),
    chain = sub(".*_", "", V1),
    id = paste(pdb,chain, sep = "."),
    units_rdbl = str_count(V3, ","),
    insertions_rdbl = str_count(V4, ",")
  ) %>%
  # Sometimes RepeatsDB-lite would produce two separate repeat regions
  group_by(id) %>%
  summarize(
    units_rdbl = sum(units_rdbl),
    insertions_rdbl = sum(insertions_rdbl)
  )
  #select(id, repeats_RDBlite)

# Include everything in a single data frame
benmk.cesymm = merge(dataset, cesymm)
benmk.all = merge(benmk.cesymm, rdblite, all.x = T)

benmk = benmk.all %>%
  mutate(
    units_rdbl = ifelse(is.na(units_rdbl), 0, units_rdbl),
    insertions_rdbl = ifelse(is.na(insertions_rdbl), 0, insertions_rdbl),
    class = sub("\\..*", "", class),
    rec_cesymm = ifelse(repeats_CESymm > 1, 1, 0),
    rec_rdblite = ifelse(units_rdbl > 0, 1, 0)
  ) %>%
  filter(
    class == "III" | class == "IV"
  )

# Split the benchmark into solenoids and closed repeats
benmk.solenoids = benmk %>% filter(class == "III")
benmk.closed = benmk %>% filter(class == "IV")

# Calculate benchmark statistics of CE-Symm
cesymm.rec_all = sum(benmk$rec_cesymm) / nrow(benmk)
cesymm.rec_solenoid = sum(benmk.solenoids$rec_cesymm) / nrow(benmk.solenoids)
cesymm.rec_closed = sum(benmk.closed$rec_cesymm) / nrow(benmk.closed)

# Calculate statistics of RepeatsDB-lite for comparison
rdblite.rec_all = sum(benmk$rec_rdblite) / nrow(benmk)
rdblite.rec_solenoid = sum(benmk.solenoids$rec_rdblite) / nrow(benmk.solenoids)
rdblite.rec_closed = sum(benmk.closed$rec_rdblite) / nrow(benmk.closed)

# Write benchmarking summary to file
results = benmk %>% select(id, pdb, chain, class, repeats_CESymm, units_rdbl)
write.table(
  results,
  "repeatsdb-benchmark.tsv",
  sep = "\t",
  quote = F,
  row.names = F
)

# Print a message with the relevant percentages
message(sprintf("CE-Symm overall recall is %i, %i in solenoid (class III) and %i in closed (class IV) repeats",
                round(cesymm.rec_all, 2)*100,
                round(cesymm.rec_solenoid, 2)*100,
                round(cesymm.rec_closed, 2)*100
               ))

