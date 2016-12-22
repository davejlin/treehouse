temperatures = [
    37,
    0,
    25,
    100,
    13.2,
    29.9,
    18.6,
    32.8
]


def c_to_f(temp):
    """Returns Celsius temperature as Fahrenheit"""
    return temp * (9/5) + 32

def is_good_c(temp):
    return temp >= 9 and temp <= 32.6

# As an American, I don't understand Celsius temperatures. 
# Using c_to_f and a list comprehension, create a variable named good_temps. 
# Convert each Celsius temperature into Fahrenheit, but only if the Celsius temperature is between 9 and 32.6.

good_temps = [c_to_f(temp) for temp in temperatures if is_good_c(temp)]

print(good_temps)