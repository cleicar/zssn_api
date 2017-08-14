# ZSSN (Zombie Survival Social Network)

ZSSN Is a system created to help the human to survive an apocalypse zombie. Using only REST API requests, survivors can share resources with others non-infected humans.

Project created as part of [Codeminer 42](http://www.codeminer42.com/) recruit process.

## Table of Contents

* [Installation](#installation)
* [API Documentation](#api-documentation)
  * [List Survivors](#list-survivors)
  * [Add Survivors](#add-survivors)
  * [Update Survivor Location](#update-survivor-location)
  * [Flag Survivor as Infected](#flag-survivor-as-infected)
  * [Trade Resources](#trade-resources)
* [Reports](#reports)
  * [Percentage of infected survivors](#percentage-of-infected-survivors)
* [Testing with RSpec](#testing-with-rspec)
* [Credits](#credits)

## Installation

**Dependention note**: Before installation make sure to have MongoDB (3.4) and Ruby (2.3) installed and up. 

1. Clone the project.

	~~~ sh
	$ https://github.com/cleicar/zssn_api.git
	~~~

2. Bundle the Gems.

	~~~ sh
	$ bundle install
	~~~

3. Set the database connection at the config file `config/mongoid.yml`.

4. Start the application

	~~~ sh
	$ rails s
	~~~

Application will be runing at [localhost:3000](http://localhost:3000).

## API Documentation

### List Survivors

##### Request 

```sh
GET  /survivors`
```

##### Response

```sh
status: 200 Ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
[
    {
        "_id": {
            "$oid": "598c6da62a43161f3eb5bb66"
        },
        "age": "25",
        "gender": "male",
        "last_location": {
            "latitude": "-16.680353",
            "longitude": "-49.256302"
        },
        "name": "Survivor",
        "resources": [
            {
                "_id": {
                    "$oid": "598c6da62a43161f3eb5bb67"
                },
                "points": null,
                "quantity": 10,
                "type": "Water"
            },
            {
                "_id": {
                    "$oid": "598c6da62a43161f3eb5bb68"
                },
                "points": null,
                "quantity": 6,
                "type": "Food"
            }
        ]
    }
]
```

### Add Survivors

##### Request 

```sh
POST  /survivors`
```

```sh
Parameters:
{
    "survivor": 
    {
        "name": "Survivor Test", 
        "age": "43", 
        "gender": "M", 
        "last_location": {"latitude": "89809809809", "longitude": "-88983982100"},
        "resources": [
        {
            "type": "Water", 
            "quantity": 10
            
        }, 
        { 
            "type":"Food", 
            "quantity": 6
            
        }]
    }
}
```

##### Response

```sh
status: 201 created
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "_id": {
        "$oid": "5990f7357b6ee2652e9e581a"
    },
    "age": "43",
    "gender": "M",
    "infection_count": 0,
    "last_location": {
        "latitude": "89809809809",
        "longitude": "-88983982100"
    },
    "name": "Survivor Test"
}
```

##### Errors
Status | Error                | Message
------ | ---------------------|--------
422    | Unprocessable Entity |   
409    | Conflict             | survivor need to declare its own resources

### Update Survivor Location

##### Request 

```sh
PATCH/PUT /survivors/:id
```

```sh
Parameters:
{
    "survivor": 
    {
        "latitude": "-16.6868824", 
        "longitude": "-49.2647885"
    }
}
```

##### Response

```sh
status: 204 no_content
```

```sh
Content-Type: "application/json"
```

##### Errors
Status | Error      |
------ | -----------|
404    | Not Found  |

### Flag Survivor as Infected

##### Request 

```sh
POST   /survivors/:id/flag_infection
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "message": "Attention! Survivor was reported as infected x time(s)!"
    "message": "Warning! Survivor was reported as infected x time(s)"
}
```

##### Errors
Status | Error      |
------ | -----------|
404    | Not Found  |


### Trade Resources

Survivors can trade items among themselves, respecting a price table.

##### Request 

```sh
POST   /trade_resources
```

```sh
Parameters:
{
  "trade": {
    "survivor_1": {
      "id": "5991814f2a43166a43c27b48",
      "resources": [
        {
          "type": "Water",
          "quantity": 1
        },
        {
          "type": "Medication",
          "quantity": 1
        }
      ]
    },
    "survivor_2": {
      "id": "5991814f2a43166a43c27b4b",
      "resources": [
        {
          "type": "Ammunition",
          "quantity": 6
        }
      ]
    }
  }
}
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "message": "Trade successfully completed"
}
```

##### Errors
Status | Error                | Message
------ | ---------------------|--------
404    | Not Found            | Survivor with id xxxxx does not exist 
409    | Conflict             | Survivor X is infected
409    | Conflict             | Survivor X doesn't have enough resources
409    | Conflict             | Resources points is not balanced both sides


## Reports

### Percentage of infected survivors

##### Request 

```sh
GET   /reports/infected_survivors
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "data": "X%"
}
```

## Testing with RSpec

The project was build with TDD (Test Driven Development). To execute the tests just run the tests with RSpec.

1. Execute all tests

    ~~~ sh
    $ bundle exec rspec
    ~~~

To see the test cover percent open the file `coverage/index.html` at your browser.

## Credits

- [Cleiviane](https://about.me/cleiviane) (last survivor who knows how to code) 
