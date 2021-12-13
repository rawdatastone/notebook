# take input 
with open('input.txt','r') as file:
    input_data=file.readlines()
    input_data=[int(line) for line in input_data]

#previous_reading = 0
input_interpretation=[]
for reading in input_data:
    if reading > previous_reading:
        input_interpretation.append(1)
    else:
        input_interpretation.append(0)
    previous_reading=reading
# For the first reading there is no previous value so it should be empty
# input_interpretation[0]=0
print(sum(input_interpretation))