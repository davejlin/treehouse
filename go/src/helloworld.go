package main 

import (
	"fmt"
	"github.com/golang/example/stringutil"
	"reflect"
	"net"
	"time"
)

func main() {
	fmt.Println("Hello world!")
	fmt.Println(otherFuction())
	fmt.Println(reflect.TypeOf(1))
	fmt.Println(reflect.TypeOf(1.0))
	fmt.Println(reflect.TypeOf("1.0"))
	fmt.Println(reflect.TypeOf(true))
	fmt.Println(reflect.TypeOf(net.IPv4(127, 0, 0, 1)))
	fmt.Println(reflect.TypeOf(time.Now()))
}

func otherFuction() string {
	return stringutil.Reverse("Hello world!")
}