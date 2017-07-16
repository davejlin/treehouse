package main

import "fmt"

func main() {
	a := [5]int{0,1,2,3,4}
	s1 := a[0:3]
	s2 := a[2:5]
	s2[0] = 88
	fmt.Println(a, s1, s2)
	s2 = append(s2, 5)
	fmt.Println(a, s1, s2)
	fmt.Println(len(a), cap(s2))
	s2[0] = 888
	fmt.Println(a, s1, s2)

	for i, v := range a {
		fmt.Println("element:", i, "value", v)
	}
}