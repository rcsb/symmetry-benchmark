# Benchmarking protein symmetry

This project was designed to benchmark results of `CE-Symm`. 
Please see this project (https://github.com/rcsb/symmetry) for more information about the `CE-Symm` tool.

Users may be interested in this project to:
 - Benchmark alternative data sets using `CE-Symm`.
 - Reproduce the benchmarks in the `CE-Symm` paper.
 - Benchmark protein symmetry-detection algorithms other than `CE-Symm`.


## Internal symmetry dataset


Version 1.0:

> Myers-Turnbull, D., Bliven, S. E., Rose, P. W., Aziz, Z. K., Youkharibache,
> P., Bourne, P. E., & Prlić, A. (2014). Systematic Detection of Internal
> Symmetry in Proteins Using CE-Symm. Journal of Molecular Biology, 426(11),
> 2255–2268.

Version 2.0:

> Bliven, S.E., Lafita, A., Rose, P.W., Capitani, G., Prlic, A., Bourne, P.E.
> (2018) Analyzing the symmetrical arrangement of structural repeats in
> proteins with CE-Symm. Submitted. Biorxiv preprint:
> https://doi.org/10.1101/297960

The CE-Symm algorithm was originally benchmarked on a novel manually curated
set of 1007 proteins. These are annoted with various types of structural
repeats, primarily internal symmetry.

All files are contained within directory `domain_symm_benchmark`.

The Myers-Turnbull benchmark is contained in file `domain_symm_benchmark.tsv`. The original file can be accessed from the symmetry-benchmark-1.0.0 tag, and can be used to exactly duplicate the results from the paper (together with the [CE-Symm 1.0.0 Release](https://github.com/rcsb/symmetry/releases)). Later releases reflect changes in the PDB (e.g. obsolete entries) or the discovery of mistakes in the manual curation (e.g. overlooked translational repeats). The structures of all domains in PDB format are found in `domain_symm_benchmark.tgz`.

Each line of the file consists of a SCOPe domain identifier (v. 2.01) and an annotation of the symmetry. Abbreviations used:
 - **C1**   Asymmetric
 - **C[x]** Rotational symmetry, order x. The repeats should be arranged in a closed ring, with a reasonably consistent orientation between repeats. Specification of the superposition requires one axis, with a 2pi/x rotation.
 - **D[x]** Dihedral symmetry, with an x-fold major axis and 2x repeats. An additional x two-fold rotation axes are arranged perpendicular to the major axis. Two axes are required to specify the superposition.
 - **H[x]** Helical symmetry with x repeats per revolution. Helices with integer x arise commonly in crystalline environments. The superposition requires an axis for the 2pi/x rotation and a translation distance along this axis.
 - **NIH**  Non-integer helical repeats. These give cases with a non-integer number of subunits per rotation. Superposition can involve an arbitrary transformation between subunits.
 - **SH**   Superhelical repeats. Used for cases where multiple levels of helices are detectable. This is analogous to supercoiling in leucine zippers or DNA, but with a fundamental repeat of secondary structure elements rather than individual residues. The full superposition cannot be simply represented, as the orientation between adjacent repeats depends on their position in the higher-level helices. However, for some applications it may be sufficient to specify the axis of the top-level helix.
 - **R[x]** Translational repeats without higher structure or symmetry, x repeats. 

### Classification guidelines

Many of the cases in the benchmark are difficult to classify or fall near the border of two categories. The following guidelines were used for difficult cases:

 - Within repeats, the order of aligned elements should be the same. Don't consider cases where a strand or helix would superimpose well but with opposite direction (as sometimes occurs near the axis of symmetry between repeats).
 - Clear cases of domain swapping are allowed, and both swapped and unswapped structures should be considered for classification.
 - Ideally, the orientation between repeats should be consistent among all repeats. However, if repeats are still identifiable then count them even in the presence of large distortions. Controversial cases are tagged #distortion in the issues.
 - The majority of the domain should be convered by repeats. The exact size and complexity of insertions should be evaluated on a case-by-case basis. Controversial cases with poor coverage are tagged #partial in the issues.
 - Alpha helical bundles are particularly tricky, since they tend to superimpose well despite kinks and inconsistencies. Most bundles were marked as symmetric if they could be aligned with consistent topology.

### Changelog

- 2.0.0   Updated annotations (same 1007 structures), used in Bliven 2018.
- 1.0.0   Published benchmark (1007 structures), used in Myers-Turnbull 2014.


## RepeatsDB-lite benchmark

See [repeatsdb-lite](repeatsdb-lite) directory for more information.


## Guerler folds

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


## Fisher benchmark

> Fischer, D., Elofsson, A., Rice, D., & Eisenberg, D. (1996). Assessing the
> performance of fold recognition methods by means of a comprehensive
> benchmark. Pacific Symposium on Biocomputing Pacific Symposium on
> Biocomputing, 300–318.

The Fischer benchmark consists of 68 pairs of proteins from related folds.
While not directly related to symmetry, the list of proteins is provided here
in machine-readable format for benchmarking structural comparison algorithms.

## Designed Helical Repeats

> Brunette, T. J., Parmeggiani, F., Huang, P.-S., Bhabha, G., Ekiert, D. C.,
> Tsutakawa, S. E., Hura, G. L., Tainer, J. A., and Baker, D (2015).
> Exploring the repeat protein universe through computational protein design.
> Nature, 528(7583), 580–584.

A set of 15 designed solenoid proteins with varying curvature and twist.
