import json
from operator import attrgetter, itemgetter
from copy import copy
from functools import partial, reduce

class Book:
    def __init__(self, **kwargs):
        for k, v in kwargs.items():
            setattr(self, k, v)

    def __str__(self):
        return self.title
    
    def __repr__(self):
        return str(self)
    
    
def get_books(filename, raw=False):
    try:
        data = json.load(open(filename))
    except FileNotFoundError:
        return []
    else:
        if raw:
            return data['books']
        return [Book(**book) for book in data['books']]
    
BOOKS = get_books('books.json')
RAW_BOOKS = get_books('books.json', raw = True)

### SORTED ###
# sorted, itemgetter, attrgetter
a_list = [5, 3, 1, 2, 4]
a_list_sorted = sorted(a_list)

print("\na_list: {}".format(a_list))
print("a_list sorted: {}".format(a_list_sorted))

# sort dictionary by publish_date value
pub_itemgetter = itemgetter('publish_date')
pub_sorted_dict = sorted(RAW_BOOKS, key=pub_itemgetter)
pub_sorted_list = list(map(pub_itemgetter, pub_sorted_dict))
print("\nRAW_BOOKS sorted by publish_date: {}".format(pub_sorted_list))

# sort objects by number_of_pages attribute
pages_attrgetter = attrgetter('number_of_pages')
pages_sorted_objects = sorted(BOOKS, key=pages_attrgetter)
pages_sorted_list = list(map(pages_attrgetter, pages_sorted_objects))
print("\nBOOKS sorted by number_of_pages: {}".format(pages_sorted_list))

### MAP ###
def sales_price(book):
	# Apply a 20% discount to the book's price
	book = copy(book)
	book.price = round(book.price - (book.price * 0.2), 2)
	return book

sales_books = list(map(sales_price, BOOKS))
price_attrgetter = attrgetter('price')
prices_list = list(map(price_attrgetter, BOOKS))
sales_list = list(map(price_attrgetter, sales_books))
print("\nBOOKS normal prices: {}".format(prices_list))
print("\nBOOKS sales prices: {}".format(sales_list))

# use list comprehensions:
sales_books_c = [sales_price(book) for book in BOOKS]
sales_list_c = list(map(price_attrgetter, sales_books_c))
print("\nBOOKS sales prices using list comprehension: {}".format(sales_list_c))

### FILTER ###
def is_long_book(book):
	return book.number_of_pages >=600

long_books = list(filter(is_long_book, BOOKS))
title_attrgetter = attrgetter('title')
long_books_list = list(map(title_attrgetter, long_books))
long_books_pages_list = list(map(pages_attrgetter, long_books))
long_books_title_pages = list(zip(long_books_list, long_books_pages_list))
print("\nLong book titles and pages: {}".format(long_books_title_pages))

# use filter comprehensions:
long_books_c = [book for book in BOOKS if is_long_book(book)]
print("\nLong book titles using filter comprehensions: {}".format(long_books_c))

### CHAINING ###
def is_cheap(book):
	return book.price <= 5

def title_case(book):
	book = copy(book)
	book.title = book.title.title()
	return book

cheap_books_on_sale = list(
	sorted(
		map(title_case, 
		filter(is_cheap, 
		map(sales_price, BOOKS))), 
		key=price_attrgetter))

cheap_books_prices = list(map(price_attrgetter, cheap_books_on_sale))
cheap_books_and_prices_list = list(zip(cheap_books_on_sale, cheap_books_prices))
print("\nCheap books on sale: {}".format(cheap_books_and_prices_list))

### PARTIALS ###
def mark_down(book, discount):
	book = copy(book)
	book.price = round(book.price-book.price*discount, 2)
	return book

standard_discount = partial(mark_down, discount = .2)
standard_discount_books = list(map(standard_discount, BOOKS))
standard_discount_books_prices = list(map(price_attrgetter, standard_discount_books))
print("\nStandard discounted books prices: {}".format(standard_discount_books_prices))

half_discount = partial(mark_down, discount = .5)
half_discount_books = list(map(half_discount, BOOKS))
half_discount_books_prices = list(map(price_attrgetter, half_discount_books))
print("\nHalf price discounted books prices: {}".format(half_discount_books_prices))

### REDUCE ###
### LAMBDA ###
number_list = list(range(101))
sum = reduce(lambda x,y: x+y, number_list)
print("\nSum of numbers: ", number_list, " is: ", sum)

### CURRYING ###
def curried_f(x, y=None, z=None):
	def f(x,y,z):
		return x**3 + y**2 + z

	if y is not None and z is not None:
		return f(x, y, z)

	if y is not None:
		return lambda z: f(x, y, z)

	return lambda y, z=None: (
		f(x, y, z) if (y is not None and z is not None)
	else (lambda z: f(x, y, z)))

print("\ncurried_f with 3 real values: ", curried_f(2,3,4))
g = curried_f(2)
print("\ncurried_f with x: ", g)
h = g(3)
print("\ncurried_f with x, y: ", h)
i = h(4)
print("\ncurried_f with x, y, z: ", i)
