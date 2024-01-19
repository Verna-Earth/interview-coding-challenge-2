# Verna back-end coding challenge

This take-home coding challenge is designed for you to demonstrate your back-end coding skills. By "back-end", we're looking at:

- problem analysis
- data modelling
- data ingest processing
- API design

This challenge is intended to be completed over about four hours. It's up to you to monitor that, we won't be checking. But don't feel obliged to spend longer than that, and it's OK to submit an incomplete solution with notes on what you would do with more time.

## The brief

We want to help people to make use of food growing spaces effectively, for resilience and to increase biodiversity. So we have decided to create a product to help people plan a vegetable garden. The MVP of the product will allow people to submit a planting plan, and get some analysis back on the suitability of the design.

In our simplified model, a garden consists of one or more beds, and each bed can be planted with one or more vegetable plants. In the MVP, we're not going to worry about the time that plants are sown or harvested, though that will likely be a feature we would want to add in future.

### Background knowledge

It's important that the app can be updated with additional plant data over time. A JSON file of background knowledge about plants will be given, which will tell the app for each type of vegetable:

- the plant name
- a non-empty list of the soil types it prefers
- a possibly-empty list of "companion" plants that it benefits from being planted alongside

For example:

```json
[
  {"name": "carrot",
   "soil_type": ["sandy"],
   "benefits_from": ["leek"]
  }
]
```

### Beds

A bed is a rectangular area of ground, with a top-left origin `(x, y)`, a width `w` in metres and a length `l` in metres.

A given bed is assumed to have a single soil type.

Beds may be adjacent, but should not overlap.

Once added to the application, a bed will be known by some identifier.

### Planting plan

A planting plan will associate one or more plant types with a given bed. Each entry in the incoming planting plan will list:

- the bed
- the plant name
- the area to be planted in metres-squared

## The tasks

1. Create a data model for the application in a relational database such as PostgreSQL. It is up to you whether to create migration files, or manually create the database (as long as you give instructions, including SQL commands, for us to recreate your database layout)
2. Import the background-knowledge JSON file. You can choose whether to keep the background knowledge in memory, or store it in the database.
3. Create an endpoint for creating a new garden, by accepting a collection of vegetable bed descriptions. The bed descriptions will be lines of a CSV, one line per bed. The return value should either acknowledge the created beds, or an error if the bed descriptions cannot be processed.
4. Create an endpoint for storing a planting plan. The planting plan will consist of a CSV file, one line per plant type. The return value should be either acknowledge the created plan, or an error if the planting plan cannot be processed.
5. Create an endpoint to get a score for a plan, given a plan identifier. The score is an average of the scores for each bed in the plan. A single bed’s score is calculated by:
    - the base score is 10
    - add one for each plant that is planted alongside a beneficial companion
    - add one if the bed is fully planted (i.e. the area of the bed equals the summed areas of the planted vegetables)
    - deduct one for each plant that is not planted in its preferred soil type
    - any bed with an error automatically returns 0
6. Create a file `security.md`, with some **brief** suggestions for future engineers on securing the use of the application
7. Create a file `todo.md` listing anything you would like to improve or do differently, but didn't have the time to do in this exercise. Please also include some brief hints for future engineers on the challenges of adding seasonality to the data model (i.e. for each plant type, some idea of when in the year it should be planted and when harvested).

## Not required

- any UI
- authentication

## Implementation technology

We're using Elixir and Phoenix as the core of our stack at Verna, so that's an obvious choice. However, if you would prefer to work in another language or framework, that's OK.

Your solution should include instructions on how to build, launch and test your version of the app.

We can't check if you use AI tools like Copilot to complete this challenge, but please don't. That's not the way that we work. And we will want to discuss your design choices with you!

Once you have completed the exercise, please either create a PR against the repo, or send your hiring manager a `zip` or `tar` archive of your project.

Good luck!
🥦 🥕 🧄
