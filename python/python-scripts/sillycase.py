def sillycase(aString):
    half = int(len(aString)/2)
    firstHalf = aString[:half]
    lastHalf = aString[half:]
    return firstHalf.lower()+lastHalf.upper()

print(sillycase('david'))
print(sillycase('is the best kangaroo in town'))
