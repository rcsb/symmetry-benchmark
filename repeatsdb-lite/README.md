# CE-Symm benchmark on RepeatsDB-lite dataset

This directory contains the data and steps used to benchmark the CE-Symm performance on the dataset of protein repeats in the [RepeatsDB-lite publication](https://doi.org/10.1093/nar/gky360)

## Benchmarking steps

1. Download dataset files from RepeatsDB-lite
http://protein.bio.unipd.it/repeatsdb-lite/dataset

2. Download the latest ECOD domain annotations: [ecod.latest.domains.txt](http://prodata.swmed.edu/ecod/distributions/ecod.latest.domains.txt)
http://prodata.swmed.edu/ecod/complete/distribution

3. Extract reference datasets
grep ">" full_reference.txt > full_reference_header.txt
grep ">" comparison_reference.txt > comparison_reference_header.txt

4. Filter the dataset of RepeatsDB-lite to one-domain, one-repeating region only proteins
Rscript repeatsdb-dataset.R

5. Merge the results from CE-Symm and RepeatsDB-lite
Rscript repeatsdb-benchmark.R

## Results

The final dataset used for benchmarking can be found in [repeatsdb-dataset.tsv](repeatsdb-dataset.tsv) and the results can be found in [repeatsdb-benchmark.tsv](repeatsdb-benchmark.tsv).

CE-Symm repeat detection recall:
- Solenoids (type III): 64%
- Closed (type IV): 89%
- Global: 77%

