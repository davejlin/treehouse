package main

import "fmt"

func main() {
	ages := map[string]float64{}
	ages["Alice"] = 12
	ages["Bob"] = 9
	fmt.Println(ages)
	fmt.Println(ages["Alice"])
	fmt.Println(ages["Bob"])

	grades := map[string]string{"Alice": "A", "Bob": "B"}
	fmt.Println(grades)

	for name, age := range ages {
		fmt.Println(name, age)
	}
}