symmetry-benchmark
==================

This project was designed to benchmark results of CE-Symm, accompanying
[symmetry](https://github.com/rcsb/symmetry). Please see that project for more
general information.

Users may be interested in this project to:
 - Benchmark alternative data sets using CE-Symm.
 - Reproduce the benchmarks in the CE-Symm paper.
 - Benchmark protein symmetry-detection algorithms other than CE-Symm.


CE-Symm Benchmark (Myers-Turnbull 2014)
=======================================

> Myers-Turnbull, D., Bliven, S. E., Rose, P. W., Aziz, Z. K., Youkharibache,
> P., Bourne, P. E., & Prlić, A. (2014). Systematic Detection of Internal
> Symmetry in Proteins Using CE-Symm. Journal of Molecular Biology, 426(11),
> 2255–2268.

The CE-Symm algorithm was originally benchmarked on a novel manually curated
set of 1007 proteins. These are annoted with various types of structural
repeats, primarily internal symmetry.

The Myers-Turnbull benchmark is contained in file `domain_symm_benchmark.tsv`. The original file can be accessed from the symmetry-benchmark-1.0.0 tag, and can be used to exactly duplicate the results from the paper (together with the [CE-Symm 1.0.0 Release](https://github.com/rcsb/symmetry/releases)). Later releases reflect changes in the PDB (e.g. obsolete entries) or the discovery of mistakes in the manual curation (e.g. overlooked translational repeats).

Each line of the file consists of a SCOPe domain identifier (v. 2.01) and an annotation of the symmetry. Abbreviations used:
 - C1   Asymmetric
 - C[x] Rotational symmetry, order x
 - D[x] Dihedral symmetry, with an x-fold major axis and 2x repeats
 - H[x] Helical symmetry with x repeats per revolution
 - NIH  Non-integer helical repeats
 - SH   Superhelical repeats
 - R    Other translational repeats


Changelog
---------

- 1.0.0   Published benchmark (1007 structures)

Other Benchmarks
================

Guerler folds
-------------

> Guerler, A., Wang, C., & Knapp, E. W. (2009). Symmetric structures in the
> universe of protein folds. Journal of Chemical Information and Modeling,
> 49(9), 2147–2151.

The GANGSTA+ algorithm for detecting internal symmetry was run on ASTRAL40
(SCOP v. 1.73) and identified a number of families with significant internal
symmetry. Both SymD and CE-Symm also used the dataset, making it a useful tool
for comparing algorithms.

Kim et al. provide a list of SCOP domains for each symmetric fold in their
Supplemental Material 3:

> Kim, C., Basner, J., & Lee, B. (2010). Detecting internally symmetric protein
> structures. BMC Bioinformatics, 11, 303.

This data has been reformatted into a more machine-readable format in the
`Guerler_folds/` directory. We were unable to reconcile some differences in
the number of domains with those given in Kim Table 2. The data here can be
used to reproduce the CE-Symm results from Myers-Turnbull Table 1, but they may
not reproduce exactly the previously reported SymD and GANGSTA+ results.

**Format:**

`Guerler_folds/expected_groups.tsv` contains a list of SCOP folds and families,
annotated with the expected type of symmetry.

`Guerler_folds/*.list` contains a list of SCOP domains belonging to the fold
given in the filename.


Fisher benchmark
----------------

> Fischer, D., Elofsson, A., Rice, D., & Eisenberg, D. (1996). Assessing the
> performance of fold recognition methods by means of a comprehensive
> benchmark. Pacific Symposium on Biocomputing Pacific Symposium on
> Biocomputing, 300–318.

The Fischer benchmark consists of 68 pairs of proteins from related folds.
While not directly related to symmetry, the list of proteins is provided here
in machine-readable format for benchmarking structural comparison algorithms.


