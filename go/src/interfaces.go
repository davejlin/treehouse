package main 

import "fmt"

type Vehicle interface {
	NWheels
	NDoors
	Transmission
}

type Car struct {
	NWheels int
	NDoors int
	Transmission string
}

type Bicycle struct {
	NWheels int
	NDoors int
	Transmission string
}

func main() {

	aCar := Car{4, 2, "manual"}
	aBike := Bicycle(2, 0, "caliper")

	Description(aCar)
	Description(aBike)
}

func Description(vehicle Vehicle) {
	fmt.Println("number of wheels: " + vehicle.NWheels + "\n" + "number of doors: " + vehicle.NDoors + "\n" + "transmission" + vehicle.transmission)
}