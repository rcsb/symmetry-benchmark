# Benchmark results of CE-Symm on RepeatsDB-lite dataset
# Aleix Lafita - October 2018

library(dplyr)

# Load the data
dataset = read.csv("repeatsdb-dataset.tsv", sep = "\t", stringsAsFactors = F)

cesymm = read.csv("cesymm-rdb_allresults.tsv", sep = "\t", stringsAsFactors = F)
names(cesymm) = c("id", "repeats_CESymm", "SymmGroup", "Reason")

cesymm = cesymm %>%
  mutate(
    id = sub("\\.", "", id)
  )

# Include everything in a single data frame
benmk = merge(dataset, cesymm) %>%
  mutate(
    class_top = sub("\\..*", "", class),
    rec_cesymm = ifelse(repeats_CESymm > 1, 1, 0)
  ) %>%
  filter(
    class_top == "III" | class_top == "IV"
  )

# Split the benchmark into solenoids and closed repeats
benmk.single = benmk %>% filter(rdb_regions == 1, ecod_domains == 1)
benmk.solenoids = benmk.single %>% filter(class_top == "III")
benmk.closed = benmk.single %>% filter(class_top == "IV")

# Calculate benchmark statistics of CE-Symm
cesymm.rec_all = sum(benmk$rec_cesymm) / nrow(benmk)
cesymm.rec_single = sum(benmk.single$rec_cesymm) / nrow(benmk.single)
cesymm.rec_solenoid = sum(benmk.solenoids$rec_cesymm) / nrow(benmk.solenoids)
cesymm.rec_closed = sum(benmk.closed$rec_cesymm) / nrow(benmk.closed)

# Write benchmarking summary to file
results = benmk %>% select(id, pdb, chain, class, rdb_regions, ecod_domains, repeats_CESymm, SymmGroup)
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

