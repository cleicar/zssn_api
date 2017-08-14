# ZSSN (Zombie Survival Social Network)

ZSSN Is a system created to help the human to survive an apocalypse zombie. Using only REST API requests, survivors can share resources with others non-infected humans.

Project created as part of [Codeminer 42](http://www.codeminer42.com/) recruit process.

## Table of Contents

* [Installation](#installation)
* [API Documentation](#api-documentation)
  * [List Survivors](#list-survivors)
  * [Add Survivors](#add-survivors)
  * [Update Survivor Location](#update-survivor-location)
  * [Flag survivor as infected](#flag-survivor-as-infected)
  * [Trade items](#trade-items)
* [Testing with RSpec](#testing-with-rspec)

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



## Credits

- [Cleiviane](https://about.me/cleiviane) (last survivor who knows how to code) 
