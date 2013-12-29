# yslow-data-rest-api

[![Code Climate](https://codeclimate.com/github/robinjmurphy/yslow-data-rest-api.png)](https://codeclimate.com/github/robinjmurphy/yslow-data-rest-api)

A REST API for storing web performance data from [YSlow](http://yslow.org).

It receives test results using YSlow's [beacon mechanism](http://yslow.org/user-guide/#yslow_beacon) and makes them available through a JSON API. Data is persisted to [MongoDB](http://www.mongodb.org/) with the [yslow-data-service](https://github.com/robinjmurphy/yslow-data-service) package.

## Requirements

* [MongoDB](http://www.mongodb.org/)
* [Node.js](http://nodejs.org/) with [NPM](https://npmjs.org)

## Installation

```bash
npm install yslow-data-rest-api
```

## Usage

Start the server:

```bash
yslow-data-rest-api
```

Configure YSlow to send requests to the beacon end-point. Here's an example with [YSlow for PhantomJS](http://yslow.org/phantomjs/):

```bash
phantomjs yslow.js -b http://localhost:3000/beacon -i basic http://www.bbc.co.uk/
```

Head to http://localhost:3000/results to see the test results:

```json
{
  "results": [
    {
      "id": "52b887a7e486520836000003",
      "timestamp": "2013-12-23T18:57:43.216Z",
      "data": {
        "v": "3.1.8",
        "w": 510283,
        "o": 76,
        "u": "http://www.bbc.co.uk/",
        "r": 87,
        "i": "ydefault",
        "lt": 1706
      }
    }
  ]
}
```

### Configuration

To start the server on a different port/host then use the `-p` and `-H` flags:

```
yslow-data-rest-api -p 8080 -H localhost
```

By default the REST API is configured to use a MongoDB database at `mongodb://127.0.0.1:27017/yslow`. To change this, set the environment variable `YSLOW_DATA_DB` e.g.

```bash
EXPORT YSLOW_DATA_DB="mongodb://127.0.0.1:27017/some_db"
```

## API

### `POST /beacon`

Accepts YSlow beacon requests

#### Example request
```bash
curl -i -X POST -H "Content-Type: application/json" -d '{"v": "3.1.8", "w": 510283, "o": 76, "u": "http://www.bbc.co.uk/", "r": 87, "i": "ydefault", "lt": 1706}' http://localhost:3000/beacon
```

#### Example response
```
HTTP/1.1 201 Created
Location: /results/52b88a9ca7b09dcc36000001
```

```json
{
  "results": [
    {
      "id": "52b8c2bc1544b91d5a000001",
      "timestamp": "2013-12-23T23:09:48.626Z",
      "data": {
        "v": "3.1.8",
        "w": 510283,
        "o": 76,
        "u": "http://www.bbc.co.uk/",
        "r": 87,
        "i": "ydefault",
        "lt": 1706
      }
    }
  ]
}
```
---
### `GET /results`

Returns stored results

#### Parameters

* `url` - Filters results by URL
* `limit` - Limits the number of results returned

#### Example request

```bash
curl -i "http://localhost:3000/results?url=http://www.bbc.co.uk/&limit=5"
```

#### Example response

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
```

```json
{
  "results": [
    {
      "id": "52b8c26e6a9782d25900001a",
      "timestamp": "2013-12-23T23:08:30.229Z",
      "data": {
        "v": "3.1.8",
        "w": 538060,
        "o": 76,
        "u": "http://www.bbc.co.uk",
        "r": 88,
        "i": "ydefault",
        "lt": 1883
      }
    }
  ]
}
```
---
### `DELETE /results`

Deletes all results

#### Example request
```bash
curl -i -X DELETE http://localhost:3000/results
```

#### Example response
```
HTTP/1.1 204 No Content
```
---
### `GET /results/:id`

Returns a single result by its ID

#### Example request

```bash
curl -i http://localhost:3000/results/52b88c58a3d2f8fd36000004
```

#### Example response

```json
{
  "results": [
    {
      "id": "52b8c26e6a9782d25900001a",
      "timestamp": "2013-12-23T23:08:30.229Z",
      "data": {
        "v": "3.1.8",
        "w": 538060,
        "o": 76,
        "u": "http://www.bbc.co.uk",
        "r": 88,
        "i": "ydefault",
        "lt": 1883
      }
    }
  ]
}
```
---
### `DELETE /results/:id`

Deletes a single result by its ID

#### Example request

```bash
curl -i -X DELETE http://localhost:3000/results/52b88c58a3d2f8fd36000004
```

#### Example response
```
HTTP/1.1 204 No Content
```
---
### `GET /results/latest`

Returns the latest result

#### Parameters

* `url` - Returns the latest result for the given URL

#### Example request

```bash
curl -i "http://localhost:3000/results/latest?url=http://www.bbc.co.uk"
```

#### Example response

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
```

```json
{
  "results": [
    {
      "id": "52b8c4c2c4dea4fb5c00001b",
      "timestamp": "2013-12-23T23:18:26.710Z",
      "data": {
        "v": "3.1.8",
        "w": 538060,
        "o": 76,
        "u": "http://www.bbc.co.uk",
        "r": 88,
        "i": "ydefault",
        "lt": 1883
      }
    }
  ]
}
```
---
### `GET /urls`

Returns the distinct URLs that have been tested

#### Example request

```bash
curl -i "http://localhost:3000/urls"
```

#### Example response

```
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
```

```json
{
  "urls": [
    "http://www.bbc.co.uk/weather/",
    "http://www.bbc.co.uk/news/"
  ]
}
```
