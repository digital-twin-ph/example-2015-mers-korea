# MERS-CoV, South Korea, 2015

A Fieldwork worked example, for teaching: the line list and probable contacts of the first weeks of the 2015 MERS-CoV
outbreak in South Korea, as published in the R package `outbreaks`.

| File | What it holds |
| --- | --- |
| `data/mers_korea_2015_linelist.csv` | 162 cases, 15 columns: age, sex, place of infection, hospital, dates of onset, report, exposure, diagnosis and death, outcome |
| `data/mers_korea_2015_contacts.csv` | 98 probable links between cases, with the place of exposure and the days between onsets |
| `data/mers_korea_2015_facilities.csv` | Each hospital named in the line list's `loc_hosp`, as written, with the facility it is, its coordinates, their source and how sure the identification is. ODbL 1.0 |
| `fieldwork-project.json.gz` | The Fieldwork project: *How quickly was each case detected and reported?*, *Who infected whom, and where?* and *Where were the cases in hospital?* |
| `scripts/convert.R` | Reads the package's `.RData` and writes the two CSVs, changing no value |
| `NOTICE.txt`, `provenance.json` | Where the data come from, the terms as found, and what was done |

**Terms.** No licence for the data is stated by the package or by ECDC; the package describes the dataset as meant for
teaching. It is used here on that basis. `LICENSE` (CC0) covers this repository's own files, not the data. See
`NOTICE.txt`.

**Where the hospitals are.** `data/mers_korea_2015_facilities.csv` has one row for each of the 13 ways the line list
writes a hospital, so it joins on `loc_hosp` as written. Eleven are placed at the facility, from OpenStreetMap or Wikidata;
Asan Seoul Clinic only at the middle of its street, as the clinic is not mapped; 365 Seoul Yeollin Clinic not at all.
Each is checked against the hospitals the Korean government named on 7 June 2015. "Hallym University Medical Center"
names a network of hospitals: Dongtan is the most likely and is marked low confidence. The package defines `loc_hosp`
as the hospital where a case was hospitalized, and its counts follow where cases were exposed; a map of it shows the
hospitals named for cases, not where each was infected. The file carries OpenStreetMap data, so it is under the Open
Database License 1.0: © OpenStreetMap contributors.

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

*Where were the cases in hospital?* counts the cases by `loc_hosp` as the line list writes it, relates each count to the
hospitals table on that name, places the hospitals, and maps them over South Korea's 17 provinces, every mark one size and
coloured by its cases in five classes from light to dark, so a hospital near Samsung Medical Center is not hidden under
its mark. Samsung Medical Center's two spellings stay two rows at one place, 80 and 5, as written. 12 hospitals are drawn; 365 Seoul Yeollin Clinic has no position and is listed, not drawn. The map shows the
hospitals named for cases, which the package defines as where each was hospitalized; it is not where each was infected.
The provinces are geoBoundaries' gbOpen ADM1 for South Korea (release 9469f09, from Natural Earth, 2021, Public Domain),
carried inside the project. Needs Fieldwork 0.110.0 or later: earlier versions draw the hospitals in one colour, and before 0.106.0 refuse the
provinces as one inside another.

Open `fieldwork-project.json.gz` in Fieldwork with **Import**.
