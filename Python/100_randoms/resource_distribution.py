from asyncio import current_task
from random import randint, randrange
from dataclasses import dataclass

# setup parameters 
# TODO argparse
# number of participants
mob_size = 20
initial_cash = 100
drop_condition = -1
max_turns = 1000

# List of people to partake 
# Two use cases: 
#   1. Drop people once they loose money
#   2. Keep all people
# Initialise participants [id, balance]
list_of_participants = [[n,initial_cash] for n in range(mob_size)]

print(f'List Of Participants: \n {list_of_participants}')

current_turn=0 

while current_turn  < max_turns:
    current_turn += 1
    print(f'Turn: {current_turn}/{max_turns}')
    current_turn_participants = list(list_of_participants)
    #Select a pair to exchange money
    while len(current_turn_participants) > 1:
        person1 = current_turn_participants.pop(randrange(0,len(current_turn_participants)))[0]
        person2 = current_turn_participants.pop(randrange(0,len(current_turn_participants)))[0]
        #print(f'Pair: {person1}:{person2}\n')
        if list_of_participants[person1][1] > 0 and list_of_participants[person2][1] >0:
            list_of_participants[person1][1]-=1
            list_of_participants[person2][1]+=1
    print(f'\n{list_of_participants}')

        


    
    # display chart









    # with open('100_   names.txt','r') as f:
    #     names=f.readlines()
    #     names=[name.replace('\n','') for name in names]

    # class Person:
    #     def __init__(self, name, resources):
    #         super().__init__()
    #         self.name=name
    #         self.resources=resources
        
    #     def take_resources(self,resource):
    #         '''increase resources by 1'''
    #         self.resources+=1

    #     def give_resources(self,resource):
    #         '''decrease resources by 1'''
    #         self.resources-=1

    #     def check_resources(self):
    #         '''return resources total'''
    #         return self.resources

    # traders=[Person(name,10) for name in names]