# CE-Symm benchmark on RepeatsDB-lite dataset

This directory contains the data and steps used to benchmark the CE-Symm performance on the dataset of protein repeats in the [RepeatsDB-lite publication](https://doi.org/10.1093/nar/gky360)

## Benchmarking steps

1. Download dataset files from RepeatsDB-lite
http://protein.bio.unipd.it/repeatsdb-lite/dataset

2. Download additional repeat annotations from RepeatsDB using https://github.com/sbliven/repeatsdb

3. Download the latest ECOD domain annotations: [ecod.latest.domains.txt](http://prodata.swmed.edu/ecod/distributions/ecod.latest.domains.txt)
http://prodata.swmed.edu/ecod/complete/distribution

4. Extract reference dataset from RepeatsDB-lite
```bash
grep ">" full_reference.txt > full_reference_header.txt
```

5. Add ECOD and RepeatsDB annotations to the dataset of RepeatsDB-lite to one-domain.
```R
Rscript repeatsdb-dataset.R
```

6. Merge the results from CE-Symm and RepeatsDB-lite and calculate performance metrics.
```R
Rscript repeatsdb-benchmark.R
```

## Results

The final dataset with ECOD and RepeatsDB annotations used for benchmarking can be found in [repeatsdb-dataset.tsv](repeatsdb-dataset.tsv) and the results of CE-Symm can be found in [repeatsdb-benchmark.tsv](repeatsdb-benchmark.tsv).

CE-Symm repeat detection recall:
- Overall: 69%
- Single domain and single repeat region: 77%
- Single solenoids (type III): 64%
- Single closed (type IV): 89%

