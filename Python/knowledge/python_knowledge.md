# Python knowledge reference notes 

## Table of Contents
- [Python knowledge reference notes](#python-knowledge-reference-notes)
  - [Table of Contents](#table-of-contents)
- [Data Types](#data-types)
    - [Strings](#strings)
      - [Formatting](#formatting)
        - [Old School](#old-school)
        - [.format()](#format)
        - [f-strings](#f-strings)
    - [Collections](#collections)
      - [Counter](#counter)
      - [Namedtuple](#namedtuple)
      - [OrderedDict](#ordereddict)
      - [defaultdict](#defaultdict)
      - [deque](#deque)
    - [Itertools](#itertools)
      - [product](#product)
      - [permutations](#permutations)
      - [combinations](#combinations)
      - [accumulate](#accumulate)
      - [groupby](#groupby)
   


# Data Types

### Strings 
ordered, immutable text representation

#### Formatting
``` pyrhon
var="Stargate"
```
##### Old School
``` python
my_string="The variable is %s" % var
```

%s - for strign

%d - integer decimal value

%f - floating point value (6 digits after decimal, by default). Can format like:
``` python
var=3.141592653589793238462643
my_string="The variable is %.2f" % var
```

##### .format()
``` python
my_string="The variable is {} and {:.2f}".format(var1,var2)
```

##### f-strings 
since python 3.6
``` python
var1=3.141592653589793238462643
var2= 42
my_string=f"The pi is {var} and The Answer is {var2}"
```
### Collections 
Counter, namedtuple, OrderedDict, defaultdict, deque


#### Counter 
stores elements as dictionary keys and their counts as values
``` python
from collections import Counter
a = "aaaaaabbbbbbcccc"
my_counter=Counter(a)
```
return the n most common elements as a list of tuples 
``` python
from collections import Counter
a = "aaaaaabbbbbbcccc"
n=1
my_counter=Counter(a)
print(my_counter.most_common(n))
```
to just return the element (key)
``` python
print(my_counter.most_common(n)[0][0])
```
can also return an iterable of all the elements being counted as they are counted 
``` python
print(list(my_counter.elements()))

```

#### Namedtuple
object type simillar to struct 

``` python 
from collections import namedtuple
Point=namedtuple('Point','x,y')
pt=Point(4,2)
```
result:
```
Point(x=4, y=2)
```
``` python 
...
pt=Point(4,2)
print(pt.x, pt.y)
```

#### OrderedDict
Just like a dictionary but ordered by order of insertion, duh! (as of python 3.7 this is guarateed in the regular dictionary)
``` python 
from collections import OrderedDictionary
oredred_dict=OrderedDictionary()
oredred_dict['a']=1
oredred_dict['b']=2
oredred_dict['c']=3
oredred_dict['d']=4
oredred_dict['e']=5
oredred_dict['f']=6
```

#### defaultdict
similar to regular dict(), with the difference that it will have a default value if a key has none
``` python 
from collections import defaultdict
#declare type of the default value 
d=defaultdict(int) #float, list 
d['a']=1
d['b']=2

print(d['c']) # will return a 0, 0.0, empty list, etc.
```

#### deque
double ended que. Can add or remove elements from both ends 
``` python 
from collections import deque
d=deque()
d.append(1)
d.append(2)
# result: [1,2]
d.appendleft(3)
# result: [3,1,2]
d.pop()
# result: [3,1]
d.popleft()
#result: [1]
d.clear() # removes all elements 
# result: []
d.extend(4,5,6) 
# result: [4,5,6]
d.extendleft(-1,-2,-3) # pay attention to order of insertion!
# result: [-3,-2,-1,4,5,6]
d.rotate(1)
# result [[-2,-1,4,5,6,-3]]
d.rotate(-2)
# result [[5,6,-3,-2,-1,4]]
```
### Itertools
set of tools to operate on iterators 
#### product 
cartesian product of iterables

#### permutations
#### combinations
#### accumulate
#### groupby 

