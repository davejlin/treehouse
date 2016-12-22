import re

names_file = open("names.txt", encoding="utf-8")
data = names_file.read()
names_file.close()

last_name = r'Love'
first_name = r'Kenneth'

# match vs search
# match: only for first word in string
print(re.match(last_name, data))
print(re.match(first_name, data))
# search: word can be anywhere
print(re.search(first_name, data))

phone_number = r'\d{3}-\d{4}'
phone_number_w_area_code = r'\(?\d{3}\)?-?\s?\d{3}-?\d{4}'
print(re.search(phone_number, data))
print(re.findall(phone_number_w_area_code, data))

names = r'\w*, \w+'
print(re.findall(names, data))

email = r'[-\w\d+.]+@[-\w\d.]+'
print(re.findall(email, data))

print(re.findall(r'\b[trehous]{9}\b',data, re.I))

email_not_gov = r'''
	[-\w\d+.]+
	@
	[-\w\d.]+
	[^gov\t]+
'''
print(re.findall(email_not_gov, data, re.VERBOSE|re.I))

entry = r'''
   ^(?P<name>(?P<last>[-\w ]*),\s(?P<first>[-\w ]+))\t             # Last and first names
	(?P<email>[-\w\d.+]+@[-\w\d.]+)\t         # Email
	(?P<phone>\(?\d{3}\)?-?\s?\d{3}-\d{4})?\t # Phone
	(?P<job>[\w\s]+,\s[\w\s.]+)\t?            # Job and company
	(?P<twitter>@[\w\d]+)?$                   # Twitter
'''

first_entry = re.search(entry, data, re.X|re.M)

print(first_entry)
print(first_entry.groupdict())

compiled = re.compile(entry, re.X|re.M)
print(re.search(compiled, data).groupdict())
print(compiled.search(data).groupdict())

for match in compiled.finditer(data):
	print('\n')
	print(match.group('name'))
	print('{first} {last} <{email}>'.format(**match.groupdict()))
