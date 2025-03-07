# Verna back-end coding challenge

This repo is the basis for one of the coding exercises for applicants to engineering job vacancies at [Verna]. This exercise emphasises back-end coding. By "back-end", we're looking at:

- problem analysis
- data modelling
- data ingest processing
- API design

The goal of this exercise is to give us an idea of your coding style, and something to discuss during the technical part of the interview. We'd hope for this exercise to take something in the region of three or four hours. We won't be checking, but please - don't spend your entire weekend on this challenge. It's not necessary to meet the goals of the interview process, and, frankly, you've got much more interesting things to do in your free time! It's fine to submit an incomplete solution with notes on what you would do with more time.

## The brief

We want to help people to make use of food growing spaces effectively, for resilience and to increase biodiversity. So we have decided to create a product to help people plan a vegetable garden. The MVP of the product will allow users to submit a planting plan, and get some analysis back on the suitability of the design.

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
3. Provide an API endpoint for creating a new garden, by accepting a collection of vegetable bed descriptions. The bed descriptions will be lines of a CSV, one line per bed. The return value should either acknowledge the created beds, or an error if the bed descriptions cannot be processed.
4. Provide an API endpoint for storing a planting plan. The planting plan will consist of a CSV file, one line per plant type. The return value should be either acknowledge the created plan, or an error if the planting plan cannot be processed.
5. Provide an API endpoint to get a score for a plan, given a plan identifier. The score is an average of the scores for each bed in the plan. A single bed’s score is calculated by:
    - the base score is 10
    - add one for each plant that is planted alongside a beneficial companion
    - add one if the bed is fully planted (i.e. the area of the bed equals the summed areas of the planted vegetables)
    - deduct one for each plant that is not planted in its preferred soil type
    - any bed with an error automatically returns 0
6. Create a file `todo.md` listing anything you would like to improve or do differently, but didn't have the time to do in this exercise. Please also include some brief hints for future engineers on possible extensions to the data model, security concerns, etc.

## Not required

- any UI
- authentication

## Example data

There's some [example data] to help you get started. It's **OK to change or extend the example data files** if you want to.

## Implementation technology

We're using Elixir and Phoenix as the core of our stack at Verna, so that is the preferred choice. However, if you would really prefer to work in another language or framework, that's OK (but let us know ahead of time please).

Your solution should include instructions on how to build, launch and test your version of the app.

## How we'll evaluate your solution

The key goal for this exercise is for you to show us how you think about, design, write and test code. There are a lot of moving pieces to this challenge. It's OK to do less of it in the time available, and focus on showing your best work. In fact, we'd prefer that you do some of it really well, than complete all of it but in rush and by cutting corners. Think about what skills you want to be able to demonstrate. As to what to leave out and what to include, that's up to you.

In terms of evaluation, we want you to show how you can create clean, clear implementations that would allow you and your colleagues to develop, ship and maintain effective, usable features over the long term.

## And lastly

We can't check if you use AI tools like Copilot or GPT to complete this challenge, but please don't. That's not the way that we work at Verna. And we will want to discuss your design choices with you!

Once you have completed the exercise, please either create a PR against the repo, or send your hiring manager a `zip` or `tar` archive of your project.

Good luck!
🥦 🥕 🧄

[example data]: ./example-data/
[Verna]: https://verna.earth
