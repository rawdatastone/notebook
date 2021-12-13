with open('input.txt','r') as file:
    input_data=file.readlines()
    input_data=[line.split() for line in input_data]
    
    for line in input_data:
        line[1]=int(line[1])

depth=0
horizontal=0
aim=0

def down(x):
    global aim 
    aim +=  x


def up(x):
    global aim 
    aim -= x


def forward(x):
    global horizontal 
    global depth 

    horizontal += x
    depth = depth + (x * aim)


for line in input_data:
    if line[0]=='forward':
        forward(line[1])
    if line[0]=='down':
        down(line[1])
    if line[0]=='up':
        up(line[1])

print('depth: ', depth)
print('horizontal: ', horizontal)
print('aim: ', aim)
print('solution: ', horizontal*depth)