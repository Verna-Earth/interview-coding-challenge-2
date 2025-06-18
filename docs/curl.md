# Happy path
### Create garden
```sh
curl --request POST \
  --url http://localhost:4000/api/gardens/create \
  --header 'content-type: application/json' \
  --data '{
  "beds": [
    {
      "x": 0,
      "y": 0,
      "width": 250,
      "length": 180,
      "soil_type": "chalk"
    },
    {
      "x": 250,
      "y": 300,
      "width": 300,
      "length": 300,
      "soil_type": "loam"
    }
  ]
}'
```

### Create plan
```sh
curl --request POST \
  --url http://localhost:4000/api/plans/create \
  --header 'content-type: application/json' \
  --data '{
  "name": "plan1",
  "garden_id": 1,
  "beds": [
    [
      {
        "plant": "tomato",
        "area": 250
      },
      {
        "plant": "onion",
        "area": 900
      }
    ],
    [
      {
        "plant": "carrot",
        "area": 1000
      },
      {
        "plant": "pea",
        "area": 1000
      }
    ]
  ]
}'
```

### Score said plan
```sh
curl --request GET \
  --url http://localhost:4000/api/plans/score/plan1
```

# Errors - Garden
### Create with overlap
Note: This currently will not error as the code does not work
```sh
curl --request POST \
  --url http://localhost:4000/api/gardens/create \
  --header 'content-type: application/json' \
  --data '{
  "beds": [
  {
    "x": 100,
    "y": 200,
    "width": 250,
    "length": 180,
    "soil_type": "chalk"
  },
  {
    "x": 250,
    "y": 300,
    "width": 300,
    "length": 300,
    "soil_type": "loam"
  }
]}'
```

### Bad schema in request
```sh
curl --request POST \
  --url http://localhost:4000/api/gardens/create \
  --header 'content-type: application/json' \
  --data '{
  "beds": [
    {
      "x": 100,
      "y": 100,
      "width": 250,
      "not-a-field-length": 180,
      "soil_type": "chalk"
    },
    {
      "x": 250,
      "y": 300,
      "width": 300,
      "not-a-field-length": 300,
      "soil_type": "loam"
    }
  ]
}'
```

# Errors - Plan
### Plan is too big to fit in garden
```sh
curl --request POST \
  --url http://localhost:4000/api/plans/create \
  --header 'content-type: application/json' \
  --data '{
  "name": "plan1",
  "garden_id": 1,
  "beds": [
    [
      {
        "plant": "tomato",
        "area": 250000000000
      },
      {
        "plant": "onion",
        "area": 900
      }
    ],
    [
      {
        "plant": "carrot",
        "area": 1000
      },
      {
        "plant": "pea",
        "area": 1000
      }
    ]
  ]
}'
```

### Bad schema in request
```sh
curl --request POST \
  --url http://localhost:4000/api/plans/create \
  --header 'content-type: application/json' \
  --data '{
  "not-name": "plan1",
  "garden_id": 1,
  "beds": [
    [
      {
        "plant": "spinach",
        "area": 250
      },
      {
        "plant": "tomato",
        "area": 900
      }
    ],
    [
      {
        "plant": "garlic",
        "area": 1000
      },
      {
        "plant": "onion",
        "area": 1000
      }
    ]
  ]
}'
```