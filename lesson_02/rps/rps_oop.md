# OOP Rock Paper Scissors

### Steps of OOP
  1. Write a textual description of problem or exercise
  2. Extract the major nouns and verbs from description
  3. Organize and associate the verbs with the nouns
    - Nouns > Classes
    - Verbs > behaviors or methods

***OR***

  1. Organize and modularize code into classes
  2. Use objects to orchestrate program flow.

## Textual Description

Rock, Paper, Scissors is a two-player game where each player chooses one of three possible moves: rock, paper, or scissors. The chosen moves will then be compared to see who wins, according to the following rules:

  - rock beats scissors
  - scissors beats paper
  - paper beats rock

If the players chose the same move, then it's a tie.

## Nouns and Verbs

1. Identify Major Nouns and Verbs
2. Organize and Associate Verbs with Nouns
3. Nouns are Classes, Verbs are Behaviors or Methods
4. Do a spike to explore the problem
5. Model your thoughts into CRC Cards

Noun: Player (Player 1, Player 2)
  - Verb: Choose Move

Noun: Move (Rock, Paper, or Scissors)

Noun: Rule (3 total)

Noun: Game Master???
  - Verb: Compare Moves

## Design Choice 1

>is this design, with Human and Computer sub-classes, better? Why, or why not?
Creates subclasses `Human` and `Computer` which inherit from `Player`. Subclasses should implement their own version of `set_name` and `choose`. This is an improvement because it simplifies the logic and removes the `is human?` conditional expression. Only the common general logic remains in the superclass. The `player_type` attribute is no longer necessary.

> what is the primary improvement of this new design?
This code demonstrates polymorphism because `Player` and `Computer` respond to the same methods `set_name` and `choose` in different ways.

> what is the primary drawback of this new design?
More classes to keep track of.