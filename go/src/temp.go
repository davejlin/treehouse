package main 

import (
	"fmt"
	"math"
	"welcome"
)

var myNumber = 1.23

func main() {
	roundedUp := math.Ceil(myNumber)
	roundedDown := math.Floor(myNumber)
	fmt.Println(roundedUp, roundedDown)
	fmt.Println(welcome.English)

	var a int
	a = 1
	var b, c int
	b, c = 2, 3
	var d = 5
	e, f := 6, 7
	fmt.Println(a, b, c, d, e, f)

	var anInt int = 1
	var aFloat float64 = float64(anInt)
	fmt.Println(anInt, aFloat)
}