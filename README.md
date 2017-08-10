# ZSSN (Zombie Survival Social Network)

ZSSN Is a system created to help the human to survive an apocalypse zombie. Using only REST API requests, survivors can share resources with others non-infected humans.

Project created as part of [Codeminer 42](http://www.codeminer42.com/) recruit process.

## Table of Contents

* [Installation](#installation)
* [API Documentation](#api-documentation)
  *[List Survivors](#list-survivors)
  * [Add survivors](#add-survivors)
  * [Update survivor location](#update-survivor-location)
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

Content-Type: "application/json"

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

## Credits

- [Cleiviane](https://about.me/cleiviane) (last survivor who knows how to code) 
