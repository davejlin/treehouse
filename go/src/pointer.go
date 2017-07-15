package main 

import "fmt"

func main() {
	var aValue float64 = 1.23
	var aPointer *float64 = &aValue
	fmt.Println("aPointer", aPointer)
	fmt.Println("*aPointer", *aPointer)

	myNumber := 2.6
	halve(&myNumber)
	fmt.Println("In main, myNumber = ", myNumber)

	car := Car {
		Doors: 4,
		Transmission: "automatic",
		Odometer: 36000,
	}

	describe(&car)
}

func halve(number *float64) {
	*number = *number / 2
	fmt.Println("In halve, *number = ", *number)
}

func describe(c *Car) {
	fmt.Println("A", c.Doors, "doors")
	fmt.Println(c.Transmission, "car")
	fmt.Println("with", c.Odometer, "miles")
}

type Car struct {
	Doors int
	Transmission string
	Odometer int
} 