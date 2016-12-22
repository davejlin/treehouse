import unittest

from functions import *

class FunctionsTests(unittest.TestCase):
	def test_sum_safe(self):
		assert sum_safe(1,2,3,4,5) == 15
		assert sum_safe(1) == 1
		assert sum_safe(0)== 0
		assert sum_safe() == 0
		assert sum_safe(None) == 0

if __name__ == '__main__':
	unittest.main()