# CovidAPI

Daily Covid-19 statistics by country, region, and city.

Base URL: https://coviddata.github.io/covid-api/v1

## Countries

### [countries/stats.json](https://coviddata.github.io/covid-api/v1/countries/stats.json)

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
      },
      "2020-01-23": {
        "new": {
          "cases": 92,
          "deaths": 1,
          "recoveries": 2
        },
        "cumulative": {
          "cases": 639,
          "deaths": 18,
          "recoveries": 30
        }
      }
    }
  }
]
```

## Regions

A region is a state, province, or similar geographic area.

### [regions/stats.json](https://coviddata.github.io/covid-api/v1/regions/stats.json)

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
      },
      "2020-02-02": {
        "new": {
          "cases": 4024,
          "deaths": 101,
          "recoveries": 127
        },
        "cumulative": {
          "cases": 11177,
          "deaths": 350,
          "recoveries": 295
        }
      }
    }
  }
]
```

## Places

A place is a city, town, or similar geographic area.

### [places/stats.json](https://coviddata.github.io/covid-api/v1/places/stats.json)

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
