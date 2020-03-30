<h1>
  <img src="https://img.icons8.com/ultraviolet/80/000000/coronavirus.png" width="24" />
  CovidData
</h1>

[About](https://coviddata.github.io/coviddata#about) |
[CSVs](https://coviddata.github.io/coviddata#csvs) |
[API](https://coviddata.github.io/coviddata#api) |
[Visualization](https://www.covidstats.com/) |
[Repo](https://github.com/coviddata/coviddata)

CovidData provides statistics about COVID-19:

* Daily cases, deaths, and recoveries by country, region, and city
* Cumulative daily counts and incremental daily counts
* [CSV](https://coviddata.github.io/coviddata#csvs) and [JSON](https://coviddata.github.io/coviddata#api) formats
* Frequent [data updates](#data-updates) for both formats (CSV and JSON)

## Table of Contents

* [About](#about)
* [CSVs](#csvs)
* [API](#api)

## About

### Methodology

This project's purpose is to provide frequently-updated COVID-19 datasets with global data in stable, easily-consumed formats.

The project reads data from multiple [data sources](#data-sources), performs normalization and aggregations on top of it, and exposes the results as CSVs and JSON.

Here's a summary of its logic:

1. Read data from the [data sources](#data-sources)
1. Normalize location names (e.g., "Iran (Islamic Republic of)" => "Iran")
1. Generate cumulative counts per country and per region by grouping by the normalized location names and summing the data
1. Generate derived data (e.g., incremental daily counts) based on the cumulative data
1. Write the resulting data to CSVs and JSON files

All of this logic can be viewed within the project's [repo](https://github.com/coviddata/coviddata). The logic is in the [src directory](https://github.com/coviddata/coviddata/tree/master/src), and the update scheduling is in the [.github/workflows](https://github.com/coviddata/coviddata/tree/master/.github/workflows) directory.

### Definitions

* **Region** - A state, province, or similar area
* **Place** - A city, town, county, or similar area

### Data Sources

* [JHU CSSE](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports) - Global data
* [New York Times](https://github.com/nytimes/covid-19-data) - U.S. data

### Data Updates

The data is updated from the [data sources](#data-sources) multiple times per day. The data update frequency is the same for both the CSVs and JSON. The update schedule can be found in [cron format](https://crontab.cronhub.io/) in [update_data.yml](https://github.com/coviddata/coviddata/blob/master/.github/workflows/update_data.yml).

## CSVs

| Data | Description | Sample |
| :--- | :--- | :--- |
| [countries/cases.csv](https://coviddata.github.io/coviddata/v1/countries/cases.csv) | Cumulative cases by country and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/countries/cases.csv) |
| [countries/deaths.csv](https://coviddata.github.io/coviddata/v1/countries/deaths.csv) | Cumulative deaths by country and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/countries/deaths.csv) |
| [countries/recoveries.csv](https://coviddata.github.io/coviddata/v1/countries/recoveries.csv) | Cumulative recoveries by country and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/countries/recoveries.csv) |
| [regions/cases.csv](https://coviddata.github.io/coviddata/v1/regions/cases.csv) | Cumulative cases by region and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/regions/cases.csv) |
| [regions/deaths.csv](https://coviddata.github.io/coviddata/v1/regions/deaths.csv) | Cumulative deaths by region and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/regions/deaths.csv) |
| [regions/recoveries.csv](https://coviddata.github.io/coviddata/v1/regions/recoveries.csv) | Cumulative recoveries by region and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/regions/recoveries.csv) |
| [places/cases.csv](https://coviddata.github.io/coviddata/v1/places/cases.csv) | Cumulative cases by place and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/places/cases.csv) |
| [places/deaths.csv](https://coviddata.github.io/coviddata/v1/places/deaths.csv) | Cumulative deaths by place and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/places/deaths.csv) |
| [places/recoveries.csv](https://coviddata.github.io/coviddata/v1/places/recoveries.csv) | Cumulative recoveries by place and date. | [Sample](https://github.com/coviddata/coviddata/blob/master/data/samples/v1/places/recoveries.csv) |

## API

The API provides statistics about cases, deaths, and recoveries by country, region, and place.

### Usage

For example, to print the number of cases per day in China using JavaScript on a website:

```javascript
fetch("https://coviddata.github.io/coviddata/v1/countries/stats.json")
  .then(response => response.json())
  .then(data => {
    const country = data.find(country => country.country.name == "China");
    for (date in country.dates) {
      console.log(`${date} - ${country.dates[date].cumulative.cases} cases`);
    }
  })
```

### Countries

#### [countries/stats.json](https://coviddata.github.io/coviddata/v1/countries/stats.json)

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
      "2020-01-25": {
        "new": {
          "cases": 483,
          "deaths": 16,
          "recoveries": 3
        },
        "cumulative": {
          "cases": 1399,
          "deaths": 42,
          "recoveries": 39
        }
      },
      "2020-01-26": {
        "new": {
          "cases": 663,
          "deaths": 14,
          "recoveries": 10
        },
        "cumulative": {
          "cases": 2062,
          "deaths": 56,
          "recoveries": 49
        }
      }
    }
  }
]
```

### Regions

#### [regions/stats.json](https://coviddata.github.io/coviddata/v1/regions/stats.json)

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
      "2020-01-25": {
        "new": {
          "cases": 212,
          "deaths": 16,
          "recoveries": 1
        },
        "cumulative": {
          "cases": 761,
          "deaths": 40,
          "recoveries": 32
        }
      },
      "2020-01-26": {
        "new": {
          "cases": 297,
          "deaths": 12,
          "recoveries": 10
        },
        "cumulative": {
          "cases": 1058,
          "deaths": 52,
          "recoveries": 42
        }
      }
    }
  }
]
```

### Places

#### [places/stats.json](https://coviddata.github.io/coviddata/v1/places/stats.json)

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
      "2020-03-23": {
        "new": {
          "cases": 2651,
          "deaths": 36,
          "recoveries": 0
        },
        "cumulative": {
          "cases": 12305,
          "deaths": 99,
          "recoveries": 0
        }
      },
      "2020-03-24": {
        "new": {
          "cases": 2599,
          "deaths": 32,
          "recoveries": 0
        },
        "cumulative": {
          "cases": 14904,
          "deaths": 131,
          "recoveries": 0
        }
      }
    }
  }
]
```
