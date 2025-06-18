# Stakeholder facing objective
> We want to help people to make use of food growing spaces effectively, for resilience and to increase biodiversity.

# Instructions on running the project
```sh
cd verna
mix deps.get
iex -S mix phx.server
```

Now go to http://localhost:4000/ and click the button to create the database and run migrations.

The /docs folder has examples on how to run the api commands.

# Pre-start thoughts
- We will likely need to be easily able to extend the list of plants
- We will likely need to be easily able to extend the list of soils
- Keep in mind we are not going to worry about (but may want to at a future date):
  - Time of when plants are sown
  - Time of when plants are harvested
- The model of plants and soil is liable to change, it is unclear if this is purely the list of plants will change or the core data structure will change
  - Assume the latter and put interfaces in to provide a layer of separation between the code handling the data and code looking to use it, we can later change these to convert it to a different format on call
- Beds are measured in metres but use cm for actual size granularity

# Tasks
## 1 - Data model
We'll be tracking plans and beds within said plans. Many to one relationship between them.
```
mix phx.gen.json Planting Garden gardens
mix phx.gen.json Planting Bed beds x:integer y:integer width:integer length:integer soil_type:string garden_id:integer
```

## 2 - Import JSON
Thinking ETS cache (via Cachex) to store the data. Reference at stage 6 how we'd go about dynamically updating this without restarting the app.

## 3 - Creating garden layout
Need to define a json schema for the request. I can use the same code/pattern from my Angen project.

## 4 - Creating a planting plan
`mix phx.gen.json Planting Plan plans name:string contents:jsonb cached_score:integer`

## 5 - Getting the score of a plan
Pipeline of composable functions seems like the best way to implement this while also making it easy to extend.

## 6 - TODO
- Multiple plots
- Updating background knowledge data without restarting app
- Telemetry
- Logging
- API docs
- Docs on how to extend the scoring functionality