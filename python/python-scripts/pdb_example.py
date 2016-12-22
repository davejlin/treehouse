# pdb console commands
# n = next
# c = continue
# s = step into
# r = return
# q = quit
# ENTER = repeat last command

import pdb

def a_func():
	a = "AAA"
	b = "BBB"
	c = "CCC"
	return a + b + c

a = "aaa"
pdb.set_trace()
b = "bbb"
c = "ccc"

final = a + b + c
func_value = a_func()

print(final)
print(func_value)