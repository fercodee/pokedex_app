## Feature: Search pokemons
As a user, i want to search pokemon by name and see results.

[Scenario] The search find valid result
[Given] a user has insert name with some matching result
[When] request query for pokemon name
[Then] system should returns pokemons in search screen

[Scnenario] Don't find any matching result