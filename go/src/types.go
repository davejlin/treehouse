package main

import (
	"fmt"
	"strings"
)

type Minutes int
type Hours int
type Weight float64
type Title string
type Answer bool

func main() {
	minutes := Minutes(1)
	hours := Hours(2)
	weight := Weight(145.5)
	name := Title("the matrix")
	answer := Answer(true)
	fmt.Println(minutes, hours, weight, name, answer)

	fmt.Println(name.FixCase())

	for i := 1; i <= 3; i++ {
		minutes.Increment()
		fmt.Println(minutes)
	}
}

func (t Title) FixCase() string {
	return strings.Title(string(t))
}

func (m *Minutes) Increment() {
	*m = (*m + 1) % 60
}