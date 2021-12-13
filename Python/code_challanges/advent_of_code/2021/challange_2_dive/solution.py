with open('input.txt','r') as file:
    input_data=file.readlines()
    input_data=[line.split() for line in input_data]
    for line in input_data:
        line[1]=int(line[1])

depth=0
horizontal=0

for line in input_data:
    if line[0]=='forward':
        horizontal+=line[1]
    if line[0]=='down':
        depth+=line[1]
    if line[0]=='up':
        if depth > line[1]:
            depth-=line[1]
        else:
            depth=0

print(depth*horizontal)