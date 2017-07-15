package main 

import (
	"fmt"
	"math"
	"welcome"
	"log"
	"os"
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

	myFunction()

	fmt.Println(add(1,2))
	fmt.Println(subtract(1,2))

	squareRoot, err := squareRoot(9)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(squareRoot)

	fileInfo, _ := os.Stat("existent.txt")
	fmt.Println("size of existent.txt = ",fileInfo.Size())

	fileInfo, error := os.Stat("nonexistent.txt")
	if error != nil {
		fmt.Println(error)
	} else {
		fmt.Println("size of existent.txt = ",fileInfo.Size())
	}

	for i := 1; i <= 3; i++ {
		fmt.Println(i)
	}

	if true {
		fmt.Println("true")
	}

	if false {
		fmt.Println("false")
	}

	if 1 < 2 {
		fmt.Println("1 < 2")
	}

	if 1 > 2 {
		fmt.Println("1 > 2")
	}

	if true && true {
		fmt.Println("true && true")
	}

	if true || false {
		fmt.Println("true || false")
	}

	if true {
		fmt.Println("true")
	} else if false {
		fmt.Println("false")
	} else {
		fmt.Println("else")
	}

	doorNumber := 1
	switch doorNumber {
	case 1:
		fmt.Println("a new car!")
		fallthrough
	case 2:
		fmt.Println("a llama!")
	default:
		fmt.Println("a goat!")
	}

}

func myFunction() {
	fmt.Println("Running myFunction")
}

func ExportedFunction() {

}

func unexportedFunction() {

}

func add(a float64, b float64) (sum float64) {
	return a + b
}

func subtract(a, b float64) (difference float64) {
	difference = a - b
	return
}

func squareRoot(x float64) (float64, error) {
	if x < 0 {
		return 0, fmt.Errorf("can't take square root of a negative number")
	}
	return math.Sqrt(x), nil
}