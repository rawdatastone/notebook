# take input 
with open('input.txt','r') as file:
    input_data=file.readlines()
    input_data=[int(line) for line in input_data]

previous_reading = 0
input_interpretation=[]
number_of_readings=len(input_data)

for i in range(number_of_readings-2):
    current_reading = input_data[i] + input_data[i+1] + input_data[i+2]
    if current_reading > previous_reading:
        input_interpretation.append(1)
    else:
        input_interpretation.append(0)
    previous_reading=current_reading
# For the first reading there is no previous value so it should be empty
input_interpretation[0]=0

print(sum(input_interpretation))