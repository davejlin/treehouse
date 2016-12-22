from functools import partial

prices = [
    10.50,
    9.99,
    0.25,
    1.50,
    8.79,
    101.25,
    8.00
]


def discount(price, amount):
    return price - price * (amount/100)

# Use partial to make a version of discount that applies a 10% discount. 
# Name this partial function discount_10.

discount_10 = partial(discount, amount=10)

# Follow that same pattern to make discount_25 and discount_50 with 
# 25% and 50% discounts each.

discount_25 = partial(discount, amount=25)
discount_50 = partial(discount, amount=50)

prices_10 = list(map(discount_10, prices))
prices_25 = list(map(discount_25, prices))
prices_50 = list(map(discount_50, prices))

print("\n0 percent discount: ", prices)
print("\n10 percent discount: ", prices_10)
print("\n25 percent discount: ", prices_25)
print("\n50 percent discount: ", prices_50)