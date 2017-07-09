package main 

import (
	"fmt"
	"github.com/golang/example/stringutil"
)

func main() {
	fmt.Println("Hello world!")
	fmt.Println(otherFuction())
}

func otherFuction() string {
	return stringutil.Reverse("Hello world!")
}