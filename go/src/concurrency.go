package main 

import (
	"fmt"
	"time"
	"math/rand"
)

func longTask() {
	fmt.Println("Starting long task")
	time.Sleep(3 * time.Second)
	fmt.Println("Long task finished")
}

func longTaskRandom(channel chan int) {
	delay := rand.Intn(5)
	fmt.Println("Staring long task")
	time.Sleep(time.Duration(delay) * time.Second)
	fmt.Println("Long task finished")
	channel <- delay
}

func main() {
	// go longTask()
	// go longTask()
	// go longTask()
	// time.Sleep(4 * time.Second)

	rand.Seed(time.Now().Unix())
	channel := make(chan int)
	for i := 1; i <= 3; i++ {
		go longTaskRandom(channel)
	}

	for i := 1; i <= 3; i++ {
		fmt.Println("Took", <-channel, "seconds")
	}
}