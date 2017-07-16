package main

import "fmt"

type Minutes int
type Hours int
type Weight float64
type Title string
type Answer bool

func main() {
	minutes := Minutes(1)
	hours := Hours(2)
	weight := Weight(145.5)
	name := Title("The Matrix")
	answer := Answer(true)
	fmt.Println(minutes, hours, weight, name, answer)
}