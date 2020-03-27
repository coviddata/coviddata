<h1>
  <img src="https://img.icons8.com/ultraviolet/80/000000/coronavirus.png" width="24" />
  CovidAPI
</h1>

[CSVs](https://coviddata.github.io/covid-api#csvs) |
[API](https://coviddata.github.io/covid-api#api) |
[Visualization](https://www.covidstats.com/) |
[Repo](https://github.com/coviddata/covid-api) |
[About](https://coviddata.github.io/covid-api#about)

CovidAPI provides statistics about COVID-19:

* Daily cases, deaths, and recoveries by country, region, and city
* Cumulative daily counts and incremental daily counts
* [CSV](https://coviddata.github.io/covid-api#csvs) and [JSON](https://coviddata.github.io/covid-api#api) formats
* Frequent [data updates](#data-updates) for both formats (CSV and JSON)

## Table of Contents

* [CSVs](#csvs)
* [API](#api)
* [About](#about)

## CSVs

### Countries

#### [countries/cases.csv](https://coviddata.github.io/covid-api/v1/countries/cases.csv)

Cumulative cases by country and date.

Sample:

```csv
Country,2020-01-22,2020-01-23,2020-01-24,2020-01-25,2020-01-26,2020-01-27,2020-01-28,2020-01-29,2020-01-30,2020-01-31,2020-02-01,2020-02-02,2020-02-03,2020-02-04,2020-02-05,2020-02-06,2020-02-07,2020-02-08,2020-02-09,2020-02-10,2020-02-11,2020-02-12,2020-02-13,2020-02-14,2020-02-15,2020-02-16,2020-02-17,2020-02-18,2020-02-19,2020-02-20,2020-02-21,2020-02-22,2020-02-23,2020-02-24,2020-02-25,2020-02-26,2020-02-27,2020-02-28,2020-02-29,2020-03-01,2020-03-02,2020-03-03,2020-03-04,2020-03-05,2020-03-06,2020-03-07,2020-03-08,2020-03-09,2020-03-10,2020-03-11,2020-03-12,2020-03-13,2020-03-14,2020-03-15,2020-03-16,2020-03-17,2020-03-18,2020-03-19,2020-03-20,2020-03-21,2020-03-22,2020-03-23,2020-03-24,2020-03-25
China,547,639,916,1399,2062,2863,5494,6070,8124,9783,11871,16607,19693,23680,27409,30553,34075,36778,39790,42306,44327,44699,59832,66292,68347,70446,72364,74139,74546,74999,75472,76922,76938,77152,77660,78065,78498,78824,79251,79826,80026,80151,80271,80422,80573,80652,80699,80735,80757,80921,80932,80945,80977,81003,81033,81058,81102,81156,81250,81305,81397,81496,81591,81661
Italy,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,20,62,155,229,322,453,655,888,1128,1694,2036,2502,3089,3858,4636,5883,7375,9172,10149,12462,12462,17660,21157,24747,27980,31506,35713,41035,47021,53578,59138,63927,69176,74386
```

#### [countries/deaths.csv](https://coviddata.github.io/covid-api/v1/countries/deaths.csv)

Cumulative deaths by country and date.

Sample:

```csv
Country,2020-01-22,2020-01-23,2020-01-24,2020-01-25,2020-01-26,2020-01-27,2020-01-28,2020-01-29,2020-01-30,2020-01-31,2020-02-01,2020-02-02,2020-02-03,2020-02-04,2020-02-05,2020-02-06,2020-02-07,2020-02-08,2020-02-09,2020-02-10,2020-02-11,2020-02-12,2020-02-13,2020-02-14,2020-02-15,2020-02-16,2020-02-17,2020-02-18,2020-02-19,2020-02-20,2020-02-21,2020-02-22,2020-02-23,2020-02-24,2020-02-25,2020-02-26,2020-02-27,2020-02-28,2020-02-29,2020-03-01,2020-03-02,2020-03-03,2020-03-04,2020-03-05,2020-03-06,2020-03-07,2020-03-08,2020-03-09,2020-03-10,2020-03-11,2020-03-12,2020-03-13,2020-03-14,2020-03-15,2020-03-16,2020-03-17,2020-03-18,2020-03-19,2020-03-20,2020-03-21,2020-03-22,2020-03-23,2020-03-24,2020-03-25
China,17,18,26,42,56,82,131,133,171,213,259,361,425,490,562,632,717,804,904,1011,1111,1116,1368,1520,1662,1765,1863,2002,2114,2236,2236,2441,2443,2593,2663,2715,2744,2788,2835,2870,2912,2945,2981,3013,3042,3070,3097,3120,3136,3161,3172,3180,3193,3203,3217,3230,3241,3249,3253,3259,3265,3274,3281,3285
Italy,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,7,10,12,17,21,29,34,52,79,107,148,197,233,366,463,631,827,827,1266,1441,1809,2158,2503,2978,3405,4032,4825,5476,6077,6820,7503
```

#### [countries/recoveries.csv](https://coviddata.github.io/covid-api/v1/countries/recoveries.csv)

Cumulative recoveries by country and date.

Sample:

```csv
Country,2020-01-22,2020-01-23,2020-01-24,2020-01-25,2020-01-26,2020-01-27,2020-01-28,2020-01-29,2020-01-30,2020-01-31,2020-02-01,2020-02-02,2020-02-03,2020-02-04,2020-02-05,2020-02-06,2020-02-07,2020-02-08,2020-02-09,2020-02-10,2020-02-11,2020-02-12,2020-02-13,2020-02-14,2020-02-15,2020-02-16,2020-02-17,2020-02-18,2020-02-19,2020-02-20,2020-02-21,2020-02-22,2020-02-23,2020-02-24,2020-02-25,2020-02-26,2020-02-27,2020-02-28,2020-02-29,2020-03-01,2020-03-02,2020-03-03,2020-03-04,2020-03-05,2020-03-06,2020-03-07,2020-03-08,2020-03-09,2020-03-10,2020-03-11,2020-03-12,2020-03-13,2020-03-14,2020-03-15,2020-03-16,2020-03-17,2020-03-18,2020-03-19,2020-03-20,2020-03-21,2020-03-22,2020-03-23,2020-03-24,2020-03-25
China,28,30,36,39,49,58,101,120,135,214,275,463,614,843,1115,1476,1998,2595,3218,3917,4635,5079,6213,7973,9294,10748,12455,14199,15952,18002,18693,22687,23170,24990,27650,30053,32898,36291,39279,42118,44810,47404,49955,52240,53888,55478,57320,58735,60106,61644,62901,64196,65660,67017,67910,68798,69755,70535,71266,71857,72362,72819,73280,73773
Italy,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,1,1,3,45,46,46,83,149,160,276,414,523,589,622,724,724,1045,1045,1439,1966,2335,2749,2941,4025,4440,4440,6072,7024,7432,8326,9362
```

### Regions

#### [regions/cases.csv](https://coviddata.github.io/covid-api/v1/regions/cases.csv)

Cumulative cases by region and date.

Sample:

```csv
Region,Country,2020-02-01,2020-02-02,2020-02-03,2020-02-04,2020-02-05,2020-02-06,2020-02-07,2020-02-08,2020-02-09,2020-02-10,2020-02-11,2020-02-12,2020-02-13,2020-02-14,2020-02-15,2020-02-16,2020-02-17,2020-02-18,2020-02-19,2020-02-20,2020-02-21,2020-02-22,2020-02-23,2020-02-24,2020-02-25,2020-02-26,2020-02-27,2020-02-28,2020-02-29,2020-03-01,2020-03-02,2020-03-03,2020-03-04,2020-03-05,2020-03-06,2020-03-07,2020-03-08,2020-03-09,2020-03-10,2020-03-11,2020-03-12,2020-03-14,2020-03-15,2020-03-16,2020-03-17,2020-03-18,2020-03-19,2020-03-20,2020-03-21,2020-03-22,2020-03-23,2020-03-24,2020-03-25
Hubei,China,7153,11177,13522,16678,19665,22112,24953,27100,29631,31728,33366,33366,48206,54406,56249,58182,59989,61682,62031,62442,62662,64084,64084,64287,64786,65187,65596,65914,66337,66907,67103,67217,67332,67466,67592,67666,67707,67743,67760,67773,67781,67790,67794,67798,67799,67800,67800,67800,67800,67800,67800,67801,67801
New York,United States,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,173,220,328,525,732,967,1706,2495,5365,8310,11710,15800,20884,25681,30841
```

#### [regions/deaths.csv](https://coviddata.github.io/covid-api/v1/regions/deaths.csv)

Cumulative deaths by region and date.

Sample:

```csv
Region,Country,2020-02-01,2020-02-02,2020-02-03,2020-02-04,2020-02-05,2020-02-06,2020-02-07,2020-02-08,2020-02-09,2020-02-10,2020-02-11,2020-02-12,2020-02-13,2020-02-14,2020-02-15,2020-02-16,2020-02-17,2020-02-18,2020-02-19,2020-02-20,2020-02-21,2020-02-22,2020-02-23,2020-02-24,2020-02-25,2020-02-26,2020-02-27,2020-02-28,2020-02-29,2020-03-01,2020-03-02,2020-03-03,2020-03-04,2020-03-05,2020-03-06,2020-03-07,2020-03-08,2020-03-09,2020-03-10,2020-03-11,2020-03-12,2020-03-14,2020-03-15,2020-03-16,2020-03-17,2020-03-18,2020-03-19,2020-03-20,2020-03-21,2020-03-22,2020-03-23,2020-03-24,2020-03-25
Hubei,China,249,350,414,479,549,618,699,780,871,974,1068,1068,1310,1457,1596,1696,1789,1921,2029,2144,2144,2346,2346,2495,2563,2615,2641,2682,2727,2761,2803,2835,2871,2902,2931,2959,2986,3008,3024,3046,3056,3075,3085,3099,3111,3122,3130,3133,3139,3144,3153,3160,3163
New York,United States,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,10,13,16,34,42,60,117,158,210,285
```

#### [regions/recoveries.csv](https://coviddata.github.io/covid-api/v1/regions/recoveries.csv)

Cumulative recoveries by region and date.

Sample:

```csv
Region,Country,2020-02-01,2020-02-02,2020-02-03,2020-02-04,2020-02-05,2020-02-06,2020-02-07,2020-02-08,2020-02-09,2020-02-10,2020-02-11,2020-02-12,2020-02-13,2020-02-14,2020-02-15,2020-02-16,2020-02-17,2020-02-18,2020-02-19,2020-02-20,2020-02-21,2020-02-22,2020-02-23,2020-02-24,2020-02-25,2020-02-26,2020-02-27,2020-02-28,2020-02-29,2020-03-01,2020-03-02,2020-03-03,2020-03-04,2020-03-05,2020-03-06,2020-03-07,2020-03-08,2020-03-09,2020-03-10,2020-03-11,2020-03-12,2020-03-14,2020-03-15,2020-03-16,2020-03-17,2020-03-18,2020-03-19,2020-03-20,2020-03-21,2020-03-22,2020-03-23,2020-03-24,2020-03-25
Hubei,China,168,295,386,522,633,817,1115,1439,1795,2222,2639,2686,3459,4774,5623,6639,7862,9128,10337,11788,11881,15299,15343,16748,18971,20969,23383,26403,28993,31536,33934,36208,38557,40592,42033,43500,45235,46488,47743,49134,50318,52960,54288,55142,56003,56927,57682,58382,58946,59433,59882,60324,60811
New York,United States,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
```

### Places

#### [places/cases.csv](https://coviddata.github.io/covid-api/v1/places/cases.csv)

Cumulative cases by place and date.

Sample:

```csv
Place,Region,Country,2020-03-22,2020-03-23,2020-03-24,2020-03-25
New York City,New York,United States,9654,12305,14904,17856
Westchester,New York,United States,1873,2894,3891,4691
```

#### [places/deaths.csv](https://coviddata.github.io/covid-api/v1/places/deaths.csv)

Cumulative deaths by place and date.

Sample:

```csv
Place,Region,Country,2020-03-22,2020-03-23,2020-03-24,2020-03-25
New York City,New York,United States,63,99,131,199
Westchester,New York,United States,0,0,1,1
```

#### [places/recoveries.csv](https://coviddata.github.io/covid-api/v1/places/recoveries.csv)

Cumulative recoveries by place and date.

Sample:

```csv
Place,Region,Country,2020-03-22,2020-03-23,2020-03-24,2020-03-25
New York City,New York,United States,0,0,0,0
Westchester,New York,United States,0,0,0,0
```

## API

### Countries

#### [countries/stats.json](https://coviddata.github.io/covid-api/v1/countries/stats.json)

New and cumulative cases, deaths, and recoveries by country and date.

Example response:

```json
[
  {
    "country": {
      "key": "china",
      "name": "China"
    },
    "dates": {
      "2020-01-22": {
        "new": {
          "cases": 547,
          "deaths": 17,
          "recoveries": 28
        },
        "cumulative": {
          "cases": 547,
          "deaths": 17,
          "recoveries": 28
        }
      }
    }
  }
]
```

### Regions

#### [regions/stats.json](https://coviddata.github.io/covid-api/v1/regions/stats.json)

New and cumulative cases, deaths, and recoveries by region and date.

Example response:

```json
[
  {
    "region": {
      "key": "hubei-china",
      "name": "Hubei",
      "full_name": "Hubei, China",
      "country": {
        "key": "china",
        "name": "China"
      }
    },
    "dates": {
      "2020-02-01": {
        "new": {
          "cases": 7153,
          "deaths": 249,
          "recoveries": 168
        },
        "cumulative": {
          "cases": 7153,
          "deaths": 249,
          "recoveries": 168
        }
      }
    }
  }
]
```

### Places

#### [places/stats.json](https://coviddata.github.io/covid-api/v1/places/stats.json)

New and cumulative cases, deaths, and recoveries by place and date.

Example response:

```json
[
  {
    "place": {
      "key": "new-york-city-new-york-united-states",
      "name": "New York City",
      "full_name": "New York City, New York, United States",
      "country": {
        "key": "united-states",
        "name": "United States"
      },
      "region": {
        "key": "new-york-united-states",
        "name": "New York",
        "full_name": "New York, United States",
        "country": {
          "key": "united-states",
          "name": "United States"
        }
      }
    },
    "dates": {
      "2020-03-22": {
        "new": {
          "cases": 9654,
          "deaths": 63,
          "recoveries": 0
        },
        "cumulative": {
          "cases": 9654,
          "deaths": 63,
          "recoveries": 0
        }
      }
    }
  }
]
```

## About

### Purpose

This project's purpose is to provide frequently-updated COVID-19 datasets with stable formats.

### Methodology

This project reads data from the [Johns Hopkins CSSE data repository](https://github.com/CSSEGISandData/COVID-19), performs normalization and aggregations on top of it, and exposes the results as CSVs and JSON.

Here's a summary of its logic:

1. Read data from the [csse_covid_19_data/csse_covid_19_daily_reports](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports) directory within [github.com/CSSEGISandData/COVID-19/](https://github.com/CSSEGISandData/COVID-19)
1. Normalize location names (e.g., "Iran (Islamic Republic of)" => "Iran")
1. Generate cumulative counts per country and per region by grouping by the normalized location names and summing the data
1. Generate derived data (e.g., incremental daily counts) based on the cumulative data
1. Write the resulting data to CSVs and JSON files

All of this logic can be viewed within the project's [repo](https://github.com/coviddata/covid-api). The logic is in the [src directory](https://github.com/coviddata/covid-api/tree/master/src), and the update scheduling is in the [.github/workflows](https://github.com/coviddata/covid-api/tree/master/.github/workflows) directory.

### Definitions

* **Region** - A state, province, or similar area
* **Place** - A city, town, county, or similar area

### Data Updates

The data is updated using the [Johns Hopkins CSSE data repository](https://github.com/CSSEGISandData/COVID-19) multiple times per day. The data update frequency is the same for both the CSVs and JSON. The update schedule can be found in [cron format](https://crontab.cronhub.io/) in [update_data.yml](https://github.com/coviddata/covid-api/blob/master/.github/workflows/update_data.yml).
