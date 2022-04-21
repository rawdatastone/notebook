This is to represent resource distribution progression. Theory is that resources accumulate, naturally, in a small group of people. Even when completely random this should still hold. This is to attempt to illustrate this theory.
Scenario:
    Start with 100 people and give each, 10 units 
    Allow them to trade with one another, randomly. 
    trade results with one person giving a unit to anoher. 

Each Turn should produce a summary so results can be stored and then reported. Each turn can end wit a simple bar char update. The result should be an animated bar chart. 

it could also be interesting to randomly create trading pairs and not have everyone trading per turn. this could illustrate some people are less active than others 

index_list(0:99)
2 rand pop from list where recource >= 1
use these to return a person record 
rand select which one gets an resource and adjust their entries 
    this does not keep history 
    instead maybe keep a turn counter
        with each turn add a new entry to persons dictionary to reflect their resource state
        or resources can be a list instead of an int 

how to determine next turn? when more than 1 person has resources (latest) >= 1
resources_history & current_resources 


start wit 2?

