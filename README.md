# MERS-CoV, South Korea, 2015

A Fieldwork worked example, for teaching: the line list and probable contacts of the first weeks of the 2015 MERS-CoV
outbreak in South Korea, as published in the R package `outbreaks`.

| File | What it holds |
| --- | --- |
| `data/mers_korea_2015_linelist.csv` | 162 cases, 15 columns: age, sex, place of infection, hospital, dates of onset, report, exposure, diagnosis and death, outcome |
| `data/mers_korea_2015_contacts.csv` | 98 probable links between cases, with the place of exposure and the days between onsets |
| `data/mers_korea_2015_facilities.csv` | Each hospital named in the line list's `loc_hosp`, as written, with the facility it is, its coordinates, their source and how sure the identification is. ODbL 1.0 |
| `data/kdca_mers_2015_cases.csv` | All 185 cases KDCA confirmed in Korea: order, province of the reporting hospital, sex, age, week of report. Korea Disease Control and Prevention Agency, data.go.kr 15155636, no restriction on use. Its values as KDCA writes them, in Korean; only the encoding changed, from CP949 to UTF-8 |
| `source/kdca_mers_2015_cases_cp949.csv` | The KDCA file as downloaded, CP949 |
| `data/kdca_mers_2015_dictionary.csv` | Each KDCA column with a short English label, described in English, with data.go.kr's own Korean field description beside it and the codes of province and sex |
| `data/mers_event_milestones.csv` | The outbreak as one event: emergence, detection and notification dates, and three candidate dates for early response complete, each with the action and its source |
| `fieldwork-project.json.gz` | The Fieldwork project: *How quickly was each case detected and reported?*, *Who infected whom, and where?*, *Where were the cases in hospital?*, *Who were the 185 cases KDCA confirmed?*, *Did the outbreak’s response meet 7-1-7?* and six more, through *Did it come in waves?* |
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

*Who were the 185 cases KDCA confirmed?* reads KDCA's file of every case confirmed in Korea, 185 against the package's
162, with KDCA's field descriptions as the data dictionary, and counts the cases by week of report (an epidemic curve),
by the province of the reporting hospital and by sex. The province is the hospital's, not where the case lived; the week
is of the hospital's report. The file has no dates finer than a week, so it cannot be timed against 7-1-7 case by case.

*Did the outbreak’s response meet 7-1-7?* treats the outbreak as one event, with the same 7-1-7 ruleset: emergence on
11 May 2015, the onset of the first case (SK_1); detection on 20 May, its laboratory confirmation; notification on
20 May, the day Korea notified WHO. **Early response complete is not one recorded date**, so three candidates are each a
row: contacts quarantined and the first hospital closed (29 May), the 24 affected hospitals named (7 June), and a Rapid
Response Team set up (8 June). Detection took 9 days, against 7: not met. Notification was the same day: met. The early
response was 9, 18 or 19 days after detection, not met whichever action counts. The dates are from published
literature and WHO, cited in the table; which action completes the early response is a judgement this example does not
make.

*How deadly was it, and for whom?* counts the line list's 162 cases by age class and outcome, with each age class's
deaths and survivals as shares of it (70-79: 7 of 25 died, 28%), and by sex and outcome into a two-by-two: 14 of 99 men
died and 5 of 63 women, 14.1% against 7.9%, a ratio of 1.78 (95% interval 0.67 to 4.71). The interval holds 1, and no
study design is connected, so the ratio is named by its arithmetic and claims nothing about sex as a cause.

*How long from exposure to onset, and from onset to death?* computes two columns for every case with rules written on
the step: the days from the last day of exposure to onset, and from onset to death. The median from exposure to onset is
6 days for the 118 survivors with both dates and 7 for the 15 who died. Some cases have onset before their last day
of exposure (as low as −8 days): the exposure window ran past onset, so the figure is not an incubation period for them,
and they are counted as written. Onset to death has both dates for 7 of the 19 deaths.

*Who spread it, and how fast?* reads the 98 probable links: the secondary cases per source with each source's share of
all links, and the median days between a source's onset and its case's, by setting (family member 7, contact with a
health worker 14, hospital room 12, hospital visit 12, emergency room 18). The days are the package's `diff_dt_onset`;
a link with an undocumented basis gives an interval no firmer than the link.

*How many did each case infect?* counts each source's probable links, relates the counts onto all 162 cases (a case no
link names as a source is declared 0, with that reason), and counts the cases by how many they infected, as a table and
as bars: 151 infected no recorded case, 5 one, 2 two, 1 four, and three infected 21, 26 and 38. Most cases infected
nobody and three caused most of the outbreak: superspreading. The links are probable, as the package says, so these are
recorded links, not every infection.

*Did it come in waves?* follows each case's recorded source back to the case its chain starts with (Fieldwork's
Transmission chains). The 162 cases make 67 chains: one of 94 cases starting with SK_1, over 4 generations; one of 3
starting with SK_76; and 65 cases with no recorded source, each a chain of one. The epidemic curve by generation counts
each dated case once (135; 27 have no onset date): 40 in generation 0, 28 in the first, 65 in the second, 2 in the
third. The second generation is the large wave, the cases infected by the first generation's superspreaders. A table
lists the chains by size. A chain is the record's: a recorded link is not a proven infection.

*Where were the cases in hospital?* now has an inset on its static map: Pyeongtaek enlarged, where four of the ten
placed hospitals are within about 10 km of each other and their marks overlap at the scale of the country.

**Sources, in the write-up.** Each source step records what it is, who published it, where it was read, its licence and
its citation, so the project's Notes say where every table came from and References lists them.

**What the package's line list does not say.** It was compiled by ECDC's Epidemic Intelligence from public reports in the
outbreak's first weeks, so it stops at 162 cases. The meaning of `dt_report` against `dt_diag` is not documented, and
7 cases are reported a day before their diagnosis, SK_1 among them; they are counted as written. How the probable links
were assigned is not documented either.

Open `fieldwork-project.json.gz` in Fieldwork with **Import**. Needs Fieldwork 0.116.0 or later for every step's Methods note and the sources in References; 0.114.0 or later for
the medians.
