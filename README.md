# MERS-CoV, South Korea, 2015

A Fieldwork worked example, for teaching: the line list and probable contacts of the first weeks of the 2015 MERS-CoV
outbreak in South Korea, as published in the R package `outbreaks`.

| File | What it holds |
| --- | --- |
| `data/mers_korea_2015_linelist.csv` | 162 cases, 15 columns: age, sex, place of infection, hospital, dates of onset, report, exposure, diagnosis and death, outcome |
| `data/mers_korea_2015_contacts.csv` | 98 probable links between cases, with the place of exposure and the days between onsets |
| `fieldwork-project.json.gz` | The Fieldwork project: *How quickly was each case detected and reported?* and *Who infected whom, and where?* |
| `scripts/convert.R` | Reads the package's `.RData` and writes the two CSVs, changing no value |
| `NOTICE.txt`, `provenance.json` | Where the data come from, the terms as found, and what was done |

**Terms.** No licence for the data is stated by the package or by ECDC; the package describes the dataset as meant for
teaching. It is used here on that basis. `LICENSE` (CC0) covers this repository's own files, not the data. See
`NOTICE.txt`.

**Limits.** Dates are per case. Onset to report and onset to diagnosis can be computed for the 135 cases with an onset
date; a 7-1-7 review of the outbreak as one event cannot, because no early response action dates are held.

**The workflow.** *How quickly was each case detected and reported?* reads the line list, applies Fieldwork's
published *7-1-7 timeliness* ruleset (2.0.0) with `dt_onset`, `dt_diag` and `dt_report` as emergence, detection and
notification, and counts each verdict:

| Interval | Met | Not met | No verdict |
| --- | --- | --- | --- |
| Onset to diagnosis, within 7 days | 94 | 41 | 27, no onset date |
| Diagnosis to report, within 1 day | 161 | 1 | 0 |

Seven cases were reported a day before their diagnosis date; their interval is −1 days, as the file holds it. No case
has a response date, so none has a verdict on the third target. *Who infected whom, and where?* reads the 98 probable links and counts the cases each source infected (11 sources;
SK_14 38, SK_1 26, SK_16 21) and where exposure happened (hospital room 44, emergency room 33, hospital visit 12, contact
with a health worker 8, family member 1). It also draws who infected whom as a tree:
the line list related to the contacts with one row per recorded source (Relate keeps one row per match), so SK_39's
three sources and SK_107's two are all drawn, the first placing the case and the others dashed. 162 cases in 67 chains;
the largest starts with SK_1 and holds 94 cases over 4 generations.

Open `fieldwork-project.json.gz` in Fieldwork with **Import**.
